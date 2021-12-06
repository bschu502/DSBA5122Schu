#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(ggplot2)
library(shiny)
library(readxl)
library(readr)
library(lubridate)
library(shinythemes)
library(dplyr)

df <- read_csv("C:/Users/brian/OneDrive/Documents/DSBA5122/FinalProjectDSBA5122Schu/data/Insurance.csv")
#glimpse(df)
# Define UI for application that draws a histogram
df$Year <- format(df$Date, format="%Y")



states <- as.list(df$Location_Name)
expanded <- as.list(df$Expanded)
Year <- as.list(df$Date)
df1 <- df %>%
  filter(Indicator == "KN.VA12")


ui <- fluidPage(
  theme = shinytheme("sandstone"),
  titlePanel("Uninsured rate by state"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput("state", label = "State:", choices = states),
      hr(),
      selectInput("expanded", label = "Medicaid Expansion Status", 
                  choices = expanded)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("State", plotOutput("histo")),
        tabPanel("Expansion status", plotOutput("expanse"))
    )
  )
))

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$histo <- renderPlot({
        # generate bins based on input$bins from ui.R
      ggplot(df1, aes(x = Date, y = "% Uninsured")) +
        geom_bar(stat = "identity")
      
    output$expanse <- renderPlot({
      ggplot(df1, aes(x = Date, y = "% Uninsured")) +
        geom_bar(stat = "identity")
    })  })
    }


# Run the application 
shinyApp(ui = ui, server = server)
