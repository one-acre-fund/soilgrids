#' Takes weighted soil layers, creates stack, and sums values to create single soil raster for that parameter
#' @param raster_list a list of weighted soil rasters
#' @return a single raster layer that sums the soil values including the weights
#'   for the velox extraction stage
#' @examples
#' stack_and_sum_soil()
#' @note This is a pretty simple function but I wanted to keep this separate from the other preparation stages.


stack_and_sum_soil <- function(raster_list){

  return(sum(stack(raster_list)))

}