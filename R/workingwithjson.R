library(dplyr)
library(jsonlite)


exim_raw <- fromJSON("https://datasciencelive.com/data/eximbank.json")

exim_df <- exim_raw$data
exim_meta <- exim_raw$meta

eximbank <- as_tibble(exim_df)

exim_meta_colnames <- exim_meta$view$columns$name

names(eximbank) <- exim_meta_colnames

#------- Summarise the data  -------------#
program_type <- eximbank %>%
                select(Program) %>%
                group_by(Program) %>%
                summarise(approved_program = n()) %>%
                arrange(desc(approved_program))



