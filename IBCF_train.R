#Author: Jason

library(dplyr)
library(recommenderlab)

IBCF_train<-function(ratings_matrix){
  
  which_train <- sample(x = c(TRUE, FALSE), size = nrow(ratings_matrix), replace = TRUE, prob = c(0.8, 0.2))
  
  recc_data_train <- ratings_matrix[which_train, ]
  recc_data_test <- ratings_matrix[!which_train, ]
  
  which_set <- sample(x = 1:5, size = nrow(ratings_matrix), replace = TRUE)
  for(i_model in 1:5) {
    which_train <- which_set == i_model
    recc_data_train <- ratings_matrix[which_train, ]
    recc_data_test <- ratings_matrix[!which_train, ]
  }
  
  recommender_models <- recommenderRegistry$get_entries(dataType = "realRatingMatrix")
  recc_model <- Recommender(data = recc_data_train, method = "IBCF", parameter = list(k = 30))
  
  # save the model to disk
  saveRDS(recc_model, "./IBCF_model.rds")
}