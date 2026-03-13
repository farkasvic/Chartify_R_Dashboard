library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)

df <- read.csv('data/spotify_clean.csv')


ui <- page_sidebar(
  title = "Chartify R Deployement",
  theme = bs_theme(bootswatch = "darkly", primary = "#1DB954"), 
  
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
    avg <- mean(data$Streams, na.rm = TRUE)
    paste0(formatC(avg, format = "f", digits = 0, big.mark = ","))
  })
  
  #output 2
  output$scatter_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = Danceability, y = Streams)) +
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
      labs(x = "Danceability", y = "Total Streams")
  })
}

shinyApp(ui, server)