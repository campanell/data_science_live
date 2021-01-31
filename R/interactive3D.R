library(plotly)
library(dplyr)

#------------- Load data ------------------------#
load(file="rfm.rda")

#------------   Plot Buckets  ----------------#
plot3d <- plot_ly(rfm_segment, x= ~bucket_recent, y= ~bucket_freq, z= ~bucket_monetary,
                  marker = list(color= ~most_recent, colorscale= c('#ffd8d8','#ff5c5c'),showscale=TRUE))

#-----------   Plot values  ----------------------#
plot3d <- plot_ly(rfm_segment, x= ~most_recent, y= ~freq, z= ~monetary,
                  marker = list(color= ~monetary, colorscale= c('#ffd8d8','#ff5c5c'),showscale=TRUE))