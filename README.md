# Chartify (R Deployment)

This repository contains an individual assignment to re-implement the Chartify dashboard using R Shiny. 
The application explores a cleaned Spotify dataset, allowing users to filter music data by artist and visualize their streaming metrics and audio features.

**Live Application:** [Insert your Posit Connect Cloud URL here]

## Features
This simplified dashboard contains:
1. **Input Component:** A dropdown menu (`selectInput`) to select a specific artist.
2. **Reactive Calculation:** A reactive dataframe that filters the main dataset based on the selected artist.
3. **Output Components:** - A dynamic `value_box` displaying the average streams for the selected artist.
   - A `ggplot2` scatter plot visualizing the relationship between the artist's song Danceability and Total Streams.

## How to Run Locally

To run this application on your own machine, you will need R and RStudio installed. 

### 1. Install Required Packages
Open your R console and run the following command to install the necessary libraries:
```R
install.packages(c("shiny", "bslib", "dplyr", "ggplot2", "bsicons"))