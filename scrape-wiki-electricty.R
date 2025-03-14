library(rvest)
library(dplyr)
library(purrr)
library(stringr)

html <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_electricity_consumption")

electricity <-
  html |> 
  html_element("table.wikitable") |> 
  html_table()

# Remove world

# Join in regions from poliscidata?

# Add another table from page with multiple tables - cancer rates?
# https://en.wikipedia.org/wiki/List_of_countries_by_cancer_rate

# https://en.wikipedia.org/wiki/List_of_countries_by_incarceration_rate

