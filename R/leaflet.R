library(DBI)
library(odbc)
library(dplyr)
library(lubridate)
library(httr)
library(leaflet)

#------------------------------------------------------#
#  Need to run the 32bit of R Studio                   #
#------------------------------------------------------#

#--------  Create db connections  -------------------#
conn <- dbConnect(odbc::odbc(),dsn = "student_visa")

#-----  Write query  --------------#
query <- "Select * from SEV_STUDENT"

#------   Get all Data ---------------# 
student_visa <- dbGetQuery(conn,query)

opt <- student_visa %>%
        rename(university = SCHOOL_NAME,
              country = COUNTRY_OF_CITIZENSHIP,
              major = TITLE_OF_MAJOR_1,
              degree = LEVEL_OF_EDUCATION) %>%
        mutate(year = year(ACTUAL_EMP_START_DATE)) %>%
        select(university,country,major,degree,year)


top20_university <- opt %>%
                    group_by(university) %>%
                    summarise(top_university = n()) %>%
                    top_n(20) %>%
                    arrange(desc(top_university))

#------------------------------------------------------------#
#  Lets get longitude and latitude from Google Places API    #
#  and append them to existing data frame                    #
#------------------------------------------------------------#

#---- Initalize data frame to append API response columns  -------#
places_df <- tibble(university=character(0),opt=integer(),real_name=character(),latitude=numeric(),longitude=numeric())

#----------  Loop through top20 unversity  -----------------#
for (i in 1:nrow(top20_university)) {
  
  #------------------------------------------------------------#
  # URL encode university name for Google API query string     #
  #------------------------------------------------------------#
  placestring <- URLencode(top20_university$university[i])
  
  #--------- Prepare and send query to Google API  ------------#
  query_string <- paste0("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=",placestring,"&inputtype=textquery&fields=formatted_address,name,geometry&key=",mykey)
  resp <- GET(query_string)
  
  #-----------  Handle JSON response  ------------------------#
  resp_content <- content(resp)
  
  latitude <- resp_content$candidates[[1]]$geometry$location$lat
  longitude <- resp_content$candidates[[1]]$geometry$location$lng
  real_name <- resp_content$candidates[[1]]$name
  
  #-------  Store the current records   -------------------#
  current_df <- tibble(university=top20_university$university[i],opt=top20_university$top_university[i],real_name=real_name,latitude=latitude,longitude=longitude)

  #---------  Append data frame records   ----------------------#
  places_df <- bind_rows(places_df,current_df)
  
}   #----------  End top20 university loop  ----------------#

#-----------------------------------------------------------------#
#  Create a map which marks the location of the university and    #
#  and draw a radius around it using the number of OPT visas as   #
#  the size of the radius                                         #
#-----------------------------------------------------------------#

m <- leaflet() %>%
     addTiles() %>%
     addCircles(lng = places_df$longitude, lat = places_df$latitude, radius = places_df$opt) %>%
     addMarkers(lng = places_df$longitude, lat = places_df$latitude, popup = paste0(places_df$real_name,"</br>",places_df$opt))

m





