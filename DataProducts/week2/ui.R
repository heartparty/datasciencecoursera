library(shiny)
library(leaflet)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(navbarPage("Shiny Map: US MacDonalds",
                   
                   # First panel home
                   tabPanel("Home",
                            sidebarLayout(
                                  sidebarPanel(
                                        textInput("zip1", "Input five-digit zip code:", value = "16803"),
                                        numericInput("range", "Input miles from zip code:", 2.0, min = 0, max = 100, step = 0.1),
                                        submitButton("Submit"),
                                        width = 4
                                  ),
                                  mainPanel(
                                        leafletOutput("plot"),
                                        h3("Near MacDonalds found:"),
                                        dataTableOutput("pred"),
                                        width = 8
                                  )
                            )
                   ),
                   
                   # Second panel documentation
                   tabPanel("About",
                            mainPanel(
                                  includeMarkdown("README.md")
                            )
                   )
))
