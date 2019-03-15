#' Take the velox raster and crop the velox objects down to the area where the SPDF points are
#' @param raster_list The original list of raster before converting to velox.
#' @param spdf SpatialPointsDataFrame to determine extent of interest.
#' @param country_iso The country iso code to indicate which country the GPS points are in to know how to trim the data
#' @param data_directory The data directory where the polygons are saved.
#' @return  raster cropped to the area where soil points are so that we don't care the raw soil rasters through the extract process.
#' @note I've included an if statement in the event there's only one requested soil parameter. There must be a cleaner way to do this.
#' @examples
#' \dontrun{crop_raster_to_country("ph_soil_raster.tif", "KEN", "/path/to/directory")}


crop_raster_to_country <- function(raster_list, spdf, country_iso, data_directory){

  country_map <- intersect_map_and_points(spdf, country_iso, data_directory)

  if(length(raster_list) == 1){
    raster_crop <- lapply(raster_list, function(x){raster::crop(x, raster::extent(country_map))})
    raster_mask <- lapply(raster_crop, function(x){raster::mask(x, country_map)})
  } else {
    raster_crop <- lapply(raster_list, function(soil_set){
      lapply(soil_set, function(data_layer){
        raster::crop(data_layer, raster::extent(country_map))})
      })

    raster_mask <- lapply(raster_crop, function(soil_set){
      lapply(soil_set, function(data_layer){
        raster::mask(data_layer, country_map)})
      })
  }

  return(raster_mask)
}
