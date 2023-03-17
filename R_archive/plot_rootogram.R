plot_rootogram <- function(model_obj) {
    
    observed_df <-
        model_obj |> 
        insight::get_response() |> 
        janitor::tabyl()
    
    predicted_df <-
        model_obj |> 
        insight::get_predicted() |>
        tibble::as_tibble() |> 
        dplyr::mutate(
            binned_pred = 
                dplyr::case_when(
                    Predicted < 0.5 ~ 0,
                    Predicted >= 0.5 & Predicted < 1.5 ~ 1,
                    Predicted >= 1.5 & Predicted < 2.5 ~ 2,
                    Predicted >= 2.5 & Predicted < 3.5 ~ 3,
                    Predicted >= 3.5 & Predicted < 4.5 ~ 4,
                    Predicted >= 4.5 & Predicted < 5.5 ~ 5,
                    Predicted >= 5.5 ~ 6
                )
        ) |> 
        janitor::tabyl(binned_pred)
    
    diff <- nrow(observed_df) - nrow(predicted_df)
    
    if(diff != 0) {
        predicted_vct <- c(predicted_df$n, rep(0, diff))
    } else {
        predicted_vct <- predicted_df$n
    }
    
    rootogram_tbl <-
        tibble::tibble(
            count_value = observed_df[,1],
            observed_freq = observed_df[,2],
            predicted_freq = predicted_vct
        )
    
    plot1 <-
        rootogram_tbl |> 
        ggplot(
            aes(
                x = count_value,
                y = sqrt(predicted_freq)
            )
        ) +
        geom_hline(
            yintercept = 0,
            linewidth = 0.35
        ) +
        geom_rect(
            aes(
                xmin = count_value - 0.35,
                xmax = count_value + 0.35,
                ymin = sqrt(predicted_freq) - sqrt(observed_freq),
                ymax = sqrt(predicted_freq)
            ),
            fill = "gray60"
        ) +
        geom_line(
            #color = "red"
        ) +
        geom_point(
            #color = "red"
        ) +
        labs(
            title = 
                paste0(
                    "Family: ",
                    insight::model_info(model_obj)$family,
                    ", Zero-Inflated: ",
                    as.character(insight::model_info(model_obj)$is_zero_inflated)
                ),
            x = "Count Value",
            y = "sqrt(Frequency)"
        ) +
        theme_bw()
    
    return(plot1)
    
}