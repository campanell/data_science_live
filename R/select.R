library(readxl)

oecd <- read_xls("C:/Users/Campanell/Downloads/oecd.xls",na="..",skip=3)

library(dplyr)

country <- select(oecd, ` ...2`)

names(oecd)[2] <- "country"


decades <- oecd %>%
           select(ends_with('0'))

lastcent  <- oecd %>%
             select(starts_with('19'))

noughties <- oecd %>%
             select(country,contains('20'))

all20 <- oecd %>%
         select(country,num_range(prefix="200",range=(1:6)))
                 
            