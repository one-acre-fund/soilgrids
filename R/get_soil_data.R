#' Executes the full soil extraction process
#'
#' @param spdf The set of GPS points for which the user wants an export
#' @param country_iso The country in which these points are located to trim down the data.
#' @param soil_layers The soil variables the user wants returned in the dataframe for those soil points. The soil layers need to be one of the following:
#' c(ph, carbon, soil_texture, sand, silt, clay, CEC, nitrogen) which are soil ph, carbon, soil texture, sand content, silt content, clay content, CEC, and soil nitrogen
#' @param data_directory The location where the data are located to know where to get the raw tif. This defaults to the current working directory.
#' @return The original spdf data frame along with the extracted soil layers.
#' @note This function assumes the data remain named what they are when they're down loaded from the soil grids website.
#' @examples
#' import_soil_rasters("af_PHIHOX_T__M", "/Users/mlowes/Google Drive/analyses/soil_grids_raw_data/")

get_soil_data <- function(spdf, country_iso,
                          soil_layers = c("ph", "carbon", "soil_texture", "sand", "silt", "clay", "CEC"),
                          data_directory){

  file_names <- data.frame(param = c("ph", "carbon", "soil_texture", "sand", "silt", "clay", "CEC"),
                          file_name = c("af_PHIHOX_T__M", "af_ORCDRC_T__M", "af_TEXMHT_T__M", "af_SNDPPT_T__M", "af_SLTPPT_T__M", "af_CLYPPT_T__M", "af_CEC_T__M"))

  files_to_get <- as.vector(file_names$file_name[file_names$param %in% soil_layers])






}
