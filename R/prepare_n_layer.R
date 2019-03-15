#' Prepares the N data in particular and performs raster repojection to match
#' the core set.
#'
#' @param raw_data_directory the location of the file. This should be the in the
#'   same place as the other raw data.
#' @param forceUpdate boolean to determine if we have to refresh the whole procedure or just
#' load the previous version.
#' @return a vector of the file names to get from the data_directory
#' @note I'll do this once for P and for N so that we don't have to reproject
#'   the data each time. This will be done in the background once and saved and
#'   the data will just be available normally through the functions.
#'
#'   There's no input for the function because it executes a standard data
#'   transformation.
#' @examples
#' \dontrun{layers_to_files(c("carbon", "CEC"))}


prepare_n_layer <- function(raw_data_directory, forceUpdate){

  if(forceUpdate){
    raw_layers <- raster::raster(paste0(raw_data_directory, "/af250m_nutrient_n_m_agg30cm.tif"))

    standard_projection <- "+proj=laea +lat_0=5 +lon_0=20 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"

    project_layers <- raster::projectRaster(raw_layers, res = c(250, 250), crs = standard_projection)

    raster::writeRaster(project_layers, file = paste(raw_data_directory, "nitrogen_layer_projected.tif", sep = "/"), format="GTiff", overwrite=TRUE)
  }
}

