library(recommenderlab)

n_fold<-4
n_eval<-2
items_to_keep<-0
rating_threshold<-3
percentage_training<-0.8
df=ratings
items_to_recommend<-3
model_to_evaluate<-"IBCF"
model_parameters<-NULL

source("ratings_matrix.R")
df<-ratings_matrix(df$user_id, df$business_id, df$stars)
eval_sets<- evaluationScheme(data=df, method="split",train = percentage_training, give = items_to_keep, goodRating = rating_threshold, k=n_eval)

eval_sets
getData(eval_sets,"train")

eval_recommender<-Recommender(data=getData(eval_sets,"train"), method=model_to_evaluate, parameter = model_parameters)

eval_prediction<-predict(object = eval_recommender, newdata = getData(eval_sets,"known"), n=items_to_recommend, type = "ratings")

eval_accuracy<- calcPredictionAccuracy(x=eval_prediction, data = getData(eval_sets,"known"),byUser=TRUE)
head(eval_accuracy)

results<-evaluate(x=eval_sets, method = model_to_evaluate, n = seq(10,100,10))

head(getConfusionMatrix(results)[[1]])

columns_to_sum<-c("TP","FP","FN","TN")
indices_summed<-Reduce("+", getConfusionMatrix(results))[,columns_to_sum]
head(indices_summed)
plot(results,annotate=TRUE, main="ROC curve")

plot(results,"prec/rec", Annotate=TRUE, main="Precision-recall")

