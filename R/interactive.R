library(dplyr)
library(readr)
library(plotly)

#--------  Read UN Data  ------------------------#
UNdata <- read_delim("https://datasciencelive.com/data/UNdata.txt",delim="|")


refugees <- UNdata %>%
            select(1:4) %>%
            rename(country = 1,
                   home_country = 2,
                   year = 3,
                   refugee_count = 4)

i_refugee <- plot_ly(data=refugees, x = ~year, y = ~refugee_count,
                     text = paste(refugees$home_country,"</br>",refugees$refugee_count),
                     color=refugees$country)
i_refugee

#----------   Before 1987   -----------------------------#
prior_87 <- refugees %>%
            filter(year <= 1987) %>%
            arrange(desc(refugee_count))

#-----------   Home country   ----------------------#
home_country <- refugees %>%
                filter(home_country != 'Various') %>%
                group_by(country,year) %>%
                top_n(10) %>%
                ungroup()

i_refugee <- plot_ly(data=home_country, x = ~year, y = ~refugee_count,
                     text = paste(home_country$home_country,"</br>",home_country$refugee_count),
                     color=home_country$country)
i_refugee
