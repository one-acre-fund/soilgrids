#' Take the velox raster and crop the velox objects down to the area where the
#' SPDF points are
#' @param veloxRaster The list of velox rasters to be cropped
#' @param country_iso The country iso code to indicate which country the GPS
#'   points are in to know how to trim the data
#' @inheritParams match_soil_crs this ensures that the spdf and country polygons
#'   match the soil data
#' @return velox raster cropped to the area where soil points are
#' @examples
#' apply_soil_weights("ph_soil_layer.tif")


crop_velox_to_country <- function(veloxRaster, spdf, country_iso){




}
