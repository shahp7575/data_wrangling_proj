# doc-term matrix
tdm = DocumentTermMatrix(corpus)
inspect(tdm)

frequent_terms <- findFreqTerms (tdm,30,50) 
frequent_terms

# Sum all columns(words) to get frequency
words_frequency <- colSums(as.matrix(tdm)) 
words_frequency
# create sort order (descending) for matrix
ord <- order(words_frequency, decreasing=TRUE)
ord

# get the top 20 words by frequency of appeearance
words_frequency[head(ord, 10)] %>% kable()

findFreqTerms(tdm, 10)
freq = data.frame(sort(colSums(as.matrix(tdm)), decreasing=TRUE))
wordcloud(rownames(freq), freq[,1], max.words=50, colors=brewer.pal(1, "Dark2"))
