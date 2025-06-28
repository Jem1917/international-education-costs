
install.packages("shiny")
library(shiny)
library(ggplot2)
library(dplyr)
library(readxl)
library(DT)
library(factoextra)
library(tibble)

# Load and clean data

cost_cols <- c("Tuition_USD", "Rent_USD", "Visa_Fee_USD", "Insurance_USD", "Total_Cost")

# UI
ui <- fluidPage(
  titlePanel("International Education Cost Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("country", "Select Country", choices = unique(iec$Country), selected = "India", multiple = TRUE)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Component Comparison", plotOutput("barPlot")),
        tabPanel("Cost Prediction", verbatimTextOutput("regSummary")),
        tabPanel("Clustering", plotOutput("clusterPlot")),
        tabPanel("Raw Data", DTOutput("dataTable"))
      )
    )
  )
)

# Server
server <- function(input, output) {
  
  filtered_data <- reactive({
    req(input$country)
    iec %>% filter(Country %in% input$country)
  })
  
  # Bar Plot
  output$barPlot <- renderPlot({
    data_long <- filtered_data() %>%
      pivot_longer(cols = cost_cols[1:4], names_to = "Type", values_to = "Amount")
    
    ggplot(data_long, aes(x = Type, y = Amount, fill = Type)) +
      geom_bar(stat = "summary", fun = "mean") +
      labs(title = "Average Cost Components", y = "USD") +
      theme_minimal()
  })
  
  # Regression Summary
  output$regSummary <- renderPrint({
    model <- lm(Total_Cost ~ Tuition_USD + Rent_USD + Visa_Fee_USD + Insurance_USD, data = filtered_data())
    summary(model)
  })
  
  # Clustering
  output$clusterPlot <- renderPlot({
    clust_data <- iec %>%
      group_by(Country) %>%
      summarise(across(all_of(cost_cols[1:4]), mean, na.rm = TRUE)) %>%
      column_to_rownames("Country") %>%
      scale()
    
    k <- kmeans(clust_data, centers = 3)
    fviz_cluster(k, data = clust_data)
  })
  
  # Raw Data Table
  output$dataTable <- renderDT({
    datatable(filtered_data())
  })
}

# Run app
shinyApp(ui, server)

