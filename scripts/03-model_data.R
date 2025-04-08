#### Preamble ####
# Purpose: Models average flight delays using a factorial experiment with airline, airport, and season as factors.
# Author: Jiwon Choi
# Date: 7 April 2025
# Contact: jwon.choi@mail.utoronto.ca
# License: MIT
# Pre-requisites: cleaned data set (01-clean_data.R)
# Notes:
#   - This model tests for main and interaction effects using ANOVA (aov).

#### Workspace setup ####
library(tidyverse)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/cleaned_data.csv")

### Model data ####
model <- aov(avg_delay ~ carrier * airport * season, data = cleaned_data)
print(model)
summary(model)

#### Save model ####
saveRDS(
  model,
  file = "models/nyc_model.rds"
)


