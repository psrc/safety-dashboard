# Packages ----------------------------------------------------------------

# Packages for Interactive Web application
library(shiny)
library(shinydashboard)
library(bs4Dash)

# Packages for Data Cleaning/Processing
library(tidyverse)

# Packages for Chart Creation
library(psrcplot)
#library(ggplot2)
#library(scales)
library(plotly)

# Packages for Map Creation
library(sf)
library(leaflet)

# Packages for Table Creation
#library(DT)

# Run Modules files -------------------------------------------------------
module_files <- list.files('modules', full.names = TRUE)
sapply(module_files, source)

# Inputs ---------------------------------------------------------------
wgs84 <- 4326

data <- read_csv("data/fatal_collision_data.csv", show_col_types = FALSE) %>% mutate(data_year = as.character(year))

# Text Data ---------------------------------------------------------------
safety_overview_1 <- paste0("Safety was one of the key policy focus areas identified by PSRC’s Transportation Policy Board early in ",
                            "the development of the RTP and is a cross-cutting issue addressed throughout all relevant sections of ",
                            "the plan. VISION 2050 set a goal for the region to have a “sustainable, equitable, affordable, safe, and ",
                            "efficient multimodal transportation system, with specific emphasis on an integrated regional transit ",
                            "network that supports the Regional Growth Strategy and promotes vitality of the economy, ",
                            "environment, and health.” In addition, VISION 2050 adopted the following policy related to safety:")

safety_overview_2 <- paste0("MPP T-4: Improve the safety of the transportation system and, in the long term, achieve the ",
                            "state’s goal of zero deaths and serious injuries.")

safety_overview_3 <- paste0("In 2019, the State of Washington adopted the Target Zero plan with the goal to reduce the number of ",
                            "traffic deaths and serious injuries on Washington's roadways to zero by the year 2030. The RTP will ",
                            "implement the region’s safety goals through a Safe Systems Approach.")

safety_overview_4 <- paste0("Safety impacts every aspect of the transportation system, covering all modes and encompassing a ",
                            "variety of attributes from facility design to security to personal behavior. The Federal Highway ",
                            "Administration (FHWA) refers to the Four E’s of safety: engineering, enforcement, education and emergency medical services.")

safety_overview_5 <- paste0("Many organizations and jurisdictions have implemented programs and projects aimed at improving ",
                            "safety and reducing deaths and serious injuries. All seek to achieve the long-term goal of zero fatalities ",
                            "and serious injuries.")

fatal_overiew_1 <- paste0("Safety impacts every aspect of the transportation system, covering all modes and encompassing a ",
                         "variety of attributes from facility design to security to personal behavior. The Federal Highway ",
                         "Administration (FHWA) refers to the Four E’s of safety: engineering, enforcement, education and ",
                         "emergency medical services. Many organizations and jurisdictions have implemented programs ",
                         "and projects aimed at improving safety and reducing deaths and serious injuries. All seek to ",
                         "achieve the long-term goal of zero fatalities and serious injuries.")

region_fatality_rate <- data %>% filter(variable=="Region" & grouping=="All" & data_year==2021) %>% select(fatality_rate) %>% pull()

# City Data ---------------------------------------------------------------
latest_yr <- data %>% filter(variable=="Region" & grouping=="All") %>% select(year) %>% distinct() %>% pull() %>% max()
first_yr <- data %>% filter(variable=="Region" & grouping=="All") %>% select(year) %>% distinct() %>% pull() %>% min()
previous_yr <- latest_yr-5

city_latest <- data %>% filter(variable=="City" & metric=="5-year average for fatal collisions" & year==latest_yr & fatality_rate>0) %>% select("data_year", Fatalities="fatality_rate", "geography", "grouping")
city_previous <- data %>% filter(variable=="City" & metric=="5-year average for fatal collisions" & year==previous_yr & fatality_rate>0) %>% select("data_year", Fatalities="fatality_rate", "geography", "grouping")

