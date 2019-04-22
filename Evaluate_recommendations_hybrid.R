### Function to evaluate the hybrid model
get_Hybrid_Eval <- function(p_act_and_pred) {
  tb_tst_visited <- table(p_act_and_pred[, c("visited", 
                                             "visit_pred")])
  
  #View(tb_tst_visited)
  tn <- tb_tst_visited[1,1]
  fp <- tb_tst_visited[1,2]
  fn <- tb_tst_visited[2,1]
  tp <- tb_tst_visited[2,2]
  
  #(sensitivity*100)% of the times a user visited a restaurant, we correctly classified it as a visit.
  sensitivity <- tp / (tp + fn) #This is recall / tpr
  #(specificity*100)% of the "no-visits" by users to a restaurant have been correctly identified by our model.
  specificity <- tn / (tn + fp) #This is tnr
  
  
  #Classification accuracy
  classi_accu <- ((tp + tn ) / (tp + tn+ fp + fn) )
  
  #Classification error
  classi_error <- 1 - classi_accu
  
  #Precision
  #When a positive value is predicted, how often is the prediction correct?
  #How "precise" is the classifier when predicting positive instances?
  
  precision <- tp / (tp + fp)
  
  df <- data.frame(matrix(ncol = 2,
                          nrow = 0 ))
  
  names(df) <- c("Metric", "Value")
  
  df <- rbind(df,
              list("TP", tp))
  df <- rbind(df,
              list("TN", tn))
  df <- rbind(df,
              list("FP", fp))
  df <- rbind(df,
              list("FN", fn))
  df <- rbind(df,
              list("Recall", sensitivity))
  df <- rbind(df,
              list("Specificity", specificity))
  df <- rbind(df,
              list("Classification Accuracy", classi_accu))
  df <- rbind(df,
              list("Classification Error", classi_error))
  df <- rbind(df,
              list("Precision", precision))
  
  df
}

#--------------------------- test function --------------------------------------------------------------------
#Evaluate

actual_rating_df <- as(ratings_mat, "data.frame") # Converting the rating matrix into dataframe 
pred_rating_df <- as(hybrid_ratings, "data.frame")# converting predicted rating matrix into dataframe
merge_data<- merge(actual_rating_df, pred_rating_df, by=c("user","item"))# merge the ratings by user and business combination
merge_data<-subset(merge_data, select = 3:4)
names(merge_data) <- c("visited", "visit_pred") # rename the column name
get_Hybrid_Eval(merge_data)
