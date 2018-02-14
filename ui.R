
# This is the user-interface definition of my Natural Language Processing Shiny web application.

library(shiny)
library(tidyverse)
library(tm)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(navbarPage("A Coursera data science track project brought to you by Johns Hopkins University and Swiftkey",
                   theme = shinytheme("cerulean"),
        fluidPage(
                headerPanel("The Word Rec'R"),
                
  sidebarLayout(
    sidebarPanel(
            helpText("Enter a word below and the recommended word appears to the right."),
            textInput("inputText", "Enter your text here:",value = "")
            #text("By John Armistead Wilson")
    ),
    mainPanel(
            h5("Recommended word:"),
            verbatimTextOutput("prediction")),
    position = c("left", "right"), fluid = TRUE 
  ))
        )
)
