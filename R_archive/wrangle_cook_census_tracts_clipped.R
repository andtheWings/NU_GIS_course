wrangle_cook_census_tracts_clipped <- function(cook_census_tracts_clipped_file_shp) {
    
    st_read("data/cook_census_tracts_clipped/cook_census_tracts_clipped.shp") |> 
        st_transform(4326) |> 
        select(GEOID)
    
}