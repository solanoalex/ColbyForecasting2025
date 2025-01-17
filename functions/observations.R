
read_observations = function(scientificname = "Mola mola",
                             minimum_year = 1970,
                             individual_na = TRUE,
                             ...){
  
  #' Read raw OBIS data and then filter it
  #' 
  #' @param scientificname chr, the name of the species to read
  #' @param minimum_year num, the earliest year of observation to accept or 
  #'   set to NULL to skip
  #' @param individual_na bool, filter out NA counts if True
  #' @param ... other arguments passed to `read_obis()`
  #' @return a filtered table of observations
  
  # Happy coding!
  
  # read in the raw data
  x = read_obis(scientificname, ...)
  
  # if the user provided a non-NULL filter by year
  if (!is.null(minimum_year)){
    x = x |>
      filter(year >= minimum_year)
  }
  
  # if the user provided True for filter individual count
  # this doesnt work
  if (individual_na == TRUE){
    x = x |>
      filter(!is.na(individualCount))
  }
  
  # by default, we filter out NA from eventDate
  x = x |>
      filter(!is.na(eventDate))
  
  # by default, we filter out points outside the area
  db = brickman_database() |>
    filter(scenario == "STATIC", var == "mask")
  
  mask = read_brickman(db, add_depth = FALSE)
  
  hitOrMiss = extract_brickman(mask, x)
  
  x = x |>
    filter(!is.na(hitOrMiss$value))
  
  return(x)
}
