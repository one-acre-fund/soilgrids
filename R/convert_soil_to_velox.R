#' Converts soil raster to velox
#'
#' @param raster_list a raster of soil data from the soil grids repository to be converted to raster for extraction
#' @return a velox raster version of the soil data for extraction
#' @examples
#' \dontrun{convert_soil_to_velox(list("ph_soil_layer.tif", "n_soil_layer.tif"))}

convert_soil_to_velox <- function(raster_list){

  assertthat::assert_that(is.list(raster_list))
  assertthat::assert_that(class(raster_list[[1]]) == "RasterLayer")

  veloxLoop <- list()
  for(i in seq_along(raster_list)){
    tmp <- velox::velox(raster_list[[i]])
    #tmp$crop(oafAreaReproject)
    veloxLoop[[i]] <- tmp
  }

  assertthat::assert_that(all(lapply(veloxLoop, class) == "VeloxRaster"))

  return(veloxLoop)

}
