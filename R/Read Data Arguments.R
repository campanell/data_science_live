library(readr)

#----------  Read csv  --------------------------------------#
public_art <- read_csv("C:/Users/Campanell/Downloads/Public_Art_Data.csv")

#---------   First 100 rows  ----------------------------------#
public_art_100 <- read_csv("C:/Users/Campanell/Downloads/Public_Art_Data.csv", n_max=100)

#------------  No Header   ----------------------------------#
public_art_x <- read_csv("C:/Users/Campanell/Downloads/Public_Art_Data.csv", col_names = FALSE)

#------------ Skip first 100 rows  ----------------------------#
public_art_rest <- read_csv("C:/Users/Campanell/Downloads/Public_Art_Data.csv", skip = 100)

#----------  Column names first 4 ------------------#
public_art_names <- read_csv("C:/Users/Campanell/Downloads/Public_Art_Data.csv", col_names = c("id","commision","firstname","lastname"))

