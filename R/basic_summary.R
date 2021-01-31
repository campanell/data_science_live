library(dplyr)
library(readxl)

#---------  Read data ------------------------#
oecd <- read_xls("c:/Users/Campanell/Downloads/oecd.xls",skip=3,n_max=42) %>%
        rename(country = 2) %>%
        select(country,ends_with('0'))

#-------   Highest fertility rate in 2000  -------------#
max_2000 <- oecd %>%
            summarise(max_rate = max(`2000`))


max_2000_all <- oecd %>%
                filter(`2000` == max(`2000`))

#----------   Average fertility rate in 2000  -----------#
avg_2000 <- oecd %>%
            summarise(avg_rate = mean(`2000`))

#--------   Countries below average fertitlity rate in 2000  ----------#
below_avg <- oecd %>%
             filter(`2000` < mean(`2000`)) %>%
             arrange(`2000`)

#----------  Count number of records   ---------------------#
n_recs <- oecd %>%
          select(`2010`) %>%
          summarise(freq = n()) 
