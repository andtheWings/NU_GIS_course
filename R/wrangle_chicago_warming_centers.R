wrangle_chicago_warming_centers <- function(wrangle_chicago_warming_centers_csv) {
    
    read_csv(wrangle_chicago_warming_centers_csv) |> 
        separate(
            LOCATION, 
            sep = "\n", 
            into = c("street", "city_state_zip", "coords")
        ) |> 
        mutate(coords = str_remove_all(coords, "[\\(\\)]")) |> 
        separate(
            coords,
            sep = ",",
            into = c("lat", "long")
        ) |> 
        mutate(
            lat = as.numeric(lat),
            long = as.numeric(long)
        ) |> 
        st_as_sf(coords = c("long", "lat")) |> 
        st_set_crs(4326) |> 
        # select(
        #     name = `SITE NAME`,
        #     hours = `HOURS OF OPERATION`,
        #     street_address = ADDRESS,
        #     phone = PHONE,
        #     city = CITY,
        #     type = `SITE TYPE`
        # ) |> 
        st_transform(26971)
    
}