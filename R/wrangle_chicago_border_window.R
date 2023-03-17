wrangle_chicago_border_window <- function(chicago_border_geojson) {
    
    st_read(chicago_border_geojson) |> 
        st_transform(26971) |> 
        as.owin()
    
}