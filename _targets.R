library(targets)

sapply(
    paste0("R/", list.files("R/")),
    source
)

# Set target-specific options such as packages.
tar_option_set(
    packages = c(
        "sf", "spatstat", "terra", "tidyterra", # geospatial
        "dplyr", "janitor", "lubridate", "magrittr", "readr", "purrr", "stringr", "tidyr", # wrangling
        "ggplot2" # tables and plots
    )
)


list(
    
    # Sources
    
    ## Chicago Border
    ## From: https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries-City/ewy2-6yfk
    tar_target(
        chicago_border_file,
        "data/chicago_border.geojson",
        format = "file"
    ),
    tar_target(
        chicago_border_window,
        wrangle_chicago_border_window(chicago_border_file)
    ),
    
    ## Chicago Warming Centers
    ## From: https://data.cityofchicago.org/Health-Human-Services/Warming-Centers-Map/5a76-tqs9
    tar_target(
        chicago_warming_centers_file,
        "data/Warming_Centers_-_Map.csv",
        format = "file"
    ),
    tar_target(
        chicago_warming_centers,
        wrangle_chicago_warming_centers(chicago_warming_centers_file)
    ),
    tar_target(
        chicago_warming_centers_density,
        wrangle_point_density(chicago_warming_centers, chicago_border_window)
    ),
    
    
    ## Cook County Medical Examiner Archive
    ## From: https://hub-cookcountyil.opendata.arcgis.com/datasets/4f7cc9f13542463c89b2055afd4a6dc1_0
    tar_target(
        ccme_archive_file,
        "data/Medical_Examiner_Case_Archive,_2014_to_present.geojson",
        format = "file"
    ),
    tar_target(
        chicago_cold_deaths,
        wrangle_cold_deaths(ccme_archive_file)
    ),
    tar_target(
        chicago_cold_deaths_density,
        wrangle_point_density(chicago_cold_deaths, chicago_border_window)
    )
    
    
    
)