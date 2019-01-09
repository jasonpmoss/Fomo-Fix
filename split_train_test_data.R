#DESCRIPTION: This function splits the ratings matrix into two rating matrix, one for trainin and the other for testing. To do so, it is required the percentage
#of training data that will be used. For example, if the function received train_proportion = 0.8, it will create a training dataset
#with 80% of the whole rating matrix and a test dataset with 20% od the rating matrix.
#Once created, all different recommenders can use the same train/test datasets to make predictions

split_train_test_data <- function(ratingmat, train_proportion){
  #INPUT: a realRatingMatrix containing the ratings and train_proportion which is the percentage of training data that will be taken from the rating matrix.
  #OUTPUT: does not return anything but creates two realRatingMatrix object in the environment: recc_data_train and recc_data_test
  which_train <- sample(x = c(TRUE, FALSE), size = nrow(ratingmat), replace = TRUE, prob = c(train_proportion, 1-train_proportion))
  recc_data_train <<- ratingmat[which_train, ]
  recc_data_test <<- ratingmat[!which_train, ] 
}


#----------------------------------------Test function-----------------------------------------------#
test <- split_train_test_data(ratingmat)
  
