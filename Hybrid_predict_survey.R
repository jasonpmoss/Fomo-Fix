library(recommenderlab)

Hybrid_predict_restaurants_survey<-function(ratings_matrix){
  
  # load the model
  Hybrid_model <- readRDS("./Hybrid_model_survey.rds")
  
  Hybrid_recc_predicted <- predict(Hybrid_model, ratings_matrix)
  
  return(Hybrid_recc_predicted)
}


Hybrid_predict_ratings_survey<-function(ratings_matrix){
  
  # load the model
  Hybrid_model <- readRDS("./Hybrid_model_survey.rds")
  
  Hybrid_recc_predicted <- predict(Hybrid_model, ratings_matrix, type = "ratings")
  
  return(Hybrid_recc_predicted)
}
