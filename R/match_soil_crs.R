#' Given SPDF and country where the points are, put the SPDF and country outline
#' in the same CRS as the soil data which we know is fixed
#' @param obj_to_convert The spdf or polygon we need to convert
#' @return that same object but in the correct CRS
#' @examples
#' \dontrun{match_soil_crs(raster_object)}


match_soil_crs <- function(obj_to_convert){

  #assertthat::assert_that(is.projected(obj_to_convert))

  soil_crs <- "+proj=laea +lat_0=5 +lon_0=20 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"
  if(sp::proj4string(obj_to_convert) != soil_crs){
    converted <- sp::spTransform(obj_to_convert, sp::CRS(soil_crs))
    return(converted)
  }

  # else
  stop("\n Unable to align CRS of soil GPS or country boundaries to soil CRS")

}
