### Function to evaluate the hybrid model
library(ModelMetrics)
library(data.table)
library(knitr)

get_Hybrid_Eval <- function(actual_rating, predicted_rating) {
  threshold <- rating_threshold 
  actual_rating_regression <- actual_rating
  predicted_rating_regression <- subset(predicted_rating,!is.na(predicted_rating))
  
  mse<- MSE(actual_rating_regression, predicted_rating_regression)
  mae<- MAE(actual_rating_regression, predicted_rating_regression)
  rmse<-RMSE(actual_rating_regression, predicted_rating_regression)

  eval_df<- data.frame(actual_rating, predicted_rating)
  eval_df$visited<- ifelse(is.na(eval_df$actual_rating),1,0)
  eval_df$predicted_visit<-ifelse(eval_df[,2]>threshold,1,0)
  

  
  tb_tst_visited <- confusionMatrix(eval_df$visited, eval_df$predicted_visit)
  
  tn <- tb_tst_visited[1,1]/length(eval_df$visited)
  fp <- tb_tst_visited[1,2]/length(eval_df$visited)
  fn <- tb_tst_visited[2,1]/length(eval_df$visited)
  tp <- tb_tst_visited[2,2]/length(eval_df$visited)
  
  recall <- recall(eval_df$visited, eval_df$predicted_visit) #TPR
  specificity <- tnr(eval_df$visited, eval_df$predicted_visit) #TNR
  
  #accuracy <- 1- ce(eval_df$visited, eval_df$predicted_visit)
  
  #classi_error <- ce(eval_df$visited, eval_df$predicted_visit)
  
  precision <- ppv(eval_df$visited, eval_df$predicted_visit)
  
  output<- as.data.frame(matrix(ncol=8,nrow=1))
  colnames(output) <- c("TP","FP","FN","TN","Precision","Recall","TPR","FPR")
  modtypes<-c("Results")
  (setattr(output, "row.names", modtypes))

  output["Results","TP"] <- tp
  output["Results","FP"] <- fp
  output["Results","FN"] <- fn
  output["Results","TN"] <- tn
  output["Results","Precision"] <- precision
  output["Results","Recall"] <- recall
  output["Results","TPR"] <- specificity
  output["Results","FPR"] <- 1-specificity
  
  hybrid_eval_recommendations<<-kable(output, caption="Results")
  
  output2<- as.data.frame(matrix(ncol=3,nrow=1))
  colnames(output2) <- c("RMSE","MSE","MAE")
  modtypes2<-c("Results")
  (setattr(output2, "row.names", modtypes2))
  output2["Results","RMSE"] <- rmse
  output2["Results","MSE"] <- mse
  output2["Results","MAE"] <- mae
  hybrid_eval_ratings <<-   kable(output2, caption="Results")
}

#--------------------------- test function --------------------------------------------------------------------
#Evaluate

#actual_rating_df <- as(ratings_mat, "data.frame") # Converting the rating matrix into dataframe 
#pred_rating_df <- sample.int(5,size=5420, replace=TRUE) #as(hybrid_ratings, "data.frame")# converting predicted rating matrix into dataframe
#actual_visit <- sample(0:1, replace=TRUE, size = 5420)
#eval_df<-data.frame(actual_rating_df[,3], pred_rating_df, actual_visit)
#eval_df$predicted_visit<-ifelse(eval_df[,2]>threshold,1,0)
#table(eval_df$actual_visit, eval_df$predicted_visit)
#actual_visit
#table(eval_df[,3])
#confusionMatrix(actual_rating_df[,3], pred_rating_df, cutoff = 3.5)
source("merge_data_for_hybrid_evaluation.R")
get_Hybrid_Eval(merge_data[,4], merge_data[,3])
hybrid_eval_recommendations
hybrid_eval_ratings