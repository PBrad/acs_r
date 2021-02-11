##########################################################
# Pull American Community Survey Data via the Census API
#########################################################

## Resources ##

# How to use the Census API
  # https://www.census.gov/programs-surveys/acs/guidance/handbooks/api.html
  # https://www.census.gov/content/dam/Census/library/publications/2020/acs/acs_api_handbook_2020_ch02.pdf

# List of ACS 5-Year Tables/Variables
  # https://api.census.gov/data/2019/acs/acs5/variables.html

# Set Up ------------------------------------------------------------------

library(httr)
library(jsonlite)
library(dplyr)
library(tidyr)
library(readr)

# Specify Parameters ------------------------------------------------------

# As needed, edit the values below to match the dataset, year, variables
# and geography for which you would like to pull data.

api.key <- "[Your API Key]"

url <- "https://api.census.gov/data/"
dataset <- "acs/acs5?"
year <- "2019"
var_list <- c("B01001_001E", "B06011_001E") # Comma separated list of ACS variables 
geo <- "state:*" # pull data for each individual state

# Pull Data ---------------------------------------------------------------

# Builds the GET request
site <- paste0(
  url,
  year, "/",
  dataset,
  "get=NAME,", paste(var_list, collapse=","), "&",
  "for=", geo, "&",
  "key=", api.key)

# Request
r <- GET(site)  

# Extract content text
json <- content(r, as = "text", encoding = "UTF-8")

list.json <- fromJSON(json)

# Convert to a tibble
df <- as_tibble(list.json, .name_repair = "minimal")

# Use first row as headers
header_names <- as.vector(df[1,], mode = "character")

names(df) <-  header_names

# Drop first row (that contained header values)
df <-  df[-1, ] 

# Write out ---------------------------------------------------------------

write_csv(df, "res/census.csv")
