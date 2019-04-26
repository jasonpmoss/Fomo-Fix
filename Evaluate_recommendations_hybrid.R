### Function to evaluate the hybrid model

get_Hybrid_Eval <- function(actual_rating, predicted_rating) {
  #on.exit()
  threshold <- 2.125 #rating_threshold 
  actual_rating_regression <- actual_rating
  predicted_rating_regression <- subset(predicted_rating,!is.na(predicted_rating))
  
  mse<- MSE(actual_rating_regression, predicted_rating_regression)
  mae<- MAE(actual_rating_regression, predicted_rating_regression)
  rmse<-RMSE(actual_rating_regression, predicted_rating_regression)

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

source("merge_data_for_hybrid_evaluation.R")
merge_data<-merge_data_for_hybrid_evaluation(Hybrid_predict_ratings)
get_Hybrid_Eval(merge_data$actual, merge_data$predicted)
# hybrid_eval_recommendations
# hybrid_eval_ratings



#TRAINING
library(data.table)
#Create all combination of weights for the four models
df <- expand.grid(X = seq(0,1,length=5),
                  Y = seq(0,1,length=5),
                  Z = seq(0,1,length=5),
                  W = seq(0,1,length=5))
setDT(df)
df[, Sum := X + Y + Z + W]
df1 <- df[Sum == 1] #get only those where the sum of them is equal to 1

#Create one variable for weights combination that stores the trained model with those weigths
model_names<-list()
for (i in 1:nrow(df1)){
  weight <- as.numeric(t(df1[i,1:4]))
  model_name <- print(paste0("hybrid_recom-U_",weight[1],"-I_",weight[2],"-P_",weight[3],"-S_",weight[4],"_"))
  model_names <- append(model_names, model_name)
  assign(model_name, Hybrid_train(UBCF_C_C_10,IBCF_C_C,Popular_C,Popular_sentiment_model, 
                                  weight[1],weight[2],weight[3],weight[4]))
}
model_names <- as.character(model_names)

#PREDICT RECOMMENDATIONS

for (i in 1:nrow(df1)){
  #create variable name to store the predictions
  weight <- as.numeric(t(df1[i,1:4]))
  model_name <- print(paste0("hybrid_recom-U_",weight[1],"-I_",weight[2],"-P_",weight[3],"-S_",weight[4],"_"))
  prediction_name <- print(paste0("p_recom_hybrid-U_",weight[1],"-I_",weight[2],"-P_",weight[3],"-S_",weight[4],"_"))
  
  #predict
  assign(prediction_name, predict(get(model_name), recc_data_test, type="ratings"))
  # print(getRatings(get(prediction_name)))
}


#EVALUATE
source("merge_data_for_hybrid_evaluation.R")
eval_names <- list()
for (i in 1:nrow(df1)){
  #create variable name to store the evaluations
  weight <- as.numeric(t(df1[i,1:4]))
  prediction_name <- print(paste0("p_recom_hybrid-U_",weight[1],"-I_",weight[2],"-P_",weight[3],"-S_",weight[4],"_"))
  eval_name <- print(paste0("eval_recom_hybrid-U_",weight[1],"-I_",weight[2],"-P_",weight[3],"-S_",weight[4],"_"))
  eval_names <- append(eval_names, eval_name)
  
  # evaluate
  merge_data_eval<-merge_data_for_hybrid_evaluation(get(prediction_name))
  #print(merge_data_eval)
  get_Hybrid_Eval(merge_data_eval$actual, merge_data_eval$predicted)
  #print(merge_data_eval$predicted)
  assign(eval_name, hybrid_eval_recommendations)
  #print(get(eval_name))
}

eval_names <- as.character(eval_names)
eval_ratings_hybrid_results <- c()
for (i in 1:length(eval_names)){
  eval_ratings_hybrid_results <- rbind(eval_ratings_hybrid_results,get(eval_names[i]))
} 

eval_ratings_hybrid_results <- data.frame(eval_ratings_hybrid_results)
rownames(eval_ratings_hybrid_results) <- model_names
View(eval_ratings_hybrid_results)
