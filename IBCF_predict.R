#Author: Jason

library(dplyr)
library(recommenderlab)

IBCF<-function(ratings_matrix,user_number,n_recommended){
  # load the model
  IBCF_model <- readRDS("./IBCF_model.rds")
  
  # make a predictions on "new data" using the final model
  recc_predicted <- predict(object = IBCF_model, newdata = recc_data_test, n = 3)
  
  recc_list <- sapply(recc_predicted@items, function(x){
    colnames(ratings_matrix)[x]
  })
  recc_matrix <- ldply(recc_list, rbind)
  recc_matrix_not_empty <- recc_matrix[!is.na(recc_matrix[2]),]
  
  return(recc_matrix_not_empty[user_number,1:n_recommended])
}
n_recommended<-1
IBCF_predict<-IBCF(recc_data_test, 15, n_recommended)
IBCF_predict
