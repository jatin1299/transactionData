library(ggplot2)
library(shiny)
library(shinythemes)
library(dplyr)
library(tidyverse)
library(ggpubr)
library(lubridate)
library(data.table)

source('./transactions.R')

# Define UI
ui <- fluidPage(theme = shinytheme("cerulean"),
                navbarPage(
                  # theme = "cerulean",  # <--- To use a theme, uncomment this
                  "Transaction-Data",
                  tabPanel("AffectedTime",
                           mainPanel(
                             h1("SR drop time "),
                             
                             plotOutput("plotGraph") %>% tagAppendAttributes(class="container-fluid text-center"),
                             h2("We have avg of success_rate which is mean_success_rate against each hour of each day....from here we get to know speific time period where success_rate is dropped.")
                             
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  tabPanel("Combinations",
                           mainPanel(
                             h1("Combinations"),
                             
                             plotOutput("plotGraph2") %>% tagAppendAttributes(class="container-fluid text-center"),
                             h2("After deducing time which gave drop in SR we filtered out specific time from original dataset and from that filterd data we try to plot different combinations like pmt vs pg, mid vs pg and mid vs pmt these graphs helped to deduce which payment gateway is causing drop in SR and because of that which merchant is affected and facing issues.")
                             
                           )
                
                  
                           )
                           )
)

# Define server function  
server <- function(input, output) {
  
  output$plotGraph <- renderPlot({
    ggarrange(twelveplot, thirteenplot, fourteenplot,
              labels = c("A", "B", "C"),
              ncol = 2, nrow = 2)
    
  })
  output$plotGraph2 <- renderPlot({
    ggarrange(pmtVSpg, pmtVSmid, pgVSmid,
              labels = c("A", "B", "C"),
              ncol = 2, nrow = 2)
    
  })
  
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)