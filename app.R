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

library(readr)
library(lubridate)
library(shinythemes)
library(dplyr)




df <- read_csv("data/InsuranceFiltered.csv")
#glimpse(df)
# Define UI for application that draws a histogram
df$Year <- format(df$Date, format="%Y")



states <- as.list(df$Location_Name)
expanded <- as.list(df$Expanded)
Year <- as.list(df$Date)
#df1 <- df %>%
 # filter(Indicator == "KN.VA12")


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
  df_groups <- reactive({
    
    df %>% filter(Location_Name %in% input$state)
  })
  
    output$histo <- renderPlot({
      
         p <-   ggplot(df_groups, aes(x = 'Date', y = '% Uninsured')) +
            geom_bar(stat = "identity")
          
    output$expanse <- renderplot({
       
      ggplot(df, aes(x = Date, y = "% Uninsured")) +
        geom_bar(stat = "identity")
    })  })
    }


# Run the application 
shinyApp(ui = ui, server = server)
