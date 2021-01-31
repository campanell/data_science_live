library(dplyr)
library(readr)
library(htmlwidgets)
library(plotly)

#--------  Read UN Data  ------------------------#
UNdata <- read_delim("https://datasciencelive.com/data/UNdata.txt",delim="|")


refugees <- UNdata %>%
            select(1:4) %>%
            rename(country = 1,
                   home_country = 2,
                   year = 3,
                   refugee_count = 4) %>%
            filter(year == 2016)