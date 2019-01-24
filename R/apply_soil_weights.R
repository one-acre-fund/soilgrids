#' Creates full raster layers for each soil component, applying weights to each
#' @param raster_list a list of raster data for each soil property to which to apply the weights
#' @param weight_list the list of weights to apply to those soil layers. Defaults specified and shouldn't need to be altered.
#' @return a single raster for each soil component with appropriate weights applied
#' @examples
#' apply_soil_weights("ph_soil_layer.tif")


apply_soil_weights <- function(raster_list, weight_list = list(5/30, 10/30, 15/30)){

  weight_sum <- do.call(sum, weight_list)
  if(weight_sum != 1){
    stop("\n Weights don't add up to 1. Check weights.")
  }

  raster_weights = Map("*", raster_list, weight_list)
  return(raster_weights)

}
