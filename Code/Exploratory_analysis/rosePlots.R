library(shiny)
ui <- bootstrapPage(
  sidebarPanel( sliderInput("fvcom_period", "Date",
                             min = as.Date(min(current_zoneA_rose$Date), format = "%Y-%m-%d"),
                             max = as.Date(max(current_zoneA_rose$Date), format = "%Y-%m-%d"),
                             value = as.Date(max(current_zoneA_rose$Date), format = "%Y-%m-%d"), 
                             timeFormat = "%b-%Y",
                             width = "90%",
                            animate = TRUE)),
  mainPanel(plotOutput("plotA", height = 350),
            plotOutput("plotB", height = 350),
            plotOutput("plotC", height = 350),
            plotOutput("plotD", height = 350),
            plotOutput("plotE", height = 350),
            plotOutput("plotF", height = 350),
            plotOutput("plotG", height = 350))
)


server <- function(input, output, session) {
  
  # reactive filtering data from UI
  
  reactive_date <- reactive({
    yrs <- lubridate::year(input$fvcom_period)
    mons <- lubridate::month(input$fvcom_period)
    
    df <- all_current_dir %>%
      mutate(yr = year(as.Date(Date)), mon = month(as.Date(Date))) %>% 
      filter(yr == yrs, mon == mons)
  })
  
  output$plotA <- renderPlot({
    zA <- reactive_date() %>% filter(zone == "A")
    windRose(mydata = zA, ws = "vel", wd = "deg", ws.int = .1, paddle = FALSE)
    
  })
  
  output$plotB <- renderPlot({
    zB <- reactive_date() %>% filter(zone == "B")
    windRose(mydata = zB, ws = "vel", wd = "deg", ws.int = .1, paddle = FALSE)
    
  })
  
  output$plotC <- renderPlot({
    zC <- reactive_date() %>% filter(zone == "C")
    windRose(mydata = zC, ws = "vel", wd = "deg", ws.int = .1, paddle = FALSE)
    
  })
  
  output$plotD <- renderPlot({
    zD <- reactive_date() %>% filter(zone == "D")
    windRose(mydata = zD, ws = "vel", wd = "deg", ws.int = .1, paddle = FALSE)
    
  })
  
  output$plotE <- renderPlot({
    zE <- reactive_date() %>% filter(zone == "E")
    windRose(mydata = zE, ws = "vel", wd = "deg", ws.int = .1, paddle = FALSE)
    
  })
  
  output$plotF <- renderPlot({
    zF <- reactive_date() %>% filter(zone == "F")
    windRose(mydata = zF, ws = "vel", wd = "deg", ws.int = .1, paddle = FALSE)
    
  })
  
  output$plotG <- renderPlot({
    zG <- reactive_date() %>% filter(zone == "G")
    windRose(mydata = zG, ws = "vel", wd = "deg", ws.int = .1, paddle = FALSE)
    
  })
  
}

shinyApp(ui, server)
