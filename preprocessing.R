# function for contractions 
contractions = function(x) {
  return(replace_contraction(x))
}

# function to remove special characters
rem_spec_char = function(x) {
  return(gsub("[^[:alnum:]]", " ", x))
}

# function to remove stopwords
stop = read.table("stop.txt", header = TRUE)
stop = as.character(stop$CUSTOM_STOP_WORDS)
stop = c(stopwords("english"), stop)
stop_vec = as.vector(stop$CUSTOM_STOP_WORDS)
my_stop_words = tibble(as.vector(stop$CUSTOM_STOP_WORDS), lexicon = "SMART")

# function to stem words
stem_hunspell <- function(term) {
  # look up the term in the dictionary
  stems <- hunspell::hunspell_stem(term)[[1]]
  
  if (length(stems) == 0) { # if there are no stems, use the original term
    stem <- term
  } else { # if there are multiple stems, use the last one
    stem <- stems[[length(stems)]]
  }
  
  return(stem)
}


test = df_songs

test = test %>% 
  mutate(test_col = contractions(test$line))

test = test %>% 
  mutate(test_col2 = rem_spec_char(test$test_col))

test = test %>% 
  mutate(test_col3 = text_tokens(test_col2, stemmer = stem_hunspell))

text = "Hey you are awesome. This is dope. I like you."
all_stop_words = stop_words %>% 
  bind_rows(my_stop_words)

no_numbers = test %>% 
  

no_stop_words = test %>% 
  select(test_col2) %>% 
  anti_join(all_stop_words, by = 'word')













