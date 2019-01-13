#Description: funtion to split the whole dataset into test/train data
#INPUT: a realRatingMatrix containing the ratings and train_proportion which is the percentage of training data that will be taken from the rating matrix.
#OUTPUT: does not return anything but creates two realRatingMatrix object in the environment: recc_data_train and recc_data_test

split_train_test_data <- function(ratingmat, train_proportion){

  which_train <- sample(x = c(TRUE, FALSE), size = nrow(ratingmat), replace = TRUE, prob = c(train_proportion, 1-train_proportion))
  recc_data_train <<- ratingmat[which_train, ]
  recc_data_test <<- ratingmat[!which_train, ] 
}

#----Test------------------
test <- split_train_test_data(ratingmat,0.8)
