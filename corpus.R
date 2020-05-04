# applyting contractions
contractions = function(x) {
  return(replace_contraction(x))
}

df_songs = df_songs %>% 
  mutate(corp = contractions(df_songs$line))

# creating corpus
corpus = Corpus(VectorSource(df_songs$corp))

# Removing numbers if present
corpus = tm_map(corpus, removeNumbers)

# inspect doc number one
writeLines(as.character(corpus[[2]]))

# remove special characters
corpus = tm_map(corpus, removePunctuation)

# strip whitespace
corpus = tm_map(corpus, stripWhitespace)

# lowercase
corpus = tm_map(corpus, content_transformer(tolower))
writeLines(as.character(corpus[[2]]))

# remove stopwords
corpus = tm_map(corpus, removeWords, stop)
corpus = tm_map(corpus, stripWhitespace)
writeLines(as.character(corpus[[15]]))

# stemming
corpus = tm_map(corpus, stemDocument)
writeLines(as.character(corpus[[11]]))










