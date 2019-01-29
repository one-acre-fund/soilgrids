#' Executes the full soil extraction process
#'
#' @param spdf The set of GPS points for which the user wants an export
#' @param country_iso The country in which these points are located to trim down the data.
#' @param soil_layers The soil variables the user wants returned in the dataframe for those soil points. The soil layers need to be one of the following:
#' c(ph, carbon, soil_texture, sand, silt, clay, CEC, nitrogen) which are soil ph, carbon, soil texture, sand content, silt content, clay content, CEC, and soil nitrogen
#' @param raw_data_directory The location where the data are located to know where to get the raw tif. This defaults to the current working directory.
#' @param country_polygon_directory The file directory with the country polygon files. These are available for download with the get_country_polygon() function
#' @inheritParams arc2weather::convert_to_spdf
#' @return The original spdf data frame along with the extracted soil layers.
#' @note This function assumes the data remain named what they are when they're down loaded from the soil grids website.
#' @export
#' @examples
#' get_soil_data(spdf = gps.data, country.iso = "KEN", raw_data_directory, country_polygon_directory)
#' country_iso = c("KEN", "RWA", "BDI", "TZA", "UGA", "ZMB", "MWI", "ETH", "IND", "NGA")
#'

get_soil_data <- function(df,
                          lonCol = NULL,
                          latCol = NULL,
                          country_iso,
                          soil_layers = c("ph", "carbon", "soil_texture", "sand", "silt", "clay", "CEC", "p", "n"),
                          raw_data_directory,
                          country_polygon_directory){

  raw_rasters <- import_soil_rasters(layers_to_files(soil_layers), raw_data_directory)

  # here is where I'll add in P and N based on their special needs. These will just be generally accessible through the standard import process once saved.
  # prepare_p_layer(raw_data_directory, forceUpdate = FALSE)
  # prepare_n_layer(raw_data_directory, forceUpdate = FALSE)

  soil_crs <- "+proj=laea +lat_0=5 +lon_0=20 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"

  spdf <- arc2weather::convert_to_spdf(df, lonCol = "Longitude", latCol = "Latitude", soil_crs)

  data_extract <- extract_soil_gps(
    convert_soil_to_velox(
      stack_and_sum_soil(
        apply_soil_weights(
          crop_raster_to_country(raw_rasters, spdf, country_iso, country_polygon_directory)))), spdf, layers_to_files(soil_layers)$param)

  df <- cbind(df@data, data_extract)

  return(df)

}
