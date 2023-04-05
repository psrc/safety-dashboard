library(tidyverse)
library(psrcsafety)

recalculate_pop <- "no"

fatal_collision_data <- wstc_fatal_collisions()

if (recalculate_pop == 'yes') {

  population_demographics <- demographic_population_data()  
  write_csv(population_demographics, "C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/population_demographics.csv")
  
  population_rgeo <- population_regional_geography()
  write_csv(population_rgeo, "C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/population_regeo.csv")
  
  population_centers <- population_regional_centers()
  write_csv(population_centers, "C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/population_centers.csv")
  
  population_counties <- population_county()
  write_csv(population_counties, "C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/population_counties.csv")
  
  population_cities <- population_city()
  write_csv(population_cities, "C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/population_cities.csv")
  
} else {
  
  population_demographics <- read_csv("C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/population_demographics.csv", show_col_types = FALSE)
  population_rgeo <- read_csv("C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/population_regeo.csv", show_col_types = FALSE)
  population_centers <- read_csv("C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/population_centers.csv", show_col_types = FALSE)
  population_counties <- read_csv("C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/population_counties.csv", show_col_types = FALSE)
  population_cities <- read_csv("C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/population_cities.csv", show_col_types = FALSE)
  
}

combined_population_data <- bind_rows(population_demographics, population_rgeo, population_centers, population_counties, population_cities)

fatal_collisions_geography_1yr <- fatalites_by_geography(collision_data=fatal_collision_data, population_data=combined_population_data, span = 1, data_years = seq(2010, 2021, by = 1))
fatal_collisions_geography_5yr <- fatalites_by_geography(collision_data=fatal_collision_data, population_data=combined_population_data, span = 5, data_years = seq(2014, 2021, by = 1))

fatal_collisions_demographics_1yr <- fatalites_by_demographics(collision_data=fatal_collision_data, population_data=combined_population_data, span = 1, data_years = seq(2010, 2021, by = 1))
fatal_collisions_demographics_5yr <- fatalites_by_demographics(collision_data=fatal_collision_data, population_data=combined_population_data, span = 5, data_years = seq(2014, 2021, by = 1))

fatal_collisions_by_geography <- bind_rows(fatal_collisions_geography_1yr, fatal_collisions_geography_5yr,
                                           fatal_collisions_demographics_1yr, fatal_collisions_demographics_5yr)
write_csv(fatal_collisions_by_geography, "C:/Users/chelmann/OneDrive - Puget Sound Regional Council/coding/saftey-plan/data/fatal_collision_data.csv")



data_years <- 2010
counties <- c("King", "Kitsap", "Pierce") 

processed <- NULL
for (year in data_years) {
  
  for (county in counties) {
  
    data_file <- stringr::str_glue("X:/DSA/rtp-dashboard/WSDOT/20230331Simonson All roads in {county} County MRFF {year}.csv")
    print(stringr::str_glue("Working on {year} data processing and cleanup."))
    print("Downloading Fatality Data")
    
    t <- dplyr::as_tibble(readr::read_csv(data_file))
    
    if(is.null(processed)) {processed<-t} else {processed<-dplyr::bind_rows(processed, t)}
    
  } # end county loop
  
} # end year loop



