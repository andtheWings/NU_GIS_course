wrangle_cold_deaths <- function(ccme_archive_geojson) {
    
    st_read(ccme_archive_geojson) |> 
        filter(COLD_RELATED == "YES") |> 
        filter(!is.na(latitude) & !is.na(longitude)) |> 
        filter(INCIDENT_CITY == "CHICAGO") |> 
        # filter(
        #     str_detect(PRIMARYCAUSE, "HYPOTHERMIA") |
        #         str_detect(PRIMARYCAUSE, "COLD")
        # ) |> 
        st_transform(26971)
}