library(dplyr)
library(readr)
library(ggplot2)

#---------  Video Game sales  ---------------#
game_sales <- read_csv("C:/Users/Campanell/Downloads/vgsales.csv")

#-------- Select data  -----------------#
game_set <- game_sales %>%
            select(Year, Platform, Global_Sales) %>%
            filter(!Year %in% c('N/A','2016','2017','2020'))


#---------- Playstation  ----------------#
playstation <- game_set %>%
               filter(Platform %in% c('PS','PS2','PS3', 'PS4')) %>%
               filter(Global_Sales <= 5)
   

#---------  Area  graph  ---------------#
ps_area <- ggplot(playstation,aes(Global_Sales)) +
           geom_area(stat = "bin")

playstation <- playstation %>%
               filter(Global_Sales <= 5)

#----------  histogram plot  --------------#
ps_histo <- ggplot(playstation,aes(Global_Sales)) +
            geom_histogram(bins=45)

#-------   boxplot  -------------------#
ps_box <- ggplot(playstation,aes(x=Platform,y=Global_Sales)) +
          geom_boxplot()


#-------  Summarise data  ----------------#
game_summary <- game_set %>%
  group_by(Year) %>%
  summarise(sales = sum(Global_Sales)) 

#--------  Bar plot by year  -------------#
bar <- ggplot(game_summary,aes(x=Year,y=sales)) +
  geom_bar(stat="identity", width=0.25)
     

                

