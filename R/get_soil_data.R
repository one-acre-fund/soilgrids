#' Executes the full soil extraction process
#'
#' @param spdf The set of GPS points for which the user wants an export
#' @param country_iso The country in which these points are located to trim down the data.
#' @param soil_layers The soil variables the user wants returned in the dataframe for those soil points. The soil layers need to be one of the following:
#' c(ph, carbon, soil_texture, sand, silt, clay, CEC, nitrogen) which are soil ph, carbon, soil texture, sand content, silt content, clay content, CEC, and soil nitrogen
#' @param raw_data_directory The location where the data are located to know where to get the raw tif. This defaults to the current working directory.
#' @param country_polygon_directory The file directory with the country polygon files. These are available for download with the get_country_polygon() function
#' @return The original spdf data frame along with the extracted soil layers.
#' @note This function assumes the data remain named what they are when they're down loaded from the soil grids website.
#' @export
#' @examples
#' import_soil_rasters("af_PHIHOX_T__M", "/Users/mlowes/Google Drive/analyses/soil_grids_raw_data/")

get_soil_data <- function(spdf, country_iso,
                          soil_layers = c("ph", "carbon", "soil_texture", "sand", "silt", "clay", "CEC"),
                          raw_data_directory,
                          country_polygon_directory){

  raw_rasters <- import_soil_rasters(layers_to_files(soil_layers), raw_data_directory)

  data_extract <- extract_soil_gps(convert_soil_to_velox(stack_and_sum_soil(
    apply_soil_weights(
      crop_raster_to_country(raw_rasters, spdf, country_iso, country_polygon_directory)))), spdf, layers_to_files(soil_layers)$param)

  df <- cbind(spdf@data, data_extract)

  return(df)

}
