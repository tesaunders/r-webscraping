# Load packages -----------------------------------------------------------

library(tidyverse)

# Read in all files in data directory, bind together ----------------------

top_tv <- 
  list.files(path = "data", full.names = TRUE) |> 
  read_csv() |> 
  bind_rows() |> 
  select(-...1)

# Convert date column to a date -------------------------------------------

top_tv$date <- ymd(top_tv$date)


# Plot top 3 titles at start of data collection ---------------------------

top_tv |> 
  filter(title %in% c("American Primeval", "Landman", "Severance")) |> 
  ggplot(aes(x = date, y = position, colour = title)) +
  geom_line() +
  theme_bw()

# How many weeks of data do we have?

length(list.files(path = "data"))

# Which shows have stayed in the top 25?

popular <-
  top_tv |> 
  group_by(title) |> 
  tally() |> 
  filter(n == length(list.files(path = "data")))

# Plot the most enduringly popular shows

top_tv |> 
  filter(title %in% popular$title) |> 
  ggplot(aes(x = date, y = position, colour = title)) +
  geom_line() +
  theme_bw() +
  scale_y_reverse()

# Calculate the difference between start and end rank for most popular shows

pop_start <-
top_tv |> 
  filter(title %in% popular$title) |> 
  group_by(title) |> 
  slice(which(date == min(date))) |> 
  select(position) |> 
  rename(pos_start = position)

pop_end <-
top_tv |> 
  filter(title %in% popular$title) |> 
  group_by(title) |> 
  slice(which(date == max(date))) |> 
  select(position) |> 
  rename(pos_end = position)

pop_tv <- 
  left_join(pop_start, pop_end) |> 
  mutate(
    diff = pos_start - pos_end
  )


