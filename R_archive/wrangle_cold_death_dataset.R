wrangle_cold_death_dataset <- 
    function(
        cook_census_tracts_clipped_sf, 
        tract_case_counts_df, 
        avg_distance_to_warming_df,
        svi_2020_df
        
    ) {
        cook_census_tracts_clipped_sf |> 
            left_join(tract_case_counts_df, by = "GEOID") |> 
            left_join(avg_distance_to_warming_df, by = "GEOID") |> 
            left_join(svi_2020_df, by = "GEOID")
    }