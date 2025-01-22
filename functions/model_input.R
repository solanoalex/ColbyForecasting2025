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
                     gsub(" ", "_", scientificname, fixed = TRUE),
                     mon, approach)
  
  fname = file.path(path[1], filename[1])
  
  if(!file.exists(fname)){
    message("file not found:", filename)
    return(NULL)
  }
  
  x = read_sf(fname)
    
  return(x)
}