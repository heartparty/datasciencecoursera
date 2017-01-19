library(shiny)
library(dplyr)
library(leaflet)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      macdonaldmap <- read.csv("data/Mcdonalds_USA_CAN.csv")
      zipmap <- read.csv("data/us_zip.txt", colClasses = c("character", rep("numeric", 2)))

      ## calculate distance given latitude and longitude respectively
      library(sp)
      
      lat0 <- reactive({
            lat0 <- zipmap[zipmap$ZIP == input$zip1, 2]
            lat0
      })

      lng0 <- reactive({
            lng0 <- zipmap[zipmap$ZIP == input$zip1, 3]
            lng0
      })
      
            
      dest <- reactive({
            df <- macdonaldmap %>%
                  mutate(dist = spDistsN1(as.matrix(macdonaldmap[,1:2]), c(lng0(), lat0()), longlat = TRUE) * 0.621371) %>%
                  filter(dist < input$range) %>%
                  arrange(dist)
            df
      })
      
      output$plot <- renderLeaflet({
            leaflet() %>%
            addTiles() %>%
            addMarkers(lat = lat0(), lng = lng0(), popup = "Where you start!") %>%
            addCircleMarkers(lat = dest()$lat, lng = dest()$long, popup = dest()$addr)
      })
      
      output$pred <- renderDataTable({
            dest()[,3:5]
      })
})
