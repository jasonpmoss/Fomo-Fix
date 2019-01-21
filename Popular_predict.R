#Author: Jason

library(dplyr)
library(recommenderlab)

Popular_train<-function(ratings_matrix){
  # Start the clock!
  ptm <- proc.time()
  
  rec=Recommender(ratings_matrix[1:nrow(ratings_matrix)],method="POPULAR")
  # save the model to disk
  saveRDS(rec, "./Popular_model.rds")
  recom <- predict(rec, ratings_matrix, n=3)
  return(as(recom, "list"))
  # Stop the clock
  proc.time() - ptm
}

#----------------------------------------testing the function-----------------------------------------------#

#pop_predict<-Popular_train(ratings_mat)
#pop_predict
