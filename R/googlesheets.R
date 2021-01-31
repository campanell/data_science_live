library(googledrive)
library(googlesheets4)
library(dplyr)
library(readr)


#-----  Connect Google Drive to R Studio  ----------------#
holidays <- drive_get("Holidays")

#------------------   Read a sheet from Drive -----------------#
holiday_df <- read_sheet(as_sheets_id(holidays),sheet="holidays2020") %>%
              arrange(date)

#-------------  Add Lunar New Year  -----------------#
holiday_update <- holiday_df %>%
                  mutate(holiday = if_else(is.na(holiday)==TRUE, 'Lunar New Year',holiday))

#--------  Clean up data frame  -------------------#
holiday_clean <- holiday_update %>%
                 select(date,holiday)

#---------  Write it back to Drive as a new file  ----------#
write_csv(holiday_clean,"E:/tmp/holidays2.csv")
upload_file <- drive_put("E:/tmp/holidays2.csv",type="spreadsheet")



