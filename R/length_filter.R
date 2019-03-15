#' Breaks list based on subsets with 3 layers and those with one to handle exceptions in the weights and sum portions.
#' @param raster_list a list of raster data
#' @return A list with two elements, the first is the set to be weighted or summed, the second is to be combined with the results of the first.
#' @examples
#' \dontrun{length_filter(list_of_rasters)}


length_filter <- function(raster_list){

  elements_with_three <- lapply(raster_list, function(layer) length(layer) == 3)

  layers_to_weigh <- raster_list[unlist(elements_with_three) == TRUE]
  layers_to_skip <- raster_list[unlist(elements_with_three) == FALSE]

  return(list(layers_to_weigh, layers_to_skip))

}
