# function for contractions 
contractions = function(x) {
  return(replace_contraction(x))
}

# function to remove special characters
rem_spec_char = function(x) {
  return(gsub("[^[:alnum:]]", " ", x))
}

# function to remove stopwords

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

text <- "Though I have been holding out for your trust"
text_tokens(text, stemmer = stem_hunspell)















