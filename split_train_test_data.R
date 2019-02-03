#Description: funtion to split the whole dataset into test/train data
#INPUT: a realRatingMatrix containing the ratings and train_proportion which is the percentage of training data that will be taken from the rating matrix.
#OUTPUT: does not return anything but creates two realRatingMatrix object in the environment: recc_data_train and recc_data_test

# split_train_test_data <- function(ratingmat, train_proportion){
# 
#   which_train <- sample(x = c(TRUE, FALSE), size = nrow(ratingmat), replace = TRUE, prob = c(train_proportion, 1-train_proportion))
#   recc_data_train <<- ratingmat[which_train, ]
#   recc_data_test <<- ratingmat[!which_train, ] 
# }

split_train_test_data <- function(ratingmat, train_proportion){
  items_to_keep <- 1
  rating_threshold <- 3
  n_eval <- 1
  
  ###SPLIT
  eval_sets <- evaluationScheme(data = ratingmat, 
                                method = "split",
                                train = train_proportion, 
                                given = items_to_keep, 
                                goodRating = rating_threshold, 
                                k = n_eval)
  recc_data_train <<- getData(eval_sets, "train")
  recc_data_test  <<- getData(eval_sets, "known")   
  recc_data_eval  <<- getData(eval_sets, "unknown") 

  return(eval_sets)
}

split_train_test_data_crossval <- function(ratingmat, folds=4){
  items_to_keep <- 1
  rating_threshold <- 3

  eval_sets <- evaluationScheme(data = ratingmat, 
                                method = "cross-validation",
                                k = folds, 
                                given = items_to_keep, 
                                goodRating = rating_threshold)
  recc_data_train <<- getData(eval_sets, "train")
  recc_data_test  <<- getData(eval_sets, "known")   
  recc_data_eval  <<- getData(eval_sets, "unknown") 
  
  return(eval_sets)
}

#----Test------------------
#test <- split_train_test_data(ratingmat,0.8)
