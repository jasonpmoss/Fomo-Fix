#Author: Jason
IBCF_train<-function(ratings_matrix){
  # Start the clock!
  ptm <- proc.time()
  
  library(dplyr)
  library(recommenderlab)
  
  recc_model <- Recommender(data = recc_data_train, method = "IBCF", parameter = list(k = 30))
  
  # save the model to disk
  saveRDS(recc_model, "./IBCF_model.rds")
  
  # Stop the clock
  proc.time() - ptm
}
