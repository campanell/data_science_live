library(dplyr)
library(readr)

#--------  Read UN Data  ------------------------#
UNdata <- read_delim("https://datasciencelive.com/data/UNdata.txt",delim="|")


refugees <- UNdata %>%
            select(1:4) %>%
            rename(country = 1,
                   home_country = 2,
                   year = 3,
                   refugee_count = 4)

#----------------   Running total  -----------------------------------#
canada_tally_2016 <- refugees %>%
                     filter(country == 'Canada' & year == 2016) %>%
                     arrange(desc(refugee_count)) %>%
                     mutate(total2016 = cumsum(refugee_count))

#---------------------------------------------------#
#  Compute a running percent                        #
#---------------------------------------------------#

#------------   USA Data  -------------------#
us_2016 <-  refugees %>%
            filter(country == 'United States' & year == 2016) %>%
            arrange(desc(refugee_count))

#-----------  Total USA refugees  -----------------#
total_us <- us_2016 %>%
            group_by(country) %>%
            summarise(total_us = sum(refugee_count))

us_refugees <- inner_join(us_2016,total_us,by=c("country"))

#-----------   Running percent  --------------------------------#
us_percent <- us_refugees %>%
              mutate(pct2016 = (refugee_count/total_us)*100) %>%
              mutate(run_pct_2016 = sum(refugee_count))






