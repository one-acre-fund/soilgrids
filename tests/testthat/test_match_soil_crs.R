context("tests that input to match_crs is projected")

set.seed(1331)
pts <- cbind(1:5, 1:5)
dimnames(pts)[[1]] <- letters[1:5]
df <- data.frame(a = 1:5)
row.names(df) <- letters[5:1]

spdf <- SpatialPointsDataFrame(pts, df, match.ID = TRUE, proj4string = sp::CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))

test_that("match_soil_crs input is projected", {
  expect_error(match_soil_crs(data.frame(x = 1:10)))
})

# test_that("output has correct CRS", {
#   expect_equal(proj4string(match_soil_crs(spdf)), "+proj=laea +lat_0=5 +lon_0=20 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0")
# })
