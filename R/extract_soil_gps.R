#' Extracts values for GPS df from soil velox raster
#'
#' @param velox_raster A list of velox raster from which to extract values
#' @param spdf A SpatialPointsDataFrame of the GPS for which we'll be extracting data from the velox raster.
#' @param soil_layers the names of the variables being extracted. These are applied to the extracted values.
#' @return A list of velox raster extracts with one point per lon/lat in the spdf
#' @examples
#' \dontrun{extract_soil_gps(raster_list, SpatialPointsDataFrame, c("ph", "n"))}

extract_soil_gps <- function(velox_raster, spdf, soil_layers){

  spdf <- match_soil_crs(spdf)

  extract_loop <- list()
  for(i in seq_along(velox_raster)){
    extract_loop[[i]] <- velox_raster[[i]]$extract_points(spdf)
    extract_loop[[i]] <- as.data.frame(extract_loop[[i]], row.names = NULL)
  }

  df <- do.call(cbind, extract_loop)
  names(df) <- soil_layers

  return(df)

}
