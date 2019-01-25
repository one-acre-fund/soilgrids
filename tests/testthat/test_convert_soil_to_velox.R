context("converting soil to velox type")

library(raster)
rf <- list(raster(matrix(rnorm(400),20,20)), raster(matrix(rnorm(400),20,20)), raster(matrix(rnorm(400),20,20)),
           raster(matrix(rnorm(400),20,20)), raster(matrix(rnorm(400),20,20)), raster(matrix(rnorm(400),20,20)))

test_that("input is a list", {
  expect_error(convert_soil_to_velox(data.frame(x = 1:10)))
})

test_that("input is a list of raster", {
  expect_error(convert_soil_to_velox(list(data.frame(x = 1:10), data.frame(x = 1:10))))
  expect_error(convert_soil_to_velox(list(list(data.frame(x = 1:10), data.frame(x = 1:10)))))
})

test_that("output is a list object", {
  expect_equal(class(convert_soil_to_velox(rf)), "list")
})
