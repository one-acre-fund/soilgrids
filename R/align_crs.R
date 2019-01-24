#' Make sure the velox raster and the GPS spdf have the same CRS
#'
#' @param veloxRasterList A list of raster in velox format.
#' @param spdf A SpatialPointsDataFrame from the sp package.
#' @return An spdf with the same format as the velox raster data.
#' @examples
#' add(1, 1)
#' add(10, 1)
#' notes: This should only be run once for the entire operation and thus it should be done before entering the extraction phase.

align_crs <- function(veloxRasterList, spdf){

  if(class(veloxRasterList[[1]]) != "VeloxRaster"){
    stop("\n veloxRaster object needs to be a velox object. First convert to Velox")
  }

  if(class(spdf) != "SpatialPointsDataFrame"){
    stop("\n spdf object not a SpatialPointsDataFrame. First convert to SPDF using sp package")
  }

  # check if the CRS are already the same. If not convert the SPDF to the velox raster format and report what the format is. This assumes that the veloxRaster all have the CRS which they should because the ARC 2 weather data should. Maybe this is a bad assumption though!

  # first check that velox raster list are all the same CRS
  veloxCrs <- lapply(veloxRasterList, function(x){x$crs})
  veloxCrsCheck <- length(unique(veloxCrs)) == 1

  if(!veloxCrsCheck){
    stop("\n VeloxRaster object has different CRS in different layers. Check this before proceeding")
  }


  crsFormatCheck <- veloxRasterList[[1]]$crs == sp::proj4string(spdf)
  if(!crsFormatCheck){
    spdf <- sp::spTransform(spdf, sp::CRS(veloxRasterList[[1]]$crs))
    return(spdf)
  }
}
