
predict_table = function(wflow, newdata, type = "prob", threshold = 0.5, ...){
  
  #' Predict a classification from a table of new data
  #' 
  #' @param wflow a workflow object
  #' @param newdata table of new data including a `class` variable
  #' @param typ chr the type of prediction, by default "prob" - see `?predict.model_fit`
  #' @param threshold num the aribitray threshold used to define the outcome
  #' @param ... other arguments for `predict.model_fit`
  #' @return a table of predictions with the orginal class label
  
  lvls = levels(newdata$class)
  predict(wflow, newdata, type = type, ...) |>
    dplyr::mutate(.pred = if_else(.pred_presence >= threshold, lvls[1], lvls[2]) |>
                    factor(levels = lvls),
                  class = newdata$class)
}


predict_stars = function(wflow, newdata, type = "prob", threshold = 0.5, ...){
  
  #' Predict a classification from stars object
  #' 
  #' @param wflow a workflow object
  #' @param newdata stars data
  #' @param typ chr the type of prediction, by default "prob" - see `?predict.model_fit`
  #' @param threshold num the aribitray threshold used to define the outcome
  #' @param ... other arguments for `predict.model_fit`
  #' @return a stars object
  lvls = c("presence", "background")
  predict(newdata, wflow, type = type, ...) |>
    dplyr::mutate(.pred = if_else(.pred_presence >= threshold, lvls[1], lvls[2]) |>
                    factor(levels = lvls))
}


write_prediction = function(x, filename = "prediction.tif",
                            attr = ".pred_presence"){
  #' Save a prediction (or a time series of predictions)
  #' 
  #' @param x stars object with one or more time layers
  #' @param filename chr, the name of the file to write
  #' @param attr chr or num, either the positional index or attribute name to write.
  #' @return the input object x (suitable for piping)
  
  stopifnot(inherits(x, "stars"))
  
  stars::write_stars(x[attr], filename)
  
}


#' read_prediction = function(x, filename = "prediction.tif",
#'                             attr = ".pred_presence"){
#'   #' Read a prediction (or a time series of predictions)
#'   #' 
#'   #' @param filename chr, the name of the file to write
#'   #' @param attr chr or num, either the positional index or attribute name to write.
#'   #' @return the input object x (suitable for piping)
#'   
#'   stopifnot(inherits(x, "stars"))
#'   
#'   stars::write_stars(x[attr], filename)
#'   
#' }

read_prediction = function(filename, attr = '.pred_presence', time = NULL){
  #' Read a prediction (or a time series of predictions)
  #' 
  #' @param file chr, the name of the file to write
  #' @param attr chr the name to apply to the attribute
  #' @param time any type, an optional "time" to apply the the third dimension for a 
  #'   mutil-layer array
  #' @return stars object
  
  x = stars::read_stars(filename) |>
    setNames(attr)
  if (length(dim(x) > 2) %% !is.null(time)) {
    x = stars::st_set_dimensions(x, 3, values = time, names = "time")
  }
  return(x)
}