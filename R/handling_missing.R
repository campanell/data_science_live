library(readxl)
library(dplyr)
library(tidyr)

oecd <- read_xls("c:/Users/Campanell/Downloads/oecd.xls",skip=3,n_max=42) %>%
        rename(country = 2) 

oecd_reduced <- oecd %>%
                select(country,`1970`,`2010`)


#--------------  Drop rows with missing values  --------------#
drop_missing <- oecd_reduced %>%
                drop_na()

missing_countries <- anti_join(oecd_reduced,drop_missing,by=c("country"))

#-------------   Fill in missing values ---------------------------------#
fill_missing <- oecd_reduced %>%
                fill(`1970`,.direction=c("down"))

#--------------  Replace missing values ----------------------------#
replace_missing <- oecd_reduced %>%
                   replace_na(replace = list(`1970`=oecd_reduced$`1970`[36],`2010`=oecd_reduced$`2010`[36]))

