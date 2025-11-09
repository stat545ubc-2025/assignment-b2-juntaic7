test_that("Function returns correct structure", {
  result <- count_all_missing_by_group(airquality, Month)

  # Check the return type
  expect_s3_class(result, "data.frame")

  # Check number of rows matches number of groups
  expect_equal(nrow(result), length(unique(airquality$Month)))

  # Check grouping column is included
  expect_true("Month" %in% names(result))
})

test_that("Function counts NAs correctly", {
  test_data <- data.frame(
    group = c("A", "A", "B", "B"),
    x = c(1, NA, 3, 4),
    y = c(NA, NA, 3, NA)
  )

  result <- count_all_missing_by_group(test_data, group)

  # Check group A: 1 NA in x and 2 NAs in y
  expect_equal(result$x[result$group == "A"], 1)
  expect_equal(result$y[result$group == "A"], 2)

  # Check group B: 0 NA in x and 1 NA in y
  expect_equal(result$x[result$group == "B"], 0)
  expect_equal(result$y[result$group == "B"], 1)
})

test_that("Function handles .groups argument correctly", {
  result_drop <- count_all_missing_by_group(airquality, Month, .groups = "drop")
  result_keep <- count_all_missing_by_group(airquality, Month, .groups = "keep")

  # Check ungrouped result with drop
  expect_false(dplyr::is_grouped_df(result_drop))

  # Check grouped result with keep
  expect_true(dplyr::is_grouped_df(result_keep))
})

test_that("Function throws error for invalid .groups argument", {
  expect_error(
    count_all_missing_by_group(airquality, Month, .groups = "invalid"),
    ".groups needs to be one of"
  )
})

test_that("Function works with different data types", {
  # Test tibble
  test_tibble <- dplyr::tibble(
    group = c(1, 1, 2, 2),
    value = c(1, NA, 3, 4)
  )

  result <- count_all_missing_by_group(test_tibble, group)
  expect_s3_class(result, "data.frame")

  # Test regular dataframe
  result2 <- count_all_missing_by_group(airquality, Month)
  expect_s3_class(result2, "data.frame")
})

test_that("Function works with pipe operator", {
  result_pipe <- airquality |> count_all_missing_by_group(Month)
  result_direct <- count_all_missing_by_group(airquality, Month)

  expect_equal(result_pipe, result_direct)
})
