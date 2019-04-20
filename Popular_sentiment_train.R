library(dplyr)
library(recommenderlab)

Popular_sentiment_train<-function(ratings_matrix, norm = "center"){
  # Start the clock!
  ptm <- proc.time()
  
  rec=Recommender(ratings_matrix[1:nrow(ratings_matrix)],method="POPULAR", parameter = list(normalize = norm))
  # save the model to disk
  saveRDS(rec, "./Popular_sentiment_model.rds")
  # Stop the clock
  proc.time() - ptm
}