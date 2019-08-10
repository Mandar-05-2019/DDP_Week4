library(shiny)
library('ggplot2')

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Prediction model for diamond dataset"),
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("carat",
                        "Carats:",
                        min = min(diamonds$carat),
                        max = max(diamonds$carat),
                        value = median(diamonds$carat)),
            
            checkboxInput("lin_mod", "show linear model", TRUE),
            
            checkboxInput("non_lin_mod", "show non linear model", FALSE)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
                plotOutput("myplot")
        )
    )
))


