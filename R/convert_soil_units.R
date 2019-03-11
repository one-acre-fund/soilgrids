#' Creates full raster layers for each soil component, applying weights to each
#' @param soil_df a list of raster data for each soil property to which to apply the weights
#' @return the output data set that converts the raw units to more user friendly interpretations
#' @note This function will live within the master function call to share the output directly.
#' @examples
#' get_soil_data(...)


convert_soil_units <- function(soil_df, variable){

  variable = rlang::enquo(variable)

  return(soil_df %>%
           dplyr::mutate(!!variable = !!variable / 10))

}
