
split_train_test_data_survey <- function(ratingmat, train_proportion){
  
  items_to_keep <- 1
  n_eval <- 1
  
  ###SPLIT
  eval_sets <- evaluationScheme(data = ratingmat, 
                                method = "split",
                                train = train_proportion, 
                                given = items_to_keep, 
                                goodRating = rating_threshold, 
                                k = n_eval)
  recc_data_train_survey <<- getData(eval_sets, "train")
#  recc_data_train <<- fix_recc_data_test(recc_data_train, ratingmat)
  recc_data_test_survey  <<- getData(eval_sets, "known")
  #recc_data_test  <<- fix_recc_data_test(recc_data_test, ratingmat)
  recc_data_eval_survey  <<- getData(eval_sets, "unknown") 
  #recc_data_eval  <<- fix_recc_data_test(recc_data_eval, ratingmat)

  return(eval_sets)
}