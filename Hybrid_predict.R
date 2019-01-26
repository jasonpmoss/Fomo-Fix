library(recommenderlab)

Hybrid_predict<-function(ratings_matrix){
  
  # load the model
  Hybrid_model <- readRDS("./Hybrid_model.rds")
  
  Hybrid_recc_predicted <- predict(Hybrid_model, ratings_matrix)
  
  return(Hybrid_recc_predicted)
}
