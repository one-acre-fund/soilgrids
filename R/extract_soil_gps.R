#' Extracts values for GPS df from soil velox raster
#'
#' @param veloxRaster A list of velox raster from which to extract values
#' @param spdf A SpatialPointsDataFrame of the GPS for which we'll be extracting data from the velox raster.
#' @inheritParams convert_to_velox
#' @return A list of velox raster extracts with one point per lon/lat in the spdf
#' @export

extract_soil_gps <- function(veloxRaster, spdf){

  #align_crs(veloxRaster, spdf)

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

  #combine date labels with the gps points and extracted values so the data can be aggregated as desired based on dates
  prepDates <- split(veloxRaster[[2]], veloxRaster[[2]]$date)

  fullDfList <- mapply(function(x, y) cbind(x, y, row.names = NULL),
                       prepDates, dataList, SIMPLIFY = FALSE)

  fullDf <- plyr::rbind.fill(fullDfList)
  names(fullDf)[names(fullDf) == "V1"] <- 'rainfall'

  # return the combined meta data and the extracted values
  return(fullDf)

}
