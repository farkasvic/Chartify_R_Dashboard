# Chartify (R Deployment)

This repository contains an individual assignment to re-implement the Chartify dashboard using R Shiny. 
The application explores a cleaned Spotify dataset, allowing users to filter music data by artist and visualize their streaming metrics and audio features.

**Live Application:** https://019ce8ac-35dc-b51c-3bc8-55c5e216d457.share.connect.posit.cloud/

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
```

### 2. Download the Repository
Clone or download this repository to your local machine, and extract the files if necessary.

### 3. Run the Application
1. Open the `app.R` file in RStudio.
2. **Important:** Ensure your R session's working directory is set to the folder containing `app.R`. This allows the app to correctly locate the dataset using the relative path (`data/spotify_clean.csv`).
3. Click the **Run App** button in the top right corner of the RStudio script editor, or type the following command into your R console and hit enter:

```R
shiny::runApp()
```