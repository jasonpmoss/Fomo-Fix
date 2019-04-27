library(readr)
Survey_Results_User_feedback <- read_csv("Survey_Results_Cleaned.csv")
#View(Survey_Results_User_feedback)

### Function to evaluate the hybrid model

get_Hybrid_Eval <- function(actual_rating, predicted_rating) {
  #on.exit()
  threshold <- 2.125 #rating_threshold 
  actual_rating_regression <- actual_rating
  predicted_rating_regression <- subset(predicted_rating,!is.na(predicted_rating))
  
  #mse<- MSE(actual_rating_regression, predicted_rating_regression)
  #mae<- MAE(actual_rating_regression, predicted_rating_regression)
  #rmse<-RMSE(actual_rating_regression, predicted_rating_regression)
  
  eval_df<- data.frame(actual_rating, predicted_rating)
  eval_df$visited<- ifelse(is.na(eval_df$actual_rating),0,1)
  eval_df$predicted_visit<-ifelse(eval_df$predicted_rating>threshold,1,0)
  # predicted<- as.factor(eval_df$predicted_visit)
  # expected<- as.factor(eval_df$visited)
  # print(class(predicted))
  # results <- caret::confusionMatrix(data=predicted, reference=expected)
  # print(results)
  
  tb_tst_visited <- ModelMetrics::confusionMatrix(eval_df$visited, eval_df$predicted_visit)
  #print(tb_tst_visited)
  total<- tb_tst_visited[1,1]+tb_tst_visited[1,2]+tb_tst_visited[2,1]+tb_tst_visited[2,2]
  tn <- tb_tst_visited[1,1]
  fp <- tb_tst_visited[1,2]
  fn <- tb_tst_visited[2,1]
  tp <- tb_tst_visited[2,2]
  
  recall <- tp/(tp+fn) #recall(eval_df$visited, eval_df$predicted_visit) #TPR
  specificity <- tn/(tn+fp) #tnr(eval_df$visited, eval_df$predicted_visit) #TNR
  
  #accuracy <- 1- ce(eval_df$visited, eval_df$predicted_visit)
  
  #classi_error <- ce(eval_df$visited, eval_df$predicted_visit)
  
  precision <- tp/(tp+fp) #ppv(eval_df$visited, eval_df$predicted_visit)
  fpr<-fp/(fp+tn)
  
  output<- as.data.frame(matrix(ncol=8,nrow=1))
  colnames(output) <- c("TP","FP","FN","TN","Precision","Recall","TPR","FPR")
  modtypes<-c("Results")
  (setattr(output, "row.names", modtypes))
  
  output["Results","TP"] <- tp
  output["Results","FP"] <- fp
  output["Results","FN"] <- fn
  output["Results","TN"] <- tn
  output["Results","Precision"] <- precision
  # https://en.wikipedia.org/wiki/Sensitivity_and_specificity
  output["Results","Recall"] <- recall
  output["Results","TPR"] <-  recall  
  output["Results","FPR"] <- fpr
  
  #hybrid_eval_recommendations<<-kable(output, caption="Results")
  hybrid_eval_recommendations<<-output
  
  
  output2<- as.data.frame(matrix(ncol=3,nrow=1))
  colnames(output2) <- c("RMSE","MSE","MAE")
  modtypes2<-c("Results")
  (setattr(output2, "row.names", modtypes2))
  output2["Results","RMSE"] <- rmse
  output2["Results","MSE"] <- mse
  output2["Results","MAE"] <- mae
  hybrid_eval_ratings <<-   kable(output2, caption="Results")
  print(crossval::confusionMatrix(eval_df$visited,eval_df$predicted_visit,negative="control"))
  return(output)
}

#--------------------------- test function --------------------------------------------------------------------
#Evaluate

get_Hybrid_Eval(Survey_Results_User_feedback$rating_yes_only, Survey_Results_User_feedback$pred_rating)
# hybrid_eval_recommendations
# hybrid_eval_ratings
