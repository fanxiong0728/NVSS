# Loading necessary libraries for data manipulation, file handling, and date operations
library(tidyverse)
library(fs)
library(lubridate)
library(janitor)
library(data.table)

# Setting options to avoid scientific notation in R outputs
options(scipen = 999)

# A custom function to load and process text files. It reads a file, cleans column names,
# trims string values, and adds several new columns based on file name patterns.

load_nvss_txt <- function(x) {
  df <-
    data.table::fread(file = x,
                      sep = "\t",
                      colClasses = "character")
  df <- janitor::clean_names(df)
  df <- df %>% dplyr::mutate(across(everything(), stringr::str_trim))
  df <- df %>%
    dplyr::mutate(
      deaths_numeric = as.numeric(deaths),
      filepath = as.character(x),
      file_sanitize = fs::path_sanitize(filepath),
      file_clean = fs::path_ext_remove(file_sanitize),
      final_provisional =
        dplyr::case_match(
          file_clean,
          "datafinal_1999_2000_year_state" ~ "final",
          "datafinal_1999_2000_year_state_gender" ~ "final",
          "datafinal_1999_2000_year_state_gender_10years_age" ~ "final",
          "datafinal_1999_2000_year_state_gender_5years_age" ~ "final",
          "datafinal_1999_2004_year_state_gender_singleyears_age" ~ "final",
          "datafinal_2005_2010_year_state_gender_singleyears_age" ~ "final",
          "datafinal_2011_2016_year_state_gender_singleyears_age" ~ "final",
          "datafinal_2017_2020_year_state_gender_singleyears_age" ~ "final",
          "datafinal_2018_2021_year_state" ~ "final",
          "datafinal_2018_2021_year_state_gender" ~ "final",
          "datafinal_2018_2021_year_state_gender_10years_age" ~ "final",
          "datafinal_2018_2021_year_state_gender_5years_age" ~ "final",
          "datafinal_2018_2021_year_state_gender_singleyears_age" ~ "final",
          "dataprovisional_2018_2024_year_state" ~ "provisional",
          "dataprovisional_2018_2024_year_state_gender" ~ "provisional",
          "dataprovisional_2018_2024_year_state_gender_10years_age" ~ "provisional",
          "dataprovisional_2018_2024_year_state_gender_5years_age" ~ "provisional",
          "dataprovisional_2018_2024_year_state_gender_singleyears_age" ~ "provisional"
        ),
      grouping =
        dplyr::case_match(
          file_clean,
          "datafinal_1999_2000_year_state" ~ "state_total",
          "datafinal_1999_2000_year_state_gender" ~ "state_gender_allages",
          "datafinal_1999_2000_year_state_gender_10years_age" ~ "state_gender_10years_age",
          "datafinal_1999_2000_year_state_gender_5years_age" ~ "state_gender_5years_age",
          "datafinal_1999_2004_year_state_gender_singleyears_age" ~ "state_gender_singleyears_age",
          "datafinal_2005_2010_year_state_gender_singleyears_age" ~ "state_gender_singleyears_age",
          "datafinal_2011_2016_year_state_gender_singleyears_age" ~ "state_gender_singleyears_age",
          "datafinal_2017_2020_year_state_gender_singleyears_age" ~ "state_gender_singleyears_age",
          "datafinal_2018_2021_year_state" ~ "state_total",
          "datafinal_2018_2021_year_state_gender" ~ "state_gender_allages",
          "datafinal_2018_2021_year_state_gender_10years_age" ~ "state_gender_10years_age",
          "datafinal_2018_2021_year_state_gender_5years_age" ~ "state_gender_5years_age",
          "datafinal_2018_2021_year_state_gender_singleyears_age" ~ "state_gender_singleyears_age",
          "dataprovisional_2018_2024_year_state" ~ "state_total",
          "dataprovisional_2018_2024_year_state_gender" ~ "state_gender_allages",
          "dataprovisional_2018_2024_year_state_gender_10years_age" ~ "state_gender_10years_age",
          "dataprovisional_2018_2024_year_state_gender_5years_age" ~ "state_gender_5years_age",
          "dataprovisional_2018_2024_year_state_gender_singleyears_age" ~ "state_gender_singleyears_age"
        ),
      race_population =
        dplyr::case_match(
          file_clean,
          "datafinal_1999_2000_year_state" ~ "bridged_race",
          "datafinal_1999_2000_year_state_gender" ~ "bridged_race",
          "datafinal_1999_2000_year_state_gender_10years_age" ~ "bridged_race",
          "datafinal_1999_2000_year_state_gender_5years_age" ~ "bridged_race",
          "datafinal_1999_2004_year_state_gender_singleyears_age" ~ "bridged_race",
          "datafinal_2005_2010_year_state_gender_singleyears_age" ~ "bridged_race",
          "datafinal_2011_2016_year_state_gender_singleyears_age" ~ "bridged_race",
          "datafinal_2017_2020_year_state_gender_singleyears_age" ~ "bridged_race",
          "datafinal_2018_2021_year_state" ~ "single_race",
          "datafinal_2018_2021_year_state_gender" ~ "single_race",
          "datafinal_2018_2021_year_state_gender_10years_age" ~ "single_race",
          "datafinal_2018_2021_year_state_gender_5years_age" ~ "single_race",
          "datafinal_2018_2021_year_state_gender_singleyears_age" ~ "single_race",
          "dataprovisional_2018_2024_year_state" ~ "single_race",
          "dataprovisional_2018_2024_year_state_gender" ~ "single_race",
          "dataprovisional_2018_2024_year_state_gender_10years_age" ~ "single_race",
          "dataprovisional_2018_2024_year_state_gender_5years_age" ~ "single_race",
          "dataprovisional_2018_2024_year_state_gender_singleyears_age" ~ "single_race"
        )
    )
  return(df)
}


