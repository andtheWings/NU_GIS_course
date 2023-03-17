wrangle_svi_2020 <- function(svi_2020_csv) {
    
    read_csv(svi_2020_csv) |> 
        filter(STCNTY == 17031) |>
        janitor::clean_names() |>
        select(
            GEOID = fips,
            minority_percentage = ep_minrty,
            day_population_k = e_daypop
            # area_sqmi,
            # starts_with("e_"),
            # starts_with("ep_"),
            # starts_with("epl_"),
            # starts_with("rpl_")
        ) |> 
        mutate(
            day_population_k = day_population_k / 1000
        )
    
}