wrangle_avg_distance_to_warming <- function(avg_distance_to_warming_csv) {
    
    read_csv(avg_distance_to_warming_csv) |> 
        select(GEOID, avg_distance_to_warming = MEAN) |> 
        mutate(
            GEOID = as.character(GEOID),
            avg_distance_to_warming = avg_distance_to_warming / 1000
        )
    
}