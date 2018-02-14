#
# This is the server logic of my Natural Language Processing Shiny web application.

library(shiny)
library(tidyverse)
library(tm)
library(shinythemes)

bigramR <- readRDS("bigram.RData")
trigramR <- readRDS("trigram.RData")

# Define server logic required to draw a histogram
lookup_funct <- function(user_input) {
        new_word <- stripWhitespace(removePunctuation(removeNumbers(tolower(user_input), preserve_intra_word_dashes=TRUE)))
        # print added new_word
        user_input <- strsplit(new_word, " ")[[1]]
        # word/phrase length
        n <- length(user_input)

        # check trigram function if phrase length greater than 1.
        if (n >= 2) {user_input <- as.character(tail(user_input,2))
                funct_trigram(user_input)}
        
        # check tbirigram function if phrase length greater than 2.
        else if (n >= 1) {user_input <- as.character(tail(user_input,1))
                funct_bigram(user_input)}
}

### Trigram function
funct_trigram <- function(user_input) {
        if (identical(character(0),as.character(head(trigramR[trigramR$tri_word_1 == user_input[1]
                                                              & trigramR$tri_word_2 == user_input[2], 3], 1)))) {
                
                as.character(lookup_funct(user_input[2]), sep=" ")
        }
        else {
                as.character(head(trigramR[trigramR$tri_word_1 == user_input[1]
                                           & trigramR$tri_word_2 == user_input[2], 3], 1))
        }
}

### Bigram function
funct_bigram <- function(user_input) {
        if (identical(character(0),as.character(head(bigramR[bigramR$bi_word_1 == user_input[1], 2], 1)))) {
                as.character(head("the",1))
        }
        else {
                as.character(head(bigramR[bigramR$bi_word_1 == user_input[1],2], 1))
        }
}


###########
#        if (identical(character(0),as.character(head(tri_gram[tri_gram$word_1 == user_word[1]
#                                                      & tri_gram$word_2 == user_word[2], 3], 1)))) {
        
#        as.character(word_suggest(user_word[2]))
#}
#else {
#        as.character(head(tri_gram[tri_gram$word_1 == user_word[1]
#                                   & tri_gram$word_2 == user_word[2], 3], 1))
        
###########
# Call the function
shinyServer(function(input, output) {
        output$prediction <- renderPrint({
                prediction <- lookup_funct(input$inputText)
                prediction
        });
}
)
