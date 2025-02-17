library(rvest)
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)

html <- read_html("https://en.wikipedia.org/wiki/List_of_prime_ministers_of_New_Zealand")

raw_list <- html |> 
  html_elements("table.wikitable") |> 
  html_table()

pm_list <- raw_list |> 
  map(pluck) |> 
  bind_rows()

pm_list <- pm_list |> 
  filter(No. != "No.") |> 
  select(3, 5:8) |> 
  rename("name" = 1,
         "start" = 2,
         "end" = 3,
         "duration" = 4,
         "party" = 5) |>
  mutate(
    born = str_extract_all(name, "\\([0-9]{4}"),
    died = str_extract_all(name, "[0-9]{4}\\)")
  )
  
pm_list$name <- str_remove_all(pm_list$name, c("The Honourable|The Right Honourable|
                                               MP.*|KC.*|GC.*|Counc.*|MC.*|
                                               CH.*|Bt.*|CH.*|KG.*|GB.*|JP.*|
                                               ON.*|DN.*|GN.*|KN.*"))
  

