#Author: Rafa

library(plyr)
library(recommenderlab)

UBCF<-function(test_ratings_matrix,user_number,n_recommended){
  # load the model
  UBCF_model <- readRDS("./UBCF_model.rds")
  
  # make a predictions on "new data" using the final model stored
  UBCF_recc_predicted <- predict(object = UBCF_model, newdata = test_ratings_matrix, n = n_recommended)
  
  # The following lines of code are commented if we want to return the "raw" predictions, without manipulate them:
  # recc_list <- sapply(recc_predicted@items, function(x){
  #   colnames(ratings_matrix)[x]
  # })
  # recc_matrix <- ldply(recc_list, rbind)
  # recc_matrix_not_empty <- recc_matrix[!is.na(recc_matrix[2]),]
  # 
  # return(recc_matrix_not_empty[user_number,])
  
  return(UBCF_recc_predicted)
}
n_recommended<-3
user_number<-15
UBCF_predict<-UBCF(recc_data_train, user_number, n_recommended)
UBCF_predict
