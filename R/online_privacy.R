library(httr)

wp <- GET("https://www.washingtonpost.com/technology/2021/01/07/trump-online-siege/")
wp_cookie_df <- cookie$cookies

wells <- GET("https://www.wellsfargo.com/")
wf_cookie_df <- wells$cookies

olivetti <- GET("https://www.olivetti.com/")

ikea <- GET("https://www.ikea.com/")
ikea_cookie_df <- ikea$cookies

spotify <- GET("https://www.spotify.com/")
spotify_cookie_df <- spotify$cookies

california <- GET("https://www.ca.gov/")
california_cookie_df <- california$cookies