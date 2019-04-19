#Author: Jason
# Start the clock!
ptm <- proc.time()

#----------------------- Attach packages --------------------------------------
source("libraries_required.R")
#----------------------- Inputs -----------------------------------------------

#----------------------- Create ratings matrix ---------------------------------

ratings_mat_loaded = FALSE  #determines if we load an existing rating matrix or if we download a new dataset from the cloud
if(ratings_mat_loaded == TRUE){
  #Load the ratings matrix if needed
  load("ratings.Rda") #load presaved dataset with dataframe name "ratings"
}else{
  #Extact the dataset from GoogleBigQuery:
  project <- "fomofix-217307"
  # sql <- "SELECT * FROM `fomofix-217307.fomofixds.lv_testset`
  # WHERE business_id in (
  # SELECT business_id from `fomofix-217307.fomofixds.lv_testset`
  # WHERE user_id in (
  # SELECT  user_id 
  # FROM `fomofix-217307.fomofixds.lv_testset`
  # GROUP BY user_id
  # having count(user_id)>90
  # )
  # GROUP BY business_id
  # HAVING count(business_id) > 90
  # )"
  
  sql <- "SELECT business_id, user_id, stars FROM `fomofix-217307.fomofixds.fin_LV_Restaurant_Reviews_6_Months`;"

  #Execute the query and store the result
  ratings <- query_exec(sql, project = project, use_legacy_sql = FALSE)
  
  #Save it as a sparse RealRatingMatrix object
  source("ratings_matrix.R")
  ratings_mat<-ratings_matrix_sparse(ratings$user_id, ratings$business_id, ratings$stars)
  #save created dataset so we can re-use it on the models that we've saved -OPTIONAL-
  #save(ratings_mat,file="ratings.Rda")
}

#In case we normalize the ratings matrix:
ratings_mat_normalized <- normalize(ratings_mat)

# user_table<-ratings[ratings$user_id == user, ]
# source("ratings_matrix.R")
# user_matrix<-ratings_matrix(user_table$user_id, user_table$business_id, user_table$stars)
#user_locations<-which(grepl(user, ratings$user_id)) #show the location of users in data frame

#----------------------- Train models ------------------------------------------
source("split_train_test_data.R") 
eval_set <- split_train_test_data(ratings_mat,0.95)
model_training_required <- TRUE #set this to TRUE to train new models
if (model_training_required == TRUE){
  source("model_training.R")
}
#----------------------- Run predictions ----------------------------------------
n_recommended <- 3
predict_asynchronously <- FALSE #controls for the way predictions are computed
if(predict_asynchronously==TRUE){
  source("predictions_on_test_data_future.R")
}else{
  source("predictions_on_test_data.R")
}

#----------------------- Doing recommendations for a specific user --------------
user<-"5nEA3NHq2bdjjo3hBDp6xg" #choose a random user

#get  predicted ratings from top n restaurants. n can be passed as parameter, otherwise its value by default is 100
source("recommended_restaurants_per_user.R")
predicted_ratings<-predict_ratings_per_user(UBCF_model, ratings_mat, user, 10)
predictions<-predicted_ratings$Restaurant #to see only the restaurants name 
predictions

#check if the recommended restaurants have been already rated by the user
user_restaurants_visited<-(subset(ratings,user_id==user))[,1]
if(sum(user_restaurants_visited %in% predicted_ratings)){
  print("FOMOFIX error: Restaurant recommended has already been rated by this user")
}

#----------------------- Map recommendations -------------------------------------
source("map_recommendations.R")
predictions %<>% as.data.frame()
res_plot(get_restaurants(predictions)) #important to use get_restaurants functions in the res_plot function call

#----------------------- Show restaurants visited by user ------------------------
# table_for_user<-c(user_restaurants_visited, predictions)
# table_for_user %<>% as.data.frame()
# names(table_for_user)<-c("restaurants_visited", "predictions")
# table_for_user


#----------------------- Models Evaluation ----------------------------------------
#NOTE:the evaluation scheme is already created when training the model to split in the data

#1. Evaluate Predicted Ratings:

# We can use this code to evaluate one single model, for which we have predicted ratings
# We can do it for all users or user by user, depending on the value of "byUser"
# eval_accuracy_UBCF <- calcPredictionAccuracy(x = UBCF_predict_ratings, 
#                                         data = recc_data_eval, 
#                                         byUser = FALSE)

# To visualize only those users with no NaN values when evaluating with param byUser = TRUE
# head(eval_accuracy_UBCF[complete.cases(eval_accuracy_UBCF), ],10) #if byUser was set to FALSE, this will give an error

#To evaluate ratings of all models to compare them:
massive_models_evaluation <- TRUE #set this to TRUE to evaluate all models
if (massive_models_evaluation == TRUE){
  source("Evaluate_ratings_all_models.R")
}
eval_ratings_results


#2. Evaluate Recommendations:

# We can use this code to evaluate one single model:
# eval_results_UCFC <- evaluate(eval_set, 
#                           "UBCF", 
#                           type="topNList", 
#                           n=c(1, 3, 5, 10, 15, 20))

#To evaluate ratings of all models to compare them:
massive_models_evaluation <- TRUE #set this to TRUE to evaluate all models
#To evaluate recommendations of all models to compare them:
if (massive_models_evaluation == TRUE){
  source("Evaluation_all_models.R")
}

#Visualize Results:
#ROC Curve:
plot(eval_results, annotate=c(1,3), legend="bottomright", main = "ROC curve") # Receiver Operating Characteristic (ROC) Curve
#Precision-Recall:
plot(eval_results, "prec/rec", annotate=TRUE, main = "Precision-recall", legend="topleft") # Precision-Recall (P-R) Curves
#Confusion Matrix:
getConfusionMatrix(eval_results[[1]])
avg(eval_results)

ptm <- proc.time() - ptm
ptm
save.image(file='variable_environment_20190211.RData')

