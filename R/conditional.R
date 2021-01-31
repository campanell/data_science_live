library(jsonlite)
library(dplyr)

#----- Load data from URL  ----------------#
resp <- fromJSON(txt="https://data.austintexas.gov/resource/7d8e-dm7r.json?month=7&year=2020")

micromobility <- resp %>%
                 mutate(trip_distance = as.integer(trip_distance)) %>%
                 mutate(duration_min = as.integer(trip_duration)/60) %>%
                 select(device_id,vehicle_type,trip_distance,duration_min)

#------------  Bucket ranks ----------------------#
buckets <- micromobility %>%
           summarise(trip_group = ntile(duration_min,3))

micro_buckets <- bind_cols(micromobility,buckets)

#-----------   Percent Ranks -----------------------#
pct_rank <- micromobility %>%
            summarise(pct_rank = percent_rank(duration_min))

pct_rank_all <- bind_cols(micromobility,pct_rank)


#-------------  Name bucket groups  ----------------------------------#
trip_type <- micro_buckets %>%
             mutate(type = case_when(
                    trip_group == 1 ~ 'short',
                    trip_group == 2 ~ 'medium',
                    trip_group == 3 ~ 'long'
  ))

#----------   Split on Percent Rank --------------------#
split_it  <- pct_rank_all %>%
             mutate(even_split = if_else(pct_rank > .5,'top half','bottom half')) %>%
             arrange(pct_rank)