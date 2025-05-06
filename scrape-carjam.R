library(rvest)
library(glue)
library(purrr)
library(dplyr)
library(readr)

# Define URLs based on a pattern
# https://www.carjam.co.nz/nz-fleet/?l=20&of=0
# l = number of results per page, of = offset

urls <- glue("https://www.carjam.co.nz/nz-fleet/?l=20&of={seq(from = 0, to = 100, by = 20)}")

# Test with a single page

read_html("https://www.carjam.co.nz/nz-fleet/?l=20&of=0") |> 
  html_element(".table") |> 
  html_table()

# Create a function to scrape the table based on css selector

scrape_carjam <- function(url) {
  read_html(url) |> 
    html_element(".table") |>  
    html_table()
}

# Iterate over the urls, applying the function each time

vehicle_fleet <- map(urls, scrape_carjam)

# Bind rows together

vehicle_fleet <- 
  vehicle_fleet |> 
  bind_rows()

# Parse count as numeric

vehicle_fleet$Count <- parse_number(vehicle_fleet$Count)