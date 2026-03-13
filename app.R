library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)

df <- read.csv('data/spotify_clean.csv')


ui <- page_sidebar(
  title = "Chartify R Deployement",
  theme = bs_theme(bootswatch = "darkly", primary = "#1DB954"), 
  
  #input
  sidebar = sidebar(
    selectInput("artist", "Select Artist:", choices = unique(df$Artist))
  ),
  
  layout_columns(
    value_box(
      title = "Average Streams",
      value = textOutput("avg_streams"),
      theme = "success",
      showcase = bsicons::bs_icon("music-note")
    )
  ),
  card(
    card_header("Streams vs Danceability"),
    plotOutput("scatter_plot")
  )
)


server <- function(input, output, session) {
  
  #reactive calc
  filtered_data <- reactive({
    df %>% filter(Artist == input$artist)
  })
  
  #output 1
  output$avg_streams <- renderText({
    data <- filtered_data()
    req(nrow(data) > 0)
    
    # Remove commas, convert to numeric, and divide by 1 Million
    streams_clean <- as.numeric(gsub(",", "", data$Stream))
    avg <- mean(streams_clean, na.rm = TRUE) / 1000000
    
    #format the metric to millions
    paste0(formatC(avg, format = "f", digits = 2, big.mark = ","), " M")
  })
  
  #output 2
  output$scatter_plot <- renderPlot({
    data <- filtered_data()
    req(nrow(data) > 0)
    
    # Clean the data and convert streams to millions for the plot
    data$Stream <- as.numeric(gsub(",", "", data$Stream)) / 1000000
    
    ggplot(data, aes(x = Stream, y = Danceability)) +
      geom_point(color = "#1DB954", size = 5, alpha = 0.8) +
      theme_minimal(base_size = 14) +
      theme(
        plot.background = element_rect(fill = "#222222", color = NA),
        panel.background = element_rect(fill = "#222222", color = NA),
        text = element_text(color = "white"),
        axis.text = element_text(color = "gray80"),
        panel.grid.major = element_line(color = "gray30"),
        panel.grid.minor = element_blank()
      ) +
      labs(x = "Total Streams (Millions)", y = "Danceability")
  })
}

shinyApp(ui, server)