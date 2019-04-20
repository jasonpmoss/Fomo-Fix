#Author: Jason

library(dplyr)
library(recommenderlab)

Popular_sentiment_predict_restaurants<-function(ratings_matrix, n_recommended){

  Popular_sentiment_model <- readRDS("./Popular_sentiment_model.rds")
  
  popular_sentiment_recc_predicted <- predict(object = Popular_sentiment_model, ratings_matrix, n=n_recommended)
  
  return(popular_sentiment_recc_predicted)

}

Popular_sentiment_predict_ratings<-function(ratings_matrix){
  
  Popular_sentiment_model <- readRDS("./Popular_sentiment_model.rds")
  
  popular_sentiment_recc_predicted <- predict(object = Popular_sentiment_model, ratings_matrix, type = "ratings")
  
  return(popular_sentiment_recc_predicted)
  
}

#----------------------------------------testing the function-----------------------------------------------#

#pop_predict<-Popular_train(ratings_mat)
#pop_predict
