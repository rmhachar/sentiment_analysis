sentiment_analysis <- function(input) {
  
  score.sentiment <- function(sentences, pos.words, neg.words, .progress='none') { 
    require(plyr); require(stringr)
    scores <- laply(sentences, function(sentence, pos.words, neg.words){
      sentence <- gsub('[[:punct:]]', "", sentence); 
      sentence <- gsub('[[:cntrl:]]', "", sentence) 
      sentence <- gsub('\\d+', "", sentence); 
      sentence <- tolower(sentence);
      word.list <- str_split(sentence, '\\s+'); 
      words <- unlist(word.list);
      pos.matches <- match(words, pos.words); 
      neg.matches <- match(words, neg.words); 
      pos.matches <- !is.na(pos.matches); 
      neg.matches <- !is.na(neg.matches)
      score <- sum(pos.matches) - sum(neg.matches);
      return(score)
    }, pos.words, neg.words, .progress=.progress) 
    scores.df <- data.frame(score=scores, text=sentences) 
    return(scores.df)
  }
  
  # Searches twitter and creates a List for tweets
  
  tweets <- searchTwitter(input,n=100)
  
  # turn lists into tables
  
  tweets_table <- twListToDF(tweets)
  
  # Remove emojis from tables
  
  tweets_table$text <- sapply(tweets_table$text, function(row) iconv(row, "latin1", "ASCII", sub=""))
  
  # include positive and negative lists
  
  pos <- scan('words/positive-words.txt', what='character', comment.char=';') # list with positive dictionary
  neg <- scan('words/negative-words.txt', what='character', comment.char=';') # list with negative dictionary
  pos.words <- c(pos, 'upgrade') # include additional words in the list
  neg.words <- c(neg, 'wtf', 'hack', 'breach', 'cybersecurity', 'trump') # include additional words in the list
  
  # Get and set scores
  
  Dataset <- tweets_table
  Dataset$text <- as.factor(Dataset[,1])
  scores <- score.sentiment(Dataset$text, pos.words, neg.words)
  
  return(sum(scores$score))
}
