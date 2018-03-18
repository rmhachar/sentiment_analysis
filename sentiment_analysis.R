# STEP 1: Import Packages
library(twitteR)
library(ROAuth)

# STEP 2: Load Consumer Keys
consumer_key <- "your_info_here" # replace with your info
consumer_secret <- "your_info_here"
access_token <- "your_info_here"
access_secret <- "your_info_here"

# Set up the connection
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

