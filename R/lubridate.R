library(lubridate)

#-----------   Create some date with numbers   ---------------#
today <- today()
yesterday <- today() - 1
last_week <- today() - 7

#------------  Create dates with formats  ---------------#
dashfmt <- ymd("2020-01-01")
nodash <- ymd("20200101")


#----------  Working with Time stamp   --------------#
stamp <- now()
date(stamp)
hour(stamp)
minute(stamp)
second(stamp)


#------------  quirky features   -----------------#
leap_year(today)
quarter(today)



