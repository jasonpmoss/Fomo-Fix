#Author: Jason

library(plyr)
library(recommenderlab)

IBCF<-function(ratings_matrix,user_number,n_recommended){
  # load the model
  IBCF_model <- readRDS("./IBCF_model.rds")
  
  # make a predictions on "new data" using the final model
  recc_predicted <- predict(object = IBCF_model, newdata = ratings_matrix, n = n_recommended)
  
  recc_list <- sapply(recc_predicted@items, function(x){
    colnames(ratings_matrix)[x]
  })
  recc_matrix <- ldply(recc_list, rbind)
  recc_matrix_not_empty <- recc_matrix[!is.na(recc_matrix[2]),]
  
  return(recc_matrix_not_empty[user_number,])
}
n_recommended<-3
user_number<-15
IBCF_predict<-IBCF(recc_data_train, user_number, n_recommended)
IBCF_predict
