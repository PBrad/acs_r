American Community Survey - Census API
================

## Description

This repo provides sample R code for pulling American Community Survey
data via the Census API, converting the result to a dataframe, and
writing out to a CSV.

In order to interact with the API, you will first need to request a
[Census API key here.](https://api.census.gov/data/key_signup.html)

Once you have an API key, edit the “Specify Parameters” section of the
*pull\_acs.R* script to indicate which dataset, year, variables, and
geographies you need to access. You can pull data for multiple variables
at a time (up to 50) by entering the table/variable name (e.g.,
"“B01001\_001E” for Total Population) as a comma-separated vector. See
[“Working with the Census Data
API”](https://www.census.gov/content/dam/Census/library/publications/2020/acs/acs_api_handbook_2020_ch02.pdf)
for background on how to interpret variable names. If you’re pulling
5-year ACS data, you can look up table/variable codes
[here](https://api.census.gov/data/2019/acs/acs5/variables.html). For
other datasets, look up the dataset in ["Census API: Datasets in /data
and its descendants](https://api.census.gov/data.html) and click on the
dataset’s associated “variables” link.

``` r
# Specify Parameters ------------------------------------------------------

# As needed, edit the values below to match the dataset, year, variables
# and geography for which you would like to pull data.

api.key <- "[Your API Key]"

url <- "https://api.census.gov/data/"
dataset <- "acs/acs5?"
year <- "2019"
var_list <- c("B01001_001E", "B06011_001E") # Comma-separated vector of ACS variables 
geo <- "state:*" # pull data for each individual state
```

## Resources

**How to use the Census API**

-   [“What Users Need to
    Know”](https://www.census.gov/programs-surveys/acs/guidance/handbooks/api.html)
-   [“Working with the Census Data
    API”](https://www.census.gov/content/dam/Census/library/publications/2020/acs/acs_api_handbook_2020_ch02.pdf)
-   [Census Developers
    Page](https://www.census.gov/data/developers.html)

**Datasets Available via the Census API**

-   ["Census API: Datasets in /data and its
    descendants](https://api.census.gov/data.html)
    -   For each listed dataset, the page provides links to geographies,
        variables, and example API calls (URL)

**List of ACS 5-Year Tables/Variables**

-   [“Census Data API: Variables in
    /data/2019/acs/acs5/variables”](https://api.census.gov/data/2019/acs/acs5/variables.html)
