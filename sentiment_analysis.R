# STEP 1: Import Packages and Functions
library(twitteR)
library(ROAuth)
library(shiny)
source("lib/functions.R")

# STEP 2: Load Consumer Keys
consumer_key <- "your_info_here" # replace with your info
consumer_secret <- "your_info_here"
access_token <- "your_info_here"
access_secret <- "your_info_here"

# STEP 3: Set up the connection
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# STEP 4: Open with Shiny

ui <- fluidPage(
  br(),
  textInput("n", "Sentiment Analysis", value = "Input Ticker"),
  actionButton("go", "Perform Analysis"),
  br(),
  br(),
  textOutput("test")
)

server <- function(input, output) {
  
  tracker <- eventReactive(input$go,input$n)
  
  output$test <- renderText(sentiment_analysis(tracker()))

  
}

shinyApp(ui, server)
