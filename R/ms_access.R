library(DBI)
library(odbc)

#------------------------------------------------------#
#  Need to run the 32bit of R Studio                   #
#------------------------------------------------------#

#--------  Create db connections  -------------------#
conn <- dbConnect(odbc::odbc(),dsn = "student_visa")

#-----  Write query  --------------#
query <- "Select * from SEV_STUDENT"

#------   Get all Data ---------------# 
student_visa <- dbGetQuery(conn,query)
