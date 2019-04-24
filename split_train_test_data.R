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
  n_eval <- 1
  
  ###SPLIT
  eval_sets <- evaluationScheme(data = ratingmat, 
                                method = "split",
                                train = train_proportion, 
                                given = items_to_keep, 
                                goodRating = rating_threshold, 
                                k = n_eval)
  recc_data_train <<- getData(eval_sets, "train")
  recc_data_train  <<- fix_recc_data_test(recc_data_train, ratingmat)
  recc_data_test  <<- getData(eval_sets, "known")
  recc_data_test  <<- fix_recc_data_test(recc_data_test, ratingmat)
  recc_data_eval  <<- getData(eval_sets, "unknown") 
  recc_data_eval  <<- fix_recc_data_test(recc_data_eval, ratingmat)
  

  return(eval_sets)
}

split_train_test_data_crossval <- function(ratingmat, folds=4){
  items_to_keep <- -1
  
  eval_sets <<- evaluationScheme(data = ratingmat, 
                                method = "cross-validation",
                                k = folds, 
                                given = items_to_keep, 
                                goodRating = rating_threshold)
  recc_data_train <<- getData(eval_sets, "train")
  recc_data_test  <<- getData(eval_sets, "known")   
  recc_data_eval  <<- getData(eval_sets, "unknown") 
  
  return(eval_sets)
}

split_train_test_data_sentiment <- function(ratingmat, train_proportion){
  items_to_keep <- 1
  n_eval <- 1
  
  ###SPLIT
  eval_sets <- evaluationScheme(data = ratingmat, 
                                method = "split",
                                train = train_proportion, 
                                given = items_to_keep, 
                                goodRating = rating_threshold, 
                                k = n_eval)
  recc_data_train_sentiment <<- getData(eval_sets, "train")
  recc_data_train_sentiment <<- fix_recc_data_test(recc_data_train_sentiment, ratingmat)
  recc_data_test_sentiment  <<- getData(eval_sets, "known")   
  recc_data_test_sentiment  <<- fix_recc_data_test(recc_data_test_sentiment, ratingmat)
  recc_data_eval_sentiment  <<- getData(eval_sets, "unknown") 
  recc_data_eval_sentiment  <<- fix_recc_data_test(recc_data_eval_sentiment, ratingmat)
  
  return(eval_sets)
}

# split_train_test_data_sentiment <- function(ratingmat, folds=4){
#   items_to_keep <- 1
# 
#   ###SPLIT
#   eval_sets <- evaluationScheme(data = ratingmat, 
#                                 method = "cross-validation",
#                                 k = folds, 
#                                 given = items_to_keep, 
#                                 goodRating = rating_threshold)
#   recc_data_train_sentiment <<- getData(eval_sets, "train")
#   recc_data_train_sentiment <<- fix_recc_data_test(recc_data_train_sentiment, ratingmat)
#   recc_data_test_sentiment  <<- getData(eval_sets, "known")   
#   recc_data_test_sentiment  <<- fix_recc_data_test(recc_data_test_sentiment, ratingmat)
#   recc_data_eval_sentiment  <<- getData(eval_sets, "unknown") 
#   recc_data_eval_sentiment  <<- fix_recc_data_test(recc_data_eval_sentiment, ratingmat)
#   
#   return(eval_sets)
# }

fix_recc_data_test <- function(data_test, ratingsmat){
  rating_mat_df <- as(ratingsmat, "data.frame")
  recc_data_test_df <- as(data_test, "data.frame")
  merge_data<- merge(recc_data_test_df, rating_mat_df, by=c("user","item"))
  merge_data <- merge_data[,-3]
  
  recc_test_fixed<-data_test@data
  
  for (i in 1:(nrow(merge_data))){
    recc_test_fixed[merge_data[i,1],merge_data[i,2]]<-merge_data[i,3]
  }
  data_test@data<-recc_test_fixed
  return(data_test)
}
#----Test------------------
#test <- split_train_test_data(ratingmat,0.8)
