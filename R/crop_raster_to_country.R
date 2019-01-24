#' Take the velox raster and crop the velox objects down to the area where the
#' SPDF points are
#' @param raster_list The original list of raster before converting to velox.
#' @param country_iso The country iso code to indicate which country the GPS
#'   points are in to know how to trim the data
#' @inheritParams match_soil_crs this ensures that the spdf and country polygons
#'   match the soil data
#' @return  raster cropped to the area where soil points are so that we don't care the raw soil rasters through the extract process.
#' @note I've included an if statement in the event there's only one requested soil parameter. There must be a cleaner way to do this.
#' @examples
#' apply_soil_weights("ph_soil_layer.tif")


crop_raster_to_country <- function(raster_list, spdf, country_iso, data_directory){

  country_map <- intersect_map_and_points(spdf, country_iso, data_directory)

  if(length(raster_list) == 1){
    raster_crop <- lapply(raster_list, function(x){crop(x, extent(country_map))})
    raster_mask <- lapply(raster_crop, function(x){mask(x, country_map)})
  } else {
    raster_crop <- lapply(raster_list, function(grouped_layer){
      lapply(grouped_layer, function(data_layer){
        crop(data_layer, extent(country_map))})
      })

    raster_mask <- lapply(raster_crop, function(grouped_layer){
      lapply(grouped_layer, function(data_layer){
        mask(data_layer, country_map)})
      })
  }

  return(raster_mask)
}
