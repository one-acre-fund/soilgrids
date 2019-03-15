#' Takes soil layers and converts to file names from soil grids website
#'
#' @param soil_layers a vector of the desired soil layers to check against df of file names
#' @return a vector of the file names to get from the data_directory
#' @note I'll need to use the same files_to_get df to assign variables names following the extract
#' @examples
#' \dontrun{layers_to_files(c("carbon", "CEC"))}


layers_to_files <- function(soil_layers){

  file_names <- data.frame(param = c("ph", "carbon", "soil_texture", "sand", "silt", "clay", "CEC", "p", "n"),
                           file_name = c("af_PHIHOX_T__M", "af_ORCDRC_T__M", "af_TEXMHT_T__M", "af_SNDPPT_T__M", "af_SLTPPT_T__M", "af_CLYPPT_T__M", "af_CEC_T__M", "phosphorous_layer_projected", "nitrogen_layer_projected"))

  files_to_get <- as.data.frame(file_names[file_names$param %in% soil_layers, ])
  files_to_get$param <- as.character(files_to_get$param)
  files_to_get$file_name <- as.character(files_to_get$file_name)

  return(files_to_get)
}

