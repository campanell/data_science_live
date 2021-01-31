
#------------   RFM   ------------------#

#--------   Recency  -------------------#
most_recent_month <- max(monthly$sales_month)

recency <- monthly %>%
           mutate(period = as.duration(most_recent_month - sales_month)) 

#----------  Frequency   ---------------#
freq <- monthly %>%
        group_by(CustomerID) %>%
        summarise(freq = n())

#----------   Monetary  -----------------------#
monetary <- monthly %>%
            group_by(CustomerID) %>%
            summarise(monetary = sum(montly_sales))

#-----------   Most Recent  ------------------#
most_recent <- recency %>%
               group_by(CustomerID) %>%
               summarise(most_recent = min(period)*-1)

#---------  Bind data frames   -----------------#
cust_base <- bind_cols(freq,monetary,most_recent,by=c("CustomerID")) %>%
             rename(id=1) %>%
             select(id,freq,monetary,most_recent)

#-----------  Wholesale customers  ----------------#
rfm_wholesale <- inner_join(cust_base,wholesale,by=c("id"="CustomerID")) %>%
                  select(id,freq,monetary,most_recent)

#-------------   Build buckets   --------------------#
rfm <- rfm_wholesale %>%
       mutate(bucket_freq = ntile(freq,3)) %>%
       mutate(bucket_monetary = ntile(monetary,3)) %>%
       mutate(bucket_recent = ntile(most_recent,3))

#-------------  RFM segments ---------------------#
rfm_segment <- rfm %>%
               mutate(segment = paste0(as.character(bucket_recent),as.character(bucket_freq),as.character(bucket_monetary)))

mvc <- rfm_segment %>%
       filter(segment == '333')

need_attention <- rfm_segment %>%
                  filter(bucket_monetary == 3 & bucket_recent ==1)
          