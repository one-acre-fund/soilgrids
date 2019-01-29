#' checks that country boundaries exist and if they don't downloads them.
#' @param country_polygon_directory the directory where the shape files live
#' @note This function is pretty simplistic. It can be simplified by condensing the repeated code. This funciton lets people update the shape files from the GADM website.
#' @return Clarification that all the countries exist as expected in the designated location
#' @export

get_country_polygons <- function(country_polygon_directory) {

  country_iso <- c("KEN", "RWA", "BDI", "TZA", "UGA", "ZMB", "MWI", "ETH", "IND", "NGA")
  country_files <- paste0("gadm36_", country_iso, "_2_sp.rds")

  available_files <- list.files(country_polygon_directory, pattern = "_adm2|gadm36")
  files_to_get <- country_files[!country_files %in% available_files]

  # add in check to see if files_to_get is not NULL. if NULL then return that the files already exist!
  if(length(files_to_get) == 0){
    return(print("\n We already have shape files for all countries!"))
  }

  countries_to_get <- gsub("gadm36_|_2_sp.rds", "", files_to_get)

  for(i in seq_along(countries_to_get)){
    raster::getData("GADM", country=countries_to_get[i], level=2, path = country_polygon_directory)
  }
}
