wrangle_tract_case_counts <- function(cook_census_tracts_clipped_sf, cold_deaths_sf) {
    
    st_join(cook_census_tracts_clipped_sf, cold_deaths_sf) |> 
        as_tibble() |> 
        mutate(case_present = !is.na(CASENUMBER)) |> 
        group_by(GEOID) |> 
        summarise(case_count = sum(case_present)) |> 
        mutate(
            case_present = 
                if_else(
                    case_count > 0,
                    TRUE, FALSE
                )
        )
    
}