library(dplyr)
library(pdftools)
library(tidytext)
library(stringr)

#----------  Extract text from the pdf ----------------#
exec_order <- pdf_text(pdf="https://datasciencelive.com/data/executive_order.pdf")

#------- Put text in a data frame  -----------------#
doc_df <- tibble(par=integer(),text=character(0))

for (i in 1:length(exec_order)) {
  
  #------  Clean up text  ------- #
  text <- str_replace_all(exec_order[i],"[\r\n]"," ")
  current_df <- tibble(par=i,text=text)
  doc_df <- bind_rows(doc_df,current_df)
  
}

#------------  Create tokens  ---------------------#
all_terms <- doc_df %>%
             unnest_tokens(word, text)

#-----------  Remove stopwords ---------------------#
data("stop_words")

all_terms_clean <- anti_join(all_terms,stop_words)

#----------    Count words   -----------------------#
word_count <- all_terms_clean %>%
              count(word, sort=TRUE)

