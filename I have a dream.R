install.packages("sentimentr")
library(sentimentr)

Speech_file<-readLines('C:\\Users\\Mina Doss\\OneDrive\\Desktop\\i_have_a_dream.txt')

Speech_file

Speech_sentences <- get_sentences(Speech_file)

Sentiment_Score<-sentiment_by(Speech_sentences )

Sentiment_Score

plot(Sentiment_Score $element_id, Sentiment_Score $ave_sentiment,xlab="Sentence Number" ,ylab="Polarity", main = "Sentiment of I Have a Dream Speech")

install.packages("tm")  # for text mining

install.packages("SnowballC") # for text stemming

install.packages("wordcloud") # word-cloud generator 

install.packages("RColorBrewer") # color palettes

# Load

library("tm")

library("SnowballC")

library("wordcloud")

library("RColorBrewer")

docs <- Corpus(VectorSource(Speech_file))

inspect(docs)

# Preprocessing Steps :

docs <- tm_map(docs, content_transformer(tolower))

# Remove numbers

docs <- tm_map(docs, removeNumbers)

# Remove english common stopwords

docs <- tm_map(docs, removeWords, stopwords("english"))

# Remove your own stop word

# specify your stopwords as a character vector

docs <- tm_map(docs, removeWords, c("the", "instead")) 

# Remove punctuations

docs <- tm_map(docs, removePunctuation)

# Eliminate extra white spaces

docs <- tm_map(docs, stripWhitespace)

# Text stemming

#docs <- tm_map(docs, stemDocument)


dtm <- TermDocumentMatrix(docs)

m <- as.matrix(dtm)

m

v <- sort(rowSums(m),decreasing=TRUE)

v

d <- data.frame(word = names(v),freq=v)

head(d, 10)

wordcloud(words = d$word, freq = d$freq, min.freq = 1,
           
           max.words=200, random.order=FALSE, rot.per=0.35, 
           
           colors=brewer.pal(8, "Dark2"))
