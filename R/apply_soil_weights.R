#' Creates full raster layers for each soil component applying weights to each
#' @param raster_list a list of raster data for each soil property to which to apply the weights
#' @param weight_list the list of weights to apply to those soil layers. Defaults specified and shouldn't need to be altered.
#' @return a single raster for each soil component with appropriate weights applied
#' @examples
#' \dontrun{apply_soil_weights(raster_list, weight_list = list(5/30, 10/30, 15/30))}


apply_soil_weights <- function(raster_list, weight_list = list(5/30, 10/30, 15/30)){

  weight_sum <- do.call(sum, weight_list)
  if(weight_sum != 1){
    stop("\n Weights don't add up to 1. Check weights.")
  }

  filtered_list <- length_filter(raster_list)

  sublist_length <- lapply(filtered_list[[1]], function(l) length(l))
  if(!all(sublist_length == length(weight_list))){
    stop("\n weight list is not the same length as soil rasters. Check rasters and weights!")
  }

  layers_to_weigh = lapply(filtered_list[[1]], function(soil_set){
    Map("*", soil_set, weight_list)})

  raster_weights <- c(layers_to_weigh, filtered_list[[2]])

  return(raster_weights)

}
