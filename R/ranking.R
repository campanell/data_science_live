library(jsonlite)
library(dplyr)

resp <- fromJSON(txt="https://data.austintexas.gov/resource/7d8e-dm7r.json?month=7&year=2020")

micromobility <- resp %>%
                 mutate(trip_distance = as.integer(trip_distance)) %>%
                 mutate(duration_min = as.integer(trip_duration)/60) %>%
                 select(device_id,vehicle_type,trip_distance,duration_min)


#-----------------   Bucket ranks  --------------------------------#
buckets <- micromobility %>%
           summarise(trip_group = ntile(duration_min,3)) 

microbucket <- bind_cols(micromobility,buckets)

#----------------   Percent ranks  ------------------------------#
pct_rank <- micromobility %>%
            summarise(pct_rank = percent_rank(duration_min))

pctbucket <- bind_cols(micromobility,pct_rank)

#-------------  Example  ----------------------------------#
trip_type <- microbucket %>%
             mutate(type = case_when(
               trip_group == 1 ~ 'short',
               trip_group == 2 ~ 'medium',
               trip_group == 3 ~ 'long'
             ))

#----------   Average duration --------------------#
avg_duration <- trip_type %>%
                group_by(type) %>%
                summarise(avg_trip_duration = mean(duration_min))  %>%
                arrange(avg_trip_duration)
