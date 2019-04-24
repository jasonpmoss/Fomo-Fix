library(recommenderlab)

#TRAINING
library(data.table)
#Create all combination of weights for the four models
df <- expand.grid(X = seq(0,1,length=11),
                  Y = seq(0,1,length=11),
                  Z = seq(0,1,length=11),
                  W = seq(0,1,length=11))
setDT(df)
df[, Sum := X + Y + Z + W]
df1 <- df[Sum == 1] #get only those where the sum of them is equal to 1

#Create one variable for weights combination that stores the trained model with those weigths
model_names<-list()
for (i in 1:nrow(df1)){
  weight <- as.numeric(t(df1[i,1:4]))
  model_name <- print(paste0("hybrid-U_",weight[1],"-I_",weight[2],"-P_",weight[3],"-S_",weight[4],"_"))
  model_names <- append(model_names, model_name)
  assign(model_name, Hybrid_train(UBCF_C_C_10,IBCF_C_C,Popular_C,Popular_sentiment_model, 
                            weight[1],weight[2],weight[3],weight[4]))
}
model_names <- as.character(model_names)

#PREDICT RATINGS

for (i in 1:nrow(df1)){
  #create variable name to store the predictions
  weight <- as.numeric(t(df1[i,1:4]))
  model_name <- print(paste0("hybrid-U_",weight[1],"-I_",weight[2],"-P_",weight[3],"-S_",weight[4],"_"))
  prediction_name <- print(paste0("p_hybrid-U_",weight[1],"-I_",weight[2],"-P_",weight[3],"-S_",weight[4],"_"))

    #predict
  assign(prediction_name, predict(get(model_name), recc_data_test, type = "ratings"))
}


#EVALUATE
eval_names <- list()
for (i in 1:nrow(df1)){
  #create variable name to store the evaluations
  weight <- as.numeric(t(df1[i,1:4]))
  prediction_name <- print(paste0("p_hybrid-U_",weight[1],"-I_",weight[2],"-P_",weight[3],"-S_",weight[4],"_"))
  eval_name <- print(paste0("accuracy_hybrid-U_",weight[1],"-I_",weight[2],"-P_",weight[3],"-S_",weight[4],"_"))
  eval_names <- append(eval_names, eval_name)
  
  # evaluate
  assign(eval_name, calcPredictionAccuracy(get(prediction_name), recc_data_eval))
  print(get(eval_name))
}

eval_names <- as.character(eval_names)
eval_ratings_results <- c()
for (i in 1:length(eval_names)){
  eval_ratings_results <- rbind(eval_ratings_results,get(eval_names[i]))
} 

eval_ratings_results <- data.frame(eval_ratings_results)
rownames(eval_ratings_results) <- model_names
eval_ratings_results <- eval_ratings_results[order(eval_ratings_results$RMSE ),]
eval_ratings_results


eval_ratings_results$rec_type <- rownames(eval_ratings_results)

#### PLOT - ALL Model Errors ####
eval_ratings_results_long<- gather(eval_ratings_results, Error , Err_Value, RMSE:MAE)

#Remove chart 
source("remove_chart_junk.R")
myChartAttr <- myChartAttr_fn()


#### PLOT - Popular Sentiment model Errors ####
library(gghighlight)
ggplot(eval_ratings_results_long, aes(fill = Error, x = rec_type, y=Err_Value)) +
  geom_bar(position="dodge", stat="identity",width = 0.85) +
  myChartAttr +
  labs(x="",y ="Error Rate") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.9)) +
  scale_fill_manual(values=colorbar) 

#### RMSE Graphs with highlight####

eval_ratings_results_long_RMSE <- subset(eval_ratings_results_long, Error == "RMSE")
eval_ratings_results_long_RMSE$Err_Value <- log(eval_ratings_results_long_RMSE$Err_Value)

ggplot(eval_ratings_results_long_RMSE, aes(x = rec_type, y=Err_Value)) +
  geom_bar(position="dodge", stat="identity",width = 0.7) +
  myChartAttr +
  labs(x="",y ="RMSE error rate") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.9)) +
  scale_fill_manual(values="#808080") + 
  geom_bar(data=subset(eval_ratings_results_long_RMSE, Err_Value==min(Err_Value)), aes(rec_type, Err_Value), fill="#f55d4b", stat="identity",width = 0.7)

#### MAE Graphs with highlight####

eval_ratings_results_long_MAE <- subset(eval_ratings_results_long, Error == "MAE")
eval_ratings_results_long_MAE$Err_Value <- log(eval_ratings_results_long_MAE$Err_Value)

ggplot(eval_ratings_results_long_MAE, aes(x = rec_type, y=Err_Value)) +
  geom_bar(position="dodge", stat="identity",width = 0.7) +
  myChartAttr +
  labs(x="",y ="MAE error rate") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.9)) +
  scale_fill_manual(values="#808080") + 
  geom_bar(data=subset(eval_ratings_results_long_MAE, Err_Value==min(Err_Value)), aes(rec_type, Err_Value), fill="#f55d4b", stat="identity",width = 0.7)

#### MSE GRAPH with highlight ####
eval_ratings_results_long_MSE <- subset(eval_ratings_results_long, Error == "MSE")
eval_ratings_results_long_MSE$Err_Value <- log(eval_ratings_results_long_MSE$Err_Value)

ggplot(eval_ratings_results_long_MSE, aes(x = rec_type, y=Err_Value)) +
  geom_bar(position="dodge", stat="identity",width = 0.7) +
  myChartAttr +
  labs(x="",y ="MSE error rate") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.9)) +
  scale_fill_manual(values="#808080") + 
  geom_bar(data=subset(eval_ratings_results_long_MSE, Err_Value==min(Err_Value)), aes(rec_type, Err_Value), fill="#f55d4b", stat="identity",width = 0.7)




