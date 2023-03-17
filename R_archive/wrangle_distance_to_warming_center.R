case_numbers <- chicago_metro_cold_deaths$CASENUMBER
warming_names <- chicago_metro_warming_centers$name


closest_centers <-
    st_distance(chicago_metro_cold_deaths, chicago_metro_warming_centers) |> 
    matrix(nrow = length(case_numbers), ncol = length(warming_names), dimnames = list(case_numbers, warming_names)) |> 
    as_tibble() |> 
    mutate(case_number = case_numbers, .before = everything()) |> 
    pivot_longer(
        cols = 2:(length(warming_names)+1),
        names_to = "warming_center",
        values_to = "distance_meters"
    ) |> 
    group_by(case_number) |>
    slice_min(order_by = distance_meters, n = 5) |> 
    ungroup()