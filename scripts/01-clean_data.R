#### Preamble ####
# Purpose: Cleans BTS flight delay data for factorial analysis by airline, airport, and season.
# Author: Jiwon Choi
# Date: 7 April 2025
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: download data
# Notes:
#   - Filters for Delta (DL) and American Airlines (AA) only
#   - Limits to NYC airports: JFK, LGA, EWR
#   - Aggregates by season: Spring (Mar–May), Summer (Jun–Aug), Fall (Sep–Nov), Winter (Dec–Feb)
#   - Computes average arrival delay per flight

#### Workspace setup ####
library(dplyr)
library(tidyr)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/Airline_Delay_Cause.csv")

cleaned_data <- raw_data %>%
  filter(carrier %in% c("DL", "AA"),
         airport %in% c("EWR", "JFK", "LGA")) %>%
  mutate(
    avg_delay = arr_delay / arr_flights,
    season = case_when(
      month %in% c(3, 4, 5) ~ "Spring",
      month %in% c(6, 7, 8) ~ "Summer",
      month %in% c(9, 10, 11) ~ "Fall",
      month %in% c(12, 1, 2) ~ "Winter"
    ),
    season = factor(season, levels = c("Spring", "Summer", "Fall", "Winter"))
  ) %>%
  filter(!is.na(avg_delay),
         arr_flights >= 2) %>%
  select(carrier, airport, season, avg_delay) %>%
  mutate(across(c(carrier, airport, season), as.factor)) %>%
  drop_na()

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/cleaned_data.csv")