## Load all files from CDC WONDER
## unless otherwise indicated each file was aggregated by:
# year of death
# Residence State
# Decedent Gender
# Age groups (all age, single year, 5 years, and 10 years)

# Listing all files in the 'data' directory and using the custom function to load and combine them into one dataframe
final_files <- list.files("data", full.names = T)
final_df_all <- purrr::map_dfr(final_files, load_nvss_txt)

# Modifying the combined dataframe to coalesce missing gender and age group data, and selecting relevant columns
final_df_all <-
  final_df_all %>%
  # code for transformations
  dplyr::mutate(
    gender_code = coalesce(gender_code, "All"),
    gender = coalesce(gender, "All Gender"),
    age_group_codes = coalesce(
      ten_year_age_groups_code,
      five_year_age_groups_code,
      single_year_ages_code,
      "All"
    ),
    age_group_labels = coalesce(
      ten_year_age_groups,
      five_year_age_groups,
      single_year_ages,
      "All Ages"
    )
  )

final_df_all <- final_df_all %>%
  dplyr::select(-all_of(
    c(
      "ten_year_age_groups_code",
      "five_year_age_groups_code",
      "single_year_ages_code",
      "ten_year_age_groups",
      "five_year_age_groups",
      "single_year_ages"
    )
  ))

# Displaying the structure of the transformed data
glimpse(final_df_all)

# Aggregating data by several categories and summarizing total deaths
aggregate <-
  final_df_all %>%
  # Code for aggregation
  dplyr::group_by(final_provisional, grouping, year_code, race_population) %>%
  dplyr::summarise(total_deaths = sum(deaths_numeric, na.rm = T))

# Reshaping aggregated data and calculating suppressed data in various categories
aggregate_wide <-
  aggregate %>%
  # Code for pivoting and calculations
  tidyr::pivot_wider(names_from = "grouping",
                     values_from = "total_deaths")

glimpse(aggregate_wide)

## state_total was not suppressed since these are the total by states
## How many deaths were suppressed?
aggregate_wide <-
  aggregate_wide %>%
  dplyr::mutate(
    suppressed_gender_10years_age = state_total - state_gender_10years_age,
    suppressed_gender_5years_age = state_total - state_gender_5years_age,
    suppressed_gender_singleyears_age = state_total - state_gender_singleyears_age,
    suppressed_gender_allages = state_total - state_gender_allages
  )

# Writing the final aggregated and calculated data to a CSV file
readr::write_csv(aggregate_wide, file = "results/suppression_compare.csv")
