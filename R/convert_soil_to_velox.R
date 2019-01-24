#' Converts soil raster to velox
#'
#' @param soil_raster a raster of soil data from the soil grids repository to be converted to raster for extraction
#' @return a velox raster version of the soil data for extraction
#' @examples
#' convert_soil_to_velox("ph_soil_layer.tif")

convert_soil_to_velox <- function(raster_list){

  #raster_list <- list(raster_list)
  veloxLoop <- list()
  for(i in seq_along(raster_list)){
    tmp <- velox::velox(raster_list[[i]])
    #tmp$crop(oafAreaReproject)
    veloxLoop[[i]] <- tmp
  }

  return(veloxLoop)

}
