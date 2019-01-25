library(dplyr)
library(recommenderlab)

Popular_train<-function(ratings_matrix){
  # Start the clock!
  ptm <- proc.time()
  
  rec=Recommender(ratings_matrix[1:nrow(ratings_matrix)],method="POPULAR")
  # save the model to disk
  saveRDS(rec, "./Popular_model.rds")
  # Stop the clock
  proc.time() - ptm
}