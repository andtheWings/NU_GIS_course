wrangle_cook_census_tract_populations <- function(esri_tract_data_csv) {
    
    read_csv(esri_tract_data_csv) |>
        filter(STATE_FIPS == "17" & COUNTY_FIPS == "031") |> 
        select(FIPS, POPULATION_2020) |> 
        filter(POPULATION_2020 != 0) |> 
        filter(!is.na(POPULATION_2020))
    
}