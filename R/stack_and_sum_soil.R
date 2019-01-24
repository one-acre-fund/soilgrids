#' Prepares soil layer for inclusion in soil stack for GPS extraction
#' @param raster_list a list of velox rasters with weights applied to be stacked
#'   and summed.
#' @return a single raster layer that sums the soil values including the weights
#'   for the velox extraction stage
#' @examples
#' prep_soil_layer()


prepare_soil_layer <- function(raster_list){

  combined_layers <- lapply(raster_list, function(soil_layer){
    return(sum(stack(apply_soil_weights(raster_list))))
  })

  return(combined_layers)

}
