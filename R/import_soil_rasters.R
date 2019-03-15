#' imports appropriate rasters to create soil layers
#'
#' @param file_name The unique part of the file name to capture the right rasters for that soil
#' @param dir_name The directory where the soil raster tif files are stored
#' @return a list of rasters for each soil component
#' @examples
#' \dontrun{import_soil_rasters("af_PHIHOX_T__M",
#' "/Users/mlowes/Google Drive/analyses/soil_grids_raw_data/")}

import_soil_rasters <- function(file_name, dir_name){

  raw_rastesrs <- lapply(file_name$file_name, function(f){

    tif_files <- paste0(dir_name, "/", list.files(dir_name, pattern = ".tif$"))

    tif_subset <- tif_files[grep(f, tif_files)]

    raster_list = lapply(tif_subset, function(soil_layer) raster::raster(soil_layer))

    return(raster_list)

  })

}
