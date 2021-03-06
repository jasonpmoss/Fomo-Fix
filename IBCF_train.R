#Author: Jason
library(dplyr)
library(recommenderlab)

IBCF_train<-function(training_data, 
                     nearest_neighbors = 25, 
                     distance = "cosine", 
                     normalize_value= "center", 
                     normalize_sim_matrix_value = "FALSE",
                     alpha_input = 0.5, 
                     na_as_zero_input = "FALSE"){
  # Start the clock!
  ptm <- proc.time()
  
  recc_model <- Recommender(data = training_data, 
                            method = "IBCF", 
                            parameter = list(k = nearest_neighbors, 
                                             method = distance,
                                             normalize = normalize_value,
                                             normalize_sim_matrix = normalize_sim_matrix_value,  
                                             alpha = alpha_input,
                                             na_as_zero =  na_as_zero_input))
  
  # save the model to disk
  saveRDS(recc_model, "./IBCF_model.rds")
  
  # Stop the clock
  proc.time() - ptm
}
