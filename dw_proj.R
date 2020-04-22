# installing packages
install.packages('dplyr')
install.packages('devtools')
install.packages('tidytext')
install.packages('rvest')
install.packages('textclean')
install.packages('corpus')
install.packages('tm')

# loading libraries
library(dplyr)
library(devtools)
library(tidytext)
library(rvest)
library(stringr)
library(xml2)
library(textclean)
library(hunspell)
library(corpus)
library(stopwords)
library(tm)

# installing dev version geniusr package
devtools::install_github("ewenme/geniusr")

## Setting genius api token to environment variables
geniusr::genius_token()



## loading geniusr
library(geniusr)

## get artist id using search_artist()
search_artist(search_term = 'Jeremy')

# get_lyrics test
df = get_artist_songs_df(artist_id = "398381")

# get song id
get_song_lyrics = function(art_id) {
  
  # data frame of artist id
  df_artist_id = get_artist_songs_df(artist_id = art_id)
  
  # remove rows with unwanted songs -> (remix, stripped., live)
  df_artist_id$song_name = tolower(df_artist_id$song_name)
  unwanted_str = c("stripped", "live", "remix")
  for(st in unwanted_str) {
    df_artist_id = df_artist_id[- grep(st, df_artist_id$song_name), ]
  }
  
  # get all song ids
  songids = df_artist_id$song_id
  res_lyrics = data.frame()
  
  for(id in songids) {
    df_songid = get_lyrics_id(song_id = id)
    res_lyrics = rbind(res_lyrics, df_songid)
  }
  
  return(res_lyrics)
}

# get final data from the function
df_songs = get_song_lyrics(art_id = '398381')




































