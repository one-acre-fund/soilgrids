#' checks that country boundaries exist and if they don't downloads them.
#' @param country_polygon_directory the directory where the shape files live
#' @note This function is pretty simplistic. It can be simplified by condensing the repeated code.
#' @return Clarification that all the countries exist as expected in the designated location
#' @notes This funciton lets people update the shape files from the GADM website.
#' @export

get_country_polygons <- function(country_polygon_directory) {

  country_iso <- c("KEN", "RWA", "BDI", "TZA", "UGA", "ZMB", "MWI", "ETH", "IND", "NGA")
  country_files <- paste0("GADM_2.8_", country_iso, "_adm2.rds")

  available_files <- list.files(country_polygon_directory, pattern = "_adm2")
  files_to_get <- country_files[!country_files %in% available_files]

  countries_to_get <- gsub("GADM_2.8_|_adm2.rds", "", files_to_get)

  for(i in seq_along(countries_to_get)){
    raster::getData("GADM", country=i, level=2, path = country_polygon_directory)
  }
}
