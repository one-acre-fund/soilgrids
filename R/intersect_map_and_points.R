#' Create intersected map to use to crop velox rasters.
#' @param country_iso The country iso code to indicate which country the GPS points are in to know how to trim the data
#' @param spdf SpatialPointsDataFrame to intersect with the polygons
#' @param data_directory the location of the polygon files
#' @inheritParams crop_raster_to_country
#' @return velox raster cropped to the area where soil points are
#' @examples
#' \dontrun{apply_soil_weights("ph_soil_layer.tif")}


intersect_map_and_points <- function(spdf, country_iso, data_directory){

  spdf <- match_soil_crs(spdf)
  boundaries_raw <- readRDS(paste0(data_directory, "/gadm36_", country_iso, "_2_sp.rds"))

  boundaries <- match_soil_crs(boundaries_raw)

  country_map <- raster::intersect(boundaries, spdf)

  return(country_map)

}
