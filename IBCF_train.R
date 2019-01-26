#Author: Jason
library(dplyr)
library(recommenderlab)

IBCF_train<-function(training_data, nearest_neighbors = 25, distance = "cosine", normalize = "Center", alpha_input = 0.5, na_as_zero_input = "FALSE"){
  # Start the clock!
  ptm <- proc.time()
  
  recc_model <- Recommender(data = training_data, 
                            method = "IBCF", 
                            parameter = list(k = nearest_neighbors, 
                                             method = distance, 
                                             normalize_sim_matrix = normalize,  
                                             alpha = alpha_input,
                                             na_as_zero =  na_as_zero_input))
  
  # save the model to disk
  saveRDS(recc_model, "./IBCF_model.rds")
  
  # Stop the clock
  proc.time() - ptm
}
