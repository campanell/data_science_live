library(DBI)
library(odbc)
library(dplyr)
library(lubridate)

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

#--------   Top 20  --------------------#
top20_major <- opt %>%
               group_by(major) %>%
               summarise(top_major = n()) %>%
               top_n(20) %>%
               arrange(desc(top_major))


top20_major_degree <- opt %>%
                      group_by(major,degree) %>%
                      summarise(top_major = n()) %>%
                      arrange(desc(top_major)) %>%
                      ungroup() %>%
                      slice(1:20)

top20_university <- opt %>%
                    group_by(university) %>%
                    summarise(top_university = n()) %>%
                    top_n(20) %>%
                    arrange(desc(top_university))

top20_country <- opt %>%
                 group_by(country) %>%
                 summarise(top_country = n()) %>%
                 top_n(20) %>%
                 arrange(desc(top_country))


