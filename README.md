# Soil grids data access package

[![Build Status](https://travis-ci.org/one-acre-fund/soilgrids.svg?branch=master)](https://travis-ci.org/one-acre-fund/soilgrids)

This package makes working with data from the [ISRIC Soil Grids](https://soilgrids.org/#!/?layer=ORCDRC_M_sl2_250m&vector=1) data set easier. One Acre Fund collects soil data for analysis in our own lab however we lack the coverage to describe soils in our program area broadly or in new places where we don't yet work.

This package simplifies extracting soil values for given GPS points from soil raster layers from Soil Grids.

# How to install

To install this package, please do the following:

1. You'll need to create a personal access token (PAT) on github to download the package from github.
  + Go to the [tokens](https://github.com/settings/tokens) page on github to create a token. Be sure to select the `repo` scope so that it works!
  + Then, you'll need to edit the `.Renviron` file on your computer to make that PAT available to R when it tries to download the package.
  + To do this, type `usethis::edit_r_environ()` in R to edit the `.Renviron` file.
  + In the `.Renviron` file type `GITHUB_PAT = "longstringoflettersandnumbersyougetfromgithub"`. (What goes in the quotes is the PAT you got from GitHub). Then save and close that file. You might have to restart R for the changes to take effect.
2. Open R script and download the package using `devtools::install_github(one-acre-fund/arc2weather)`. (You can check that the GITHUB_PAT is working as it should by first typing `Sys.getenv("GITHUB_PAT")` in the R console.)
3. The package should now be available for your use!


# How to use

The primary function will be `get_soil_data()` which takes four inputs:

* `df` - a data.frame or SpatialPointsDataFrame that includes the GPS points of interest. If you supply a data.frame, you'll also need to indicate which columns in the data.frame have the lat/lon information. Currently the system assumes that the default projection for the data is `+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0` or `ESPG::4326`.
* `lat_col` and `lon_col` - if you provide a data.frame, you need to indicate which variables in the data have the latitude and longitude information.
* `country_iso` - the country ISO code for the country in which the points are located. This allows the package to trim down the data and simplify the amount of data we're working with. Right now you can only access points from one country at a time but future releases will expand on this if you wanted to access data across multiple countries at once.
* `raw_data_directory` - the file location on your local computer of the raw soil data downloaded from Soil Grids. This component is engineered for 1AF's current set up and will likely be a point of improvement in future versions.
* `country_polygon_directory` - the file location with the country polygons. These polygons are used to crop the soil data so that we're passing smaller datasets behind the scenes before extracting the data for the GPS points.

Finally, the package currently assumes you have all the right data downloaded locally. This works for 1AF since we can share Google Drive folders with the [raw data](https://drive.google.com/drive/folders/1piqHGLXffirXQAa4oSFTUcjieQY8tud8?usp=sharing) and the [country polygons](https://drive.google.com/drive/folders/1bXO74V5c4URUqtkPVeyABywjpfmFW2Mx?usp=sharing).

Here's an example call of the main function to extract data for Kenya GPS points:

~~~~
library(soilgrids)
# where siteSp is a SpatialPointsDataFrame of GPS and associated location information.
soil_data <- get_soil_data(df = siteSp, 
                          country_iso = "KEN", 
                          soil_layers = c("ph", "carbon"), 
                          raw_data_directory = "/Users/mlowes/Google Drive/analyses/soil_grids_raw_data/", 
                          country_polygon_directory = "/Users/mlowes/Google Drive/analyses/soil_grids_data/")

# where the data provided is a data.frame. 

get_soil_data(df = zam_data,
              lat_col = "Latitude",
              lon_col = "Longitude",
              country_iso = "ZMB",
              raw_data_directory = "/Users/mlowes/Google Drive/analyses/soil_grids_raw_data/",
              country_polygon_directory = "/Users/mlowes/Google Drive/analyses/soil_grids_data/")

~~~~

# Notes on units

The SoilGrids units are:

* pH - these values are originally come in pH x 10. I've convereted them to the standard scale by dividing by 10.
* Carbon (SOC) - g/kg. Work with Step to resolve how to convert this to %C.
* Nitrogen - mg/kg
* Phosphorous - mg/kg
* CEC - cmolc/kg
* sand, silt, clay - w% (percent of weight)

# Future additions

* Access data across multiple countries at once rather than country by country
* Access summaries for spatial polygons, not just spatial points
* Potentially use the SoilGrids REST API (more 'up to date' but requires regular downloading of data in data warehouse)
* I removed the option to select soil parameters. I might add this back in if there are use cases outside of the data warehouse where fewer columns is critical.
