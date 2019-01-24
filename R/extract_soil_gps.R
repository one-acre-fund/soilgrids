#' Extracts values for GPS df from soil velox raster
#'
#' @param veloxRaster A list of velox raster from which to extract values
#' @param spdf A SpatialPointsDataFrame of the GPS for which we'll be extracting data from the velox raster.
#' @inheritParams convert_to_velox
#' @return A list of velox raster extracts with one point per lon/lat in the spdf
#' @export

extract_soil_gps <- function(veloxRaster, spdf){

  spdf <- match_soil_crs(spdf)

  ## here is where we extract the values for the given GPS values.
  extractLoop <- list()
  for(i in seq_along(veloxRaster)){
    extractLoop[[i]] <- veloxRaster[[i]]$extract_points(spdf)
    extractLoop[[i]] <- as.data.frame(extractLoop[[i]], row.names = NULL)
  }

  # map the metaDf to the list so that I know the values of each extracted value. Keep this long?
  # extract loop has # of elements equal to the dates and each element is the length of the GPS points. I therefore want to combine dates with each element.
  # convert spdf@data into equal length list for easy mapping
  spdfList <- rep(list(spdf@data), length(extractLoop)) # rep spdfList so there's one copy for each extraction layer.

  # combine gps points with extracted values
  dataList <- Map(cbind, spdfList, extractLoop)

  #names(dataList)[names(fullDf) == "V1"] <- 'rainfall' #<< how to know what to name this by feature...

  # return the combined meta data and the extracted values
  return(dataList)

}
