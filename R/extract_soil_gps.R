#' Extracts values for GPS df from soil velox raster
#'
#' @param veloxRaster A list of velox raster from which to extract values
#' @param spdf A SpatialPointsDataFrame of the GPS for which we'll be extracting data from the velox raster.
#' @inheritParams convert_to_velox
#' @inheritParams get_soil_data Takes the soil_layer input to assign names to the output data.
#' @return A list of velox raster extracts with one point per lon/lat in the spdf
#' @export

extract_soil_gps <- function(velox_raster, spdf, soil_layers){

  spdf <- match_soil_crs(spdf)

  extract_loop <- list()
  for(i in seq_along(velox_raster)){
    extract_loop[[i]] <- velox_raster[[i]]$extract_points(spdf)
    extract_loop[[i]] <- as.data.frame(extract_loop[[i]], row.names = NULL)
  }

  df <- do.call(cbind, extract_loop)
  names(df) <- soil_layers

  return(dataList)

}
