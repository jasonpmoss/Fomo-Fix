#Author: Rafa

#Description: this function trains an UBCF model with the training dataset provided and saves the model to disk. Optional parameters are also allowed to setup the model
#INPUT: training dataset (mandatory). Nearest neightbors, distance method and normalization method (optional and with default values)
#OUTPUT: the function returns the trained model and it also save it to disk

UBCF_train<-function(training_data, nearest_neighbors =30 , distance = "cosine", normalize_ratings = "Center"){
  # Start the clock!
  #ptm <- proc.time()
  
  library(dplyr)
  library(recommenderlab)

  UBCF_recc_model <- Recommender(data = training_data, 
                                 method = "UBCF", 
                                 parameter = list(nn = nearest_neighbors, 
                                                  method = distance, 
                                                  normalize = normalize_ratings))
  
  # save the model to disk
  saveRDS(UBCF_recc_model, "./UBCF_model.rds")
  
  return (UBCF_recc_model)
  # Stop the clock
  #proc.time() - ptm
}
