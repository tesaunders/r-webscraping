# Load packages

library(rvest)
library(dplyr)
library(readr)

# Read in Wikipedia page

html_electricity <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_electricity_consumption")

# Grab the table of interest, rename columns,  remove 'world' row and 'year' column

electricity <-
  html_electricity |> 
  html_element(".wikitable") |> 
  html_table() |> 
  rename(
    location = "Location",
    consumption_twh = "Consumption(TWh)",
    per_capita_mwh = "Per capita(MWh)",
  ) |> 
  filter(location != "World") |> 
  select(-Year)

# Convert consumption to numeric

electricity$consumption_twh <-
  parse_number(electricity$consumption_twh)

# Read in another page with a different table - incarceration rates from Wikipedia

html_incarceration <- read_html("https://en.wikipedia.org/wiki/List_of_countries_by_incarceration_rate")

# Convert to a table, drop 'Number', rename column, make rate a numeric column

incarceration <-
  html_incarceration |> 
  html_element(".wikitable") |> 
  html_table() |> 
  select(-Number) |> 
  rename(incarceration_rate = Rates)

incarceration$incarceration_rate <- as.numeric(incarceration$incarceration_rate)

# Join the two tables based on country name

final_table <-
  left_join(x = electricity, 
            y = incarceration,
            by = join_by(location == Location))
