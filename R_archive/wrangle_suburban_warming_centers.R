wrangle_suburban_warming_centers <- function(suburban_warming_centers_geojson) {
    
    st_read(suburban_warming_centers_geojson) |> 
        select(
            name,
            hours = hours_of_operation,
            street_address = streetaddress,
            phone = contactphone,
            city
        )
    
}