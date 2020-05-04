test_songs = df_songs

# to lowercase
test_songs = test_songs %>% 
  mutate(lower = tolower(test_songs$line))
         
# apply contractions
test_songs = test_songs %>% 
  mutate(contr = contractions(test$line))

# function to remove special characters
rem_spec_char = function(x) {
  return(gsub("[^[:alnum:]]", " ", x))
}

# tokenize
tidytokens = test_songs %>% 
  unnest_tokens(word, contr)

no_stop_words = test_songs %>% 
  select(contr) %>% 
  anti_join(all_stop_words, by = 'word')
