# plot Song length
df_songs_length = df_songs %>% 
  mutate(len = sapply(strsplit(line, " "), length))

df_songs_length = df_songs_length %>%  
  group_by(song_name) %>% 
  summarise(leng = sum(len))

song_length_plot = ggplot(df_songs_length, aes(x=reorder(song_name, leng), y = leng))
song_length_plot + geom_bar(stat = 'identity') + 
  coord_flip() + 
  ggtitle("Song length by Song title") +
  ylab("Length of Words") +
  xlab("Song name")
  

# create sort order (descending) for matrix
words_frequency <- colSums(as.matrix(tdm)) 

ord <- order(words_frequency, decreasing=TRUE)
words_frequency = words_frequency[head(ord, 20)] 
words_frequency_df = data.frame(term = names(words_frequency), freq = words_frequency)

# Plot most frequent words
top_freq_plot = ggplot(words_frequency_df, aes(x=reorder(term, freq), y = freq)) 
top_freq_plot + geom_bar(stat = 'identity') + coord_flip()

# Wordcloud
freq = data.frame(sort(colSums(as.matrix(tdm)), decreasing=TRUE))
wordcloud(rownames(freq), freq[,1], max.words=50, colors=brewer.pal(1, "Dark2"))

# Bigrams
BigramTokenizer = function(x) {
    unlist(lapply(ngrams(words(x), 2), paste, collapse = " "), use.names = FALSE)
}

corpusV = VCorpus(VectorSource(df_songs$line))

tdm_bi <- DocumentTermMatrix(corpusV, control = list(tokenize = BigramTokenizer))
words_frequency <- colSums(as.matrix(tdm_bi)) 
words_frequency

ord <- order(words_frequency, decreasing=TRUE)
words_frequency = words_frequency[head(ord, 20)] 
words_frequency

words_frequency_df = data.frame(term = names(words_frequency), freq = words_frequency)

top_freq_plot_bi = ggplot(words_frequency_df, aes(x=reorder(term, freq), y = freq)) 
top_freq_plot_bi + geom_bar(stat = 'identity') + coord_flip()

# Trigrams
TrigramTokenizer = function(x) {
  unlist(lapply(ngrams(words(x), 3), paste, collapse = " "), use.names = FALSE)
}

tdm_tri <- DocumentTermMatrix(corpusV, control = list(tokenize = TrigramTokenizer))
words_frequency <- colSums(as.matrix(tdm_tri)) 
words_frequency

ord <- order(words_frequency, decreasing=TRUE)
words_frequency = words_frequency[head(ord, 10)] 
words_frequency

words_frequency_df = data.frame(term = names(words_frequency), freq = words_frequency)

top_freq_plot_tri = ggplot(words_frequency_df, aes(x=reorder(term, freq), y = freq)) 
top_freq_plot_tri + geom_bar(stat = 'identity') + coord_flip()
