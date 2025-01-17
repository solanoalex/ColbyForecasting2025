read_model_input = function(scientificname = "Mola mola",
                            mon = "Jan",
                            approach = "greedy",
                            path = data_path("model_input")){
  #' Reads a model input file given species, month, approach and path
  #' 
  #' @param scientificname chr, the species name
  #' @param mon chr month abbreviation
  #' @param approach chr, one of "greedy" or "conservative"
  #' @param path chr the path to the data directory
  #' 
  #' @return 
  
  # your part goes in here
  filename = sprintf("%s-%s-%s_input.gpkg", 
                     gsub(" ", "_", scientificname),
                     mon)
  
  files = list.files(path, full.names = TRUE)
  
  x = read_sf(files[1])
  
  return(x[filename])
}