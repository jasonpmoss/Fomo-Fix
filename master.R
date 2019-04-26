#Author: Jason
# Start the clock!
ptm <- proc.time()

#----------------------- Attach packages --------------------------------------
source("libraries_required.R")
#----------------------- Inputs -----------------------------------------------
rating_threshold <- 3.5
n_recommended <- 3

#----------------------- Create ratings matrix ---------------------------------

ratings_mat_loaded = FALSE  #determines if we load an existing rating matrix or if we download a new dataset from the cloud
if(ratings_mat_loaded == TRUE){
  #Load the ratings matrix if needed
  load("ratings.Rda") #load presaved dataset with dataframe name "ratings"
  load("survey_results.Rda")
}else{
  #Extact the dataset from GoogleBigQuery:
  project <- "fomofix-217307"
  sql <- "SELECT business_id, user_id, stars FROM `fomofix-217307.fomofixds.fin_LV_Restaurant_Reviews_1_6_Years`;"
  
  #Execute the query and store the result
  ratings <- query_exec(sql, project = project, use_legacy_sql = FALSE)
  sql_survey_results<- "SELECT * FROM `fomofix-217307.fomofixds.Live_Survey_Results`"
  #sql_survey_results<- "SELECT * FROM `fomofix-217307.fomofixds.Live_Survey_Results_ratings`"
  survey_results<-query_exec(sql_survey_results, project = project, use_legacy_sql = FALSE)
  survey_results %<>% distinct(.)
  #Save it as a sparse RealRatingMatrix object
  source("ratings_matrix.R")
  ratings_mat <- ratings_matrix_sparse(ratings$user_id, ratings$business_id, ratings$stars)
  source("ratings_matrix.R")
  ratings_mat_survey_results<-ratings_matrix_sparse(survey_results$user_id, survey_results$business_id, survey_results$stars)
  #save created dataset so we can re-use it on the models that we've saved -OPTIONAL-
  save(ratings_mat,file="ratings.Rda")
}

#In case we normalize the ratings matrix:
#ratings_mat_normalized <- normalize(ratings_mat)
source("Popular_sentiment.R")

# user_table<-ratings[ratings$user_id == user, ]
# source("ratings_matrix.R")
# user_matrix<-ratings_matrix(user_table$user_id, user_table$business_id, user_table$stars)
# user_locations<-which(grepl(user, ratings$user_id)) #show the location of users in data frame

#----------------------- Train models ------------------------------------------
source("split_train_test_data.R") 
eval_set <- split_train_test_data_crossval(ratings_mat, folds = 4)
model_training_required <- TRUE #set this to TRUE to train new models
if (model_training_required == TRUE){
  source("model_training.R")
}
#----------------------- Run predictions ----------------------------------------
predict_asynchronously <- FALSE #controls for the way predictions are computed
if(predict_asynchronously==TRUE){
  source("predictions_on_test_data_future.R")
}else{
  source("predictions_on_test_data.R")
}

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

#----------------------- Visualize Evaluation Results ----------------------------------------
display_results = TRUE
#ROC Curve:
if(display_results==TRUE){
  source("Display_evaluation_recommendations.R")
  #We tide and filter the evaluation matrix to get: precision, recall, TPR and FPR
  conf_mat <- tide_confusion_matrix(eval_results)
  #Display confusion matrix
  kable(conf_mat)
  #We display the ROC curve of each model
  display_roc_curves(conf_mat)
  #We display the precision-recall curve of each model
  display_precision_recall_curves(conf_mat)
  #We display the full confusion matrix containing results from all models
  eval_results %>% avg(getConfusionMatrix())
}


#----------------------- Create the Hybrid Model-----------------------------------
#Train
source("model_training_hybrid.R")

#Predict
source("predictions_on_test_data_hybrid.R")

# Evaluate hybrid ratings
source("Evaluate_ratings_Hybrid.R")

# Evaluate hybrid recommendations
source("Evaluate_recommendations_hybrid.R")

# #----------------------- Doing recommendations for a specific user --------------
# user<-recc_data_test@data@Dimnames[[1]][1] #choose a random user
# #get  predicted ratings from top n restaurants. n can be passed as parameter, otherwise its value by default is 100
# source("recommended_restaurants_per_user.R")
# predicted_ratings<-predict_ratings_per_user(Hybrid_model, ratings_mat, user, 10)
# predictions<-predicted_ratings$Restaurant #to see only the restaurants name 
# predictions
# 
# #check if the recommended restaurants have been already rated by the user
# user_restaurants_visited<-(subset(ratings,user_id==user))[,1]
# if(sum(user_restaurants_visited %in% predicted_ratings)){
#   print("FOMOFIX error: Restaurant recommended has already been rated by this user")
# }
# 
# #----------------------- Map recommendations -------------------------------------
# source("map_recommendations.R")
# predictions %<>% as.data.frame()
# res_plot(get_restaurants(predictions)) #important to use get_restaurants functions in the res_plot function call

ptm <- proc.time() - ptm
ptm
save.image(file='variable_environment_20190427.RData')

