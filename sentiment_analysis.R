setwd("/Users/richardhachar/Desktop/Resume/sentiment_analysis")

library(twitteR)
library(ROAuth)
library(shiny)
library(plyr)
library(stringr)

source("lib/functions.R")

####

consumer_key <- "gs996gtFrHyIEPwnTiloIIBwz"
consumer_secret <- "PW9wDzBMLu9v1B4vQ99sXufbAnLbjAB7zI3JEu5bxM6izUz3FD" 
access_token <- "216744955-bgIEn28JpLTLZLGvwCyC4a41RJB15PQFKjulEpma"
access_secret <- "fH7WnD3ilwwNHHmHRGN9vdqF3aDtQcOgpbOR0NV6CTMGh"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

####

# STEP 1: Choose Terms to Search

terms = c(
	'$AAPL',
	'$GOOG',
	'$TWTR',
	'$FB',
	'$SNAP'
)

# STEP 2: Perform Analysis and add items to list

# enter loop:
# 	perform sentiment analysis on i1
# 	add sentiment_score_i1 to list
# add sentiment scores to term_scores dataframe

scores <- c()

for (i in terms) {
	scores <- c(scores,sentiment_analysis(i))
}

# STEP 3: Combine terms and scores into one dataframe

term_scores = data.frame(Term=terms,Score=scores)

# STEP 4: Export to CSV

write.csv(term_scores,"sentiment_analysis.csv")
