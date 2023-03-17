library(targets)

sapply(
    paste0("R/", list.files("R/")),
    source
)

# Set target-specific options such as packages.
tar_option_set(
    packages = c(
        "sf", "leaflet", # geospatial
        "dplyr", "janitor", "lubridate", "magrittr", "readr", "purrr", "stringr", "tidyr", # wrangling
        "ggplot2", "ggdist", "gt", # tables and plots
        "performance" # modeling
    )
)


list(
  
    # Sources
    
    ## Tigerline Cook County Census Tract Boundaries
    tar_target(
        cook_census_tracts_raw,
        tigris::tracts(state = 17, county = 031)
    ),
    
    ## Census Tract Populations from ESRI
    # tar_target(
    #     esri_tract_data_file,
    #     "data/tracts_0.csv",
    #     format = "file"
    # ),
    # tar_target(
    #     cook_census_tract_populations,
    #     wrangle_cook_census_tract_populations(esri_tract_data_file)
    # ),
    
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
    
    ## Suburban Warming Centers
    ## From: https://www.cookcountyil.gov/service/warming-centers
    tar_target(
        suburban_warming_centers_file,
        "data/Cook County Warming Centers.geojson",
        format = "file"
    ),
    tar_target(
        suburban_warming_centers,
        wrangle_suburban_warming_centers(suburban_warming_centers_file)
    ),
    
    ## Combining Chicago and Suburban Warming Sources
    tar_target(
        cook_county_warming_centers,
        wrangle_cook_county_warming_centers(chicago_warming_centers, suburban_warming_centers)
    ),
    
    ## Cook County Medical Examiner Archive
    ## From: https://hub-cookcountyil.opendata.arcgis.com/datasets/4f7cc9f13542463c89b2055afd4a6dc1_0
    tar_target(
        ccme_archive_file,
        "data/Medical_Examiner_Case_Archive,_2014_to_present.geojson",
        format = "file"
    ),
    tar_target(
        cold_deaths,
        wrangle_cold_deaths(ccme_archive_file)
    ),
    
    ## CDC/ATSDR SVI Data, 2020, United States, Census Tracts
    ## From: https://www.atsdr.cdc.gov/placeandhealth/svi/data_documentation_download.html
    tar_target(
        name = svi_2020_file,
        "data/SVI2020_US.csv",
        format = "file"    
    ),
    tar_target(
        name = svi_2020,
        command = wrangle_svi_2020(svi_2020_file)
    ),
    
    # Work in ArcGIS
    
    ## Downloaded overall boundary of Cook County 
    ## From: https://hub-cookcountyil.opendata.arcgis.com/datasets/ea127f9e96b74677892722069c984198_1/explore
    
    ## Exported Census Tract Boundaries
    ## Clipped to Lake Michigan Shoreline using overall county boundary
    
    tar_target(
        cook_census_tracts_clipped_file,
        "data/cook_census_tracts_clipped/cook_census_tracts_clipped.shp"
    ),
    tar_target(
        cook_census_tracts_clipped,
        wrangle_cook_census_tracts_clipped(cook_census_tracts_clipped_file)
    ),
    
    ## Exported Cook County Warming Centers to ArcGIS
    ## Generated Raster of Accumulated Distance from Warming Centers in Cook County
    ## Averaged Raster Values for Each Cook Census Tract
    
    tar_target(
        avg_distance_to_warming_file,
        "data/avg_distance_to_warming.csv",
        format = "file"
    ),
    tar_target(
        avg_distance_to_warming,
        wrangle_avg_distance_to_warming(avg_distance_to_warming_file)
    )
    
    # Assembly
    
    # tar_target(
    #     tract_case_counts,
    #     wrangle_tract_case_counts(cook_census_tracts_clipped, cold_deaths)
    # ),
    # 
    # tar_target(
    #     cold_death_dataset,
    #     wrangle_cold_death_dataset(
    #         cook_census_tracts_clipped,
    #         tract_case_counts,
    #         avg_distance_to_warming,
    #         svi_2020
    #     )
    # )
    
)
