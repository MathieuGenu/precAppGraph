#' Precautionary approach graph
#'
#' @param fish_data data.frame representing fishing information for each years.
#' It contains at least : \itemize{
#'   \item year
#'   \item SSB : spawning stock biomass
#'   \item F : Fishing mortality
#' }
#' @param Fpa integer. Preacautionary approach fishing mortality
#' @param Flim integer. Limit fishing mortality
#' @param Bpa integer. Preacautionary approach Biomass of the spawning part
#' @param Blim integer. Limit Biomass of the spawning part
#'
#' @return The function return a ggplot object.
#' @export
#'
#' @examples
#' @import ggplot2
#' @import magrittr
#' @importFrom scales label_number_si
#' @importFrom ggrepel geom_text_repel

pa_graph <- function(fish_data, Fpa, Flim, Bpa, Blim){

  df_rect <- data.frame(
    xmin = rep(c(0,Fpa,Flim),3),
    xmax = rep(c(Fpa, Flim, Inf),3),
    ymin = c(rep(0,3),rep(Blim,3),rep(Bpa,3)),
    ymax = c(rep(Blim,3),rep(Bpa,3),rep(Inf,3))
  )

  # add reference points on x and y axis
  pretty_x_axis <- pretty(c(0, (max(fish_data$F) + 0.05 * max(fish_data$F))))
  pretty_y_axis <- pretty(c(0, max(fish_data$SSB) + 0.05 * max(fish_data$SSB)))

  gg <- fish_data %>%
    ggplot(aes(F,SSB, label = Year, colour = Year)) +
    geom_rect(data = df_rect, aes(xmin = xmin,
                                  xmax = xmax,
                                  ymin = ymin,
                                  ymax = ymax),
              inherit.aes = F,
              fill = c("yellow","orange","red","yellow","orange","orange","green","yellow","yellow"),
              color = "black") +
    geom_path(aes(colour = Year),
              size = 1.5,
              lineend = 'round') +
    geom_text_repel(aes(colour = Year)) +
    geom_point(size = 3) +
    scale_x_continuous(expand = c(0,0),
                       limits = c(0, (max(fish_data$F) + 0.05 * max(fish_data$F))),
                       breaks = c(pretty_x_axis, Flim, Fpa),
                       labels = c(pretty_x_axis, "Flim", "Fpa")
    ) +
    scale_y_continuous(expand = c(0,0),
                       limits = c(0, max(fish_data$SSB) + 0.05 * max(fish_data$SSB)),
                       breaks = c(pretty_y_axis, Blim, Bpa),
                       labels = c(pretty_y_axis, "Blim", "Bpa")
    ) +
    labs(
      x = "Fishing Mortality",
      y = "SSB (in tons)"
    )

  print(gg)

}
