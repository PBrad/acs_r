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

site <- paste0(
  url,
  year, "/",
  dataset,
  "get=NAME,", paste(var_list, collapse=","), "&",
  "for=", geo, "&",
  "key=", api.key)

r <- GET(site)  

json <- httr::content(r, as = "text", encoding = "UTF-8")

list.json <- jsonlite::fromJSON(json)

# Convert to a tibble
df <- as_tibble(list.json)

# Use first row as headers
colnames(df) <- NULL

header.names <- df[1,]
header.names <- as.vector(header.names, mode = "character")
 
names(df) <-  df[1, ] # the first row will be the header
df  <-  df[-1, ]          # removing the first row.

# Write out ---------------------------------------------------------------

write_csv(df, "res/census.csv")
