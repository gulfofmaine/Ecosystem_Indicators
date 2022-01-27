library(shiny)
library(tidyverse)
library(maps)
library(lubridate)
library(sf)

map_state <- map_data(map="state")
ne_us <- subset(map_state, region %in% c("maine"))
mcc_turnoff_subset <- read_csv("Data/mcc_turnoff_subset.csv")
mcc_pca_pc1_2 <- read_csv("Data/mcc_pca_pc1_2.csv")

ui <- bootstrapPage(
  sidebarPanel(fluidRow(column(width = 12,
                               "Use the 'Year' and 'Month' sliders to change the date of the water current data on the plot to the right.")),
               sliderInput("fvcom_yr", "Year",
                            min = 1978,
                            max = 2016,
                            value = 2016,
                            animate = animationOptions(interval = 3000)),
               sliderInput("fvcom_mon", "Month",
                           min = 1,
                           max = 12,
                           value = 1,
                           animate = animationOptions(interval = 3000)),
               fluidRow(
                 column(width = 12,
                        "Click on the year labels in the graph below to change the plot to that year. 
                        Postive PC1 indicates offshore and northwestern water movement, and negative PC1 indicates strong southeasternly water movement")
               ),
               plotOutput("PC2", click = "plot_click")),
  mainPanel(plotOutput("plotA", height = 800))
)


server <- function(input, output, session) {
  
  # reactive filtering data from UI
  
  output$PC2 <- renderPlot({
    mcc_pca_pc1_2 %>% filter(mon == input$fvcom_mon) %>% 
      ggplot() + geom_point(aes(x = PC1, y = PC2)) +
      geom_label(aes(x = PC1, y = PC2, label =yr), position = position_dodge(width = .01)) + theme_bw() +
      ylim(-19, 30) + xlim(-21.5, 46)
  })
  
  reactive_date <- reactive({

    df <- mcc_turnoff_subset %>% # gom_cur has all vectors
      mutate(yr = year(as.Date(Date)), mon = month(as.Date(Date))) %>% 
      filter(yr >= 1978, yr == input$fvcom_yr, mon == input$fvcom_mon)
  })
  
  observeEvent(input$plot_click, {
    clicks <- nearPoints(mcc_pca_pc1_2, input$plot_click)
    
    yr <- year(clicks$Date)
      
    updateSliderInput(session, "fvcom_yr", value = yr)
  })
  
  output$plotA <- renderPlot({
    reactive_date() %>% mutate(vel = sqrt(u^2+v^2)) %>% 
      ggplot() + 
      geom_polygon(data= ne_us, aes(x = long, y = lat, group = group), fill = "grey", color = "black") + 
      geom_segment(aes(x = lon, y = lat, xend=lon+u, yend=lat+v, color = vel), 
                   arrow = arrow(angle = 30, length = unit(0.05, "inches"), type = "closed")) + 
      scale_color_viridis_c(limits = c(0, 0.48)) + theme_bw() + 
      coord_sf(datum = "+proj=longlat +datum=NAD83 +no_defs +ellps=GRS80 +towgs84=0,0,0") 
    
  })
  
}

shinyApp(ui, server)
