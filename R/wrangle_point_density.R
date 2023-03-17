wrangle_point_density <- function(points_sf, border_sf) {
    
    ppp1 <- as.ppp(points_sf)
    Window(ppp1) <- as.owin(border_sf)
    kde1 <- density(ppp1, 1000)
    
    return(kde1)
    
}