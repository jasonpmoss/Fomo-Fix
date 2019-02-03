#Author: Jason

library(dplyr)
library(recommenderlab)

Popular_predict_restaurants<-function(ratings_matrix, n_recommended){

  Popular_model <- readRDS("./Popular_model.rds")
  
  popular_recc_predicted <- predict(object = Popular_model, ratings_matrix, n=n_recommended)
  
  return(popular_recc_predicted)

}

Popular_predict_ratings<-function(ratings_matrix){
  
  Popular_model <- readRDS("./Popular_model.rds")
  
  popular_recc_predicted <- predict(object = Popular_model, ratings_matrix, type = "ratings")
  
  return(popular_recc_predicted)
  
}

#----------------------------------------testing the function-----------------------------------------------#

#pop_predict<-Popular_train(ratings_mat)
#pop_predict
