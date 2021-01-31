library(readr)
library(dplyr)

#---------   Read data  -----------------------------#
spain_cpi_yoy <- read_csv("https://datasciencelive.com/data/spain_cpi_yoy.csv")
netherlands_cpi_yoy <- read_csv("https://datasciencelive.com/data/netherlands_cpi_yoy.csv")

#---------  Bind rows  ---------------------------#
all_rows <- bind_rows(spain_cpi_yoy,netherlands_cpi_yoy)

#-----   Add Netherlands CPI YoY  ----------------#
netherlands_cpi_only <- netherlands_cpi_yoy %>%
                        select(cpi_yoy) %>%
                        rename(netherlands_cpi = cpi_yoy)

#----------  Rename Spain CPI YoY  -----------------#
spain_cpi_yoy <- spain_cpi_yoy %>%
                 rename(spain_cpi = cpi_yoy) %>%
                 select(-country)

#------------  Bind Columns  ---------------#
all_cols <- bind_cols(spain_cpi_yoy,netherlands_cpi_only)




