library(readr)
library(dplyr)

#--------------   Read Data  --------------------------------#
consumption <- read_csv("http://datasciencelive.com/data/FAOSTAT_consumption.csv")

#--------------  Biggest consumption   ---------------------------#
top_consumption <- consumption %>%
                   select(Country, Year, Value, Unit) %>%
                   top_n(3,Value) %>%
                   arrange(desc(Value))

#---------   Biggest Consumption by Country   ------------------#
top_country_consumption <- consumption %>%
                           select(Country, Year, Value, Unit) %>%
                           group_by(Country)  %>%
                           top_n(3,Value) %>%
                           arrange(Country, desc(Value))

#-------------   Biggest consumption alternative   ---------------#
alt_top_consumption <- consumption %>%
                       select(Country, Year, Value, Unit) %>%
                       arrange(desc(Value)) %>%
                       slice(1:3)

#--------------   Biggest Consumption by Country alternative   ------------#
alt_country_consumption <- consumption %>%
                           select(Country, Year, Value, Unit) %>%
                           arrange(Country,desc(Value)) %>%
                           group_by(Country) %>%
                           slice(1:3)