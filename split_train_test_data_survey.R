
split_train_test_data_survey <- function(ratingmat, train_proportion){
  
  items_to_keep <- -1
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
  recc_data_test_survey  <<- fix_recc_data_test_survey(recc_data_test_survey, survey_results)
  recc_data_eval_survey  <<- getData(eval_sets, "unknown") 
  #recc_data_eval  <<- fix_recc_data_test(recc_data_eval, ratingmat)

  return(eval_sets)
}

fix_recc_data_test_survey <- function(data_test, ratingsmat){
  #ratingsmat is survey results/ratingmat
  #data_test is recc_data_test_survey/dt
  dt <- data_test
  rm <- ratingsmat
  b_ids<-(colnames(dt))
  u_ids<- unique(rm$user_id)
  merge_data_survey<- data.frame(matrix(ncol=length(b_ids),nrow=length(u_ids)))
  colnames(merge_data_survey) <- b_ids
  modtypes<-u_ids
  (setattr(merge_data_survey, "row.names", modtypes))
  for (i in 1:(nrow(rm))){
    merge_data_survey[rm[i,2],rm[i,1]]<-rm[i,3]
  }
  
  merge_data_survey<-as.matrix(merge_data_survey)
  merge_data_survey<-dropNA(merge_data_survey)
  library("Matrix")
  dt@data <- as(merge_data_survey, "dgCMatrix")
  return(dt)
}