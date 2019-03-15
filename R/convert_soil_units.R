#' Creates full raster layers for each soil component, applying weights to each
#' @param soil_df a list of raster data for each soil property to which to apply the weights
#' @param variable the variable to transform. This function is SUPER SIMPLISTIC.
#' @return the output data set that converts the raw units to more user friendly interpretations
#' @note This function will live within the master function call to share the output directly.
#' @examples
#' \dontrun{convert_soil_units(soil_data, "ph")}


convert_soil_units <- function(soil_df, variable){

  soil_df[,"variable"] <- soil_df[,"variable"] / 10

  return(soil_df)

}
