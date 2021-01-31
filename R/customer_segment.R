library(ggplot2)
library(dplyr)

cust <- customer_summary %>%
        na.omit()

#------- Scatter Plot  ------------------#
cust_plot <- ggplot(cust,aes(x=CustomerID,y=total_customer_sales)) +
             geom_point(shape=1)


#--------  Horizontal line -------------#
custplot <- ggplot(cust,aes(x=CustomerID,y=total_customer_sales)) +
            geom_point(shape=1) +
            geom_hline(yintercept = 5000, color="red")

#--------  Wholesale customers ---------------#
wholesale <- cust %>%
             filter(total_customer_sales >= 5000)
