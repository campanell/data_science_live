library(dplyr)
library(stringr)

#-------   Quotes from Mahatma Gandhi  -------------#

quote1 <- "Be the change that you wish to see in the world."
quote2 <- "Live as if you were to die tomorrow. Learn as if you were to live forever"

#------------  Pattern Match   ---------------#
match1 <- str_detect(quote1,'world')
match2 <- str_detect(quote1,'you wish')
no_match <- str_detect(quote1, 'forget')

#----------   Replace string  ----------------#
today_string <- str_replace(quote2,"tomorrow","today")
all_repl <- str_replace_all(quote2,"as if","like")

#------------ Subset string term  -------------#
change_term <- str_sub(quote1,1,19)