wrangle_cook_county_warming_centers <- function(chicago_warming_centers_sf, suburban_warming_centers_sf) {
    
    df1 <- bind_rows(chicago_warming_centers_sf, suburban_warming_centers_sf)
    
    df1$name[df1$street_address == "2250 S. 49th Ave,"] <- "The Town of Cicero Community Center"
    df1$name[df1$street_address == "5444 W. 34th St."] <- "Cicero Safety Park"
    
    return(df1)
    
}