library(readr)
library(dplyr)
library(stringr)

#-------------  Get Public Art Data  -------------------------#
public_art <- read_csv("http://datasciencelive.com/data/Public_Art_Data.csv")
fao_consumption <- read_csv("http://datasciencelive.com/data/FAOSTAT_consumption.csv")

#-------------  Reduce data frame   ---------------------#
art_reduce <- public_art %>%
              select(description,classification,media,location)

consumption <- fao_consumption %>%
               select(Country, Year, Value)

#------------  Library or Parks  ----------------------#
art <- art_reduce %>%
       mutate(loc_type = case_when(
         str_detect(location,"Park")==TRUE ~ "park",
         str_detect(location,"Library")==TRUE ~ "library",
         TRUE ~ "public spaces"
       ))

#------------- YoY change  --------------------------#
yoy <- consumption %>%
       arrange(Country,Year) %>%
       group_by(Country) %>%
       mutate(prev_yr = lag(Value)) %>%
       mutate(yoy_change = Value - prev_yr)


#-----------   Groupings  ------------------------#
max(consumption$Value)
consumption_groups <- consumption %>%
            mutate(groups = case_when(
            between(Value,0,10) ~ "Under 10kg",
            between(Value,10.01,20) ~ "10-20kg",
            between(Value,20.01,30) ~ "20-30kg",
            between(Value,30.01,40) ~ "30-40kg",
            between(Value,40.01,50) ~ "40-50kg",
            TRUE ~ "NA" 
  ))
