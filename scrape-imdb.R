# Load packages

library(rvest)
library(stringr)
library(dplyr)

# Define page to read in as html

html <- read_html("https://www.imdb.com/chart/tvmeter/")

# Use CSS selectors to select relevant data

top_title <- html |> 
  html_elements(".ipc-metadata-list-summary-item .ipc-title") |> 
  html_text()

top_type <- html |> 
  html_elements(".cli-title-type-data") |> 
  html_text()

top_metadata <- html |> 
  html_elements(".cli-title-metadata-item") |> 
  html_text()

# Use regular expressions to subset combined data

top_year <- str_subset(top_metadata, "\\d{4}-?")

top_episodes <- top_metadata |> 
  str_subset("eps") |> 
  str_extract("[0-9]+")

# Assemble a dataframe

top_tv <- data.frame(
  title = top_title,
  date = Sys.Date(),
  type = top_type,
  year = top_year,
  episodes = top_episodes) |> 
  mutate(
    position = row_number(),
  ) |> 
  relocate(position, .after = title)

# Save a .csv file where the filename is appended with the date

write.csv(top_tv, paste0("data/top_tv-", Sys.Date(), ".csv"))
