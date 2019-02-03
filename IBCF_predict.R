#Author: Jason

library(plyr)
library(recommenderlab)

IBCF_predict_restaurants<-function(ratings_matrix,n_recommended){
  # load the model
  IBCF_model <- readRDS("./IBCF_model.rds")
  
  # make a predictions on "new data" using the final model
  IBCF_recc_predicted <- predict(object = IBCF_model, newdata = ratings_matrix, n = n_recommended)
  
  return(IBCF_recc_predicted)
}

IBCF_predict_ratings<-function(ratings_matrix){
  # load the model
  IBCF_model <- readRDS("./IBCF_model.rds")
  
  # make a predictions on "new data" using the final model
  IBCF_recc_predicted <- predict(object = IBCF_model, newdata = ratings_matrix, type = "ratings")
  
  return(IBCF_recc_predicted)
}

#-----------------------test the function----------------------------------------------
# n_recommended<-3
# IBCF_predict<-IBCF(recc_data_train,n_recommended)
# IBCF_predict
 