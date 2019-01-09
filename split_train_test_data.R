#DESCRIPTION: This function splits the ratings matrix into two rating matrix, one for trainin and the other for testing.
#Once created, all different recommenders can use the same train/test datasets to make predictions

split_train_test_data <- function(ratingmat){
  #INPUT: a realRatingMatrix containing the ratings
  #OUTPUT: does not return anything but creates two realRatingMatrix object in the environment: recc_data_train and recc_data_test
  which_train <- sample(x = c(TRUE, FALSE), size = nrow(ratingmat), replace = TRUE, prob = c(0.8, 0.2))
  recc_data_train <<- ratingmat[which_train, ]
  recc_data_test <<- ratingmat[!which_train, ] 
}


#----------------------------------------Test function-----------------------------------------------#
test <- split_train_test_data(ratingmat)
  
