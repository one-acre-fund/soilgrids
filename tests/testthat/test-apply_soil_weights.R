context("testing soil weight application")
library(raster)
library(sp)

rl <- list(list(raster(matrix(rnorm(400),20,20)), raster(matrix(rnorm(400),20,20))))
rf <- list(list(raster(matrix(rnorm(400),20,20)), raster(matrix(rnorm(400),20,20)), raster(matrix(rnorm(400),20,20))),
           list(raster(matrix(rnorm(400),20,20)), raster(matrix(rnorm(400),20,20)), raster(matrix(rnorm(400),20,20))))

# test_that("raster list length matches weight list length", {
#   expect_equal(apply_soil_weights(rl))
# })

test_that("weight list adds to 1", {
  expect_error(apply_soi_weights(rf, weight_list = c(1/3, 2/3, 1/3)))
})

#this should be working...
test_that("output is list of rasters", {
  expect_is(apply_soil_weights(rf), "list")
})
