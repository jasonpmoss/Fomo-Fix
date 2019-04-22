### Function to evaluate the hybrid model
library(ModelMetrics)
library(data.table)
library(knitr)

get_Hybrid_Eval <- function(actual_rating, predicted_rating, actual_visit) {
  
  mse<- MSE(actual_rating, predicted_rating)
  mae<- MAE(actual_rating, predicted_rating)
  rmse<-RMSE(actual_rating, predicted_rating)

  
  threshold<-3.49
  
  eval_df<-data.frame(actual_rating, predicted_rating, actual_visit)
  eval_df$predicted_visit<-ifelse(eval_df[,2]>threshold,1,0)
  tb_tst_visited <- confusionMatrix(actual_visit, eval_df$predicted_visit)
  
  tn <- tb_tst_visited[1,1]/length(actual_visit)
  fp <- tb_tst_visited[1,2]/length(actual_visit)
  fn <- tb_tst_visited[2,1]/length(actual_visit)
  tp <- tb_tst_visited[2,2]/length(actual_visit)
  
  recall <- recall(actual_visit, eval_df$predicted_visit) #TPR
  specificity <- tnr(actual_visit, eval_df$predicted_visit) #TNR
  
  #accuracy <- 1- ce(actual_visit, eval_df$predicted_visit)
  
  #classi_error <- ce(actual_visit, eval_df$predicted_visit)
  
  precision <- ppv(actual_visit, eval_df$predicted_visit)
  
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

actual_rating_df <- as(ratings_mat, "data.frame") # Converting the rating matrix into dataframe 
pred_rating_df <- sample.int(5,size=5420, replace=TRUE) #as(hybrid_ratings, "data.frame")# converting predicted rating matrix into dataframe
MSE(actual_rating_df[,3], pred_rating_df)
MAE(actual_rating_df[,3], pred_rating_df)
RMSE(actual_rating_df[,3], pred_rating_df)
actual_visit <- sample(0:1, replace=TRUE, size = 5420)
eval_df<-data.frame(actual_rating_df[,3], pred_rating_df, actual_visit)
eval_df$predicted_visit<-ifelse(eval_df[,2]>threshold,1,0)
#table(eval_df$actual_visit, eval_df$predicted_visit)
#actual_visit
#table(eval_df[,3])
#confusionMatrix(actual_rating_df[,3], pred_rating_df, cutoff = 3.5)

get_Hybrid_Eval(eval_df[,1], eval_df[,2],eval_df[,3])
hybrid_eval_recommendations
hybrid_eval_ratings
#----------------------------
rating_mat_df <- as(ratingsmat, "data.frame")
recc_data_test_df <- as(data_test, "data.frame")
merge_data<- merge(recc_data_test_df, rating_mat_df, by=c("user","item"))
merge_data <- merge_data[,-3]

recc_test_fixed<-data_test@data

for (i in 1:(nrow(merge_data))){
  recc_test_fixed[merge_data[i,1],merge_data[i,2]]<-merge_data[i,3]
}
data_test@data<-recc_test_fixed