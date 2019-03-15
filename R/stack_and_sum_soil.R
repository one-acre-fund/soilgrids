#' Takes weighted soil layers, creates stack, and sums values to create single soil raster for that parameter
#' @param raster_list a list of weighted soil rasters
#' @return a single raster layer that sums the soil values including the weights
#'   for the velox extraction stage
#' @examples
#' \dontrun{stack_and_sum_soil()}
#' @note This is a pretty simple function but I wanted to keep this separate from the other preparation stages.


stack_and_sum_soil <- function(raster_list){

  filtered_list <- length_filter(raster_list)

  soil_stack <- lapply(filtered_list[[1]], function(data_layer){
    return(sum(raster::stack(data_layer)))
  })

  soil_list <- c(soil_stack, unlist(filtered_list[[2]]))

  return(soil_list)

}
