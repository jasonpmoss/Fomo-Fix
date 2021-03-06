merge_data_for_hybrid_evaluation <- function(hybrid_pred_ratings){
  # Converting the ratings_mat matrix into dataframe 
  actual_rating_df <- as(ratings_mat, "data.frame")
  
  # converting predicted rating matrix into dataframe
  pred_rating_df <- as(hybrid_pred_ratings, "data.frame")
  
  
  
  # merge the ratings by user and business combination
  ### Left Join
  merge_data <- merge(pred_rating_df,actual_rating_df, by=c("user","item"), all.x=TRUE)
  names(merge_data) <- c("user", "item", "predicted","actual")
  return(merge_data)
  ### Right Join
  #merge_data<- merge(actual_rating_df, pred_rating_df, by=c("user","item"), all.y=TRUE)
  
  
  ### FULL Join
  #merge_data<- merge(actual_rating_df, pred_rating_df, by=c("user","item"), all=TRUE)
  
  #Remove colum 1 and 2 from data set 
  #merge_data<-subset(merge_data, select = 3:4)
  
  #Rename the columns
  ##names(merge_data) <- c("visited", "visit_pred")
  
  #View(merge_data)
}
