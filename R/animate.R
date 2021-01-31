library(gganimate)
library(readr)
library(dplyr)
library(ggplot2)
library(bbplot)
library(gifski)

#--------------  Read OPT Data frame  --------------------------------#
opt <- read_csv("https://datasciencelive.com/data/opt.csv")

#--------- Country summaries   ---------------------------------#
country_summary <- opt %>%
                   group_by(country,year) %>%
                   summarise(approved = n())

#--------  Full year data   --------------------------#
country_summary_full <- country_summary %>%
                        filter(year %in% c(2007:2016)) 

#-------------  Top 10 Country data frame
top10_country <- opt %>%
                 group_by(country) %>%
                 summarise(top_country = n()) %>%
                 top_n(10) %>%
                 select(country)

#------------  Join for top 10 by year  ----------------#
top10 <- inner_join(country_summary_full,top10_country,by=c("country")) %>%
         arrange(year,desc(approved)) 

#-------------------------------------------------------#
#  Create bar chart and animation object                #
#-------------------------------------------------------#
bars <- ggplot(top10, aes(x = reorder(country, approved), y = approved)) +
         geom_bar(stat="identity", 
                  position="identity", 
                  fill="#1380A1") +
        geom_hline(yintercept = 0, size = 1, colour="#333333") +
        bbc_style() +
        labs(title="Top 10 Countries with Approved OPT Visas",
             subtitle =  '{as.integer(frame_time)}') + 
        coord_flip() +
        transition_time(year) +
        ease_aes('linear')


#-------------- Create animated gif  ------------------------------#
animate(bars, nframes=200, fps = 20,  width = 1200, height = 1000, 
        renderer = gifski_renderer("F:/datascienelive/blog/opt.gif"))

