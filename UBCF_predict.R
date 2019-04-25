#Author: Rafa

library(plyr)
library(recommenderlab)

UBCF_predict_restaurants<-function(test_ratings_matrix,n_recommended){
  # load the model
  UBCF_model <- readRDS("./UBCF_model_survey.rds")
  
  # make a predictions on "new data" using the final model stored
  UBCF_recc_predicted <- predict(object = UBCF_model, newdata = test_ratings_matrix, n = n_recommended)
  
  return(UBCF_recc_predicted)
}

UBCF_predict_ratings<-function(test_ratings_matrix){
  # load the model
  UBCF_model <- readRDS("./UBCF_model_survey.rds")
  
  # make a predictions on "new data" using the final model stored
  UBCF_recc_predicted <- predict(object = UBCF_model, newdata = test_ratings_matrix, type = "ratings")
  
  return(UBCF_recc_predicted)
}
#-----------------------test the function----------------------------------------------

# n_recommended<-3
# UBCF_predict<-UBCF(recc_data_train, n_recommended)
# UBCF_predict
