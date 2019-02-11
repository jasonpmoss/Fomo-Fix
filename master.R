#Author: Jason
# Start the clock!
ptm <- proc.time()
#----------------------- Attach packages --------------------------------------
source("libraries_required.R")
#----------------------- Inputs -----------------------------------------------
# sql <- "SELECT
#   *
# FROM
#   `fomofix-217307.fomofixds.lv_testset`
# WHERE
#   stars>0;"

number_of_records<-10000
#user to be recommended for:

n_recommended<-3
#which(grepl("_ijx1PqANQVFLGNWCibdig", ratings$user_id))
model_training_required <- TRUE #set this to TRUE to train new models
massive_models_ratings_evaluation <- TRUE #set this to TRUE to evaluate all models
#----------------------- Create ratings matrix ---------------------------------
# source("get_data.R") # has to be in the same working directory or specify full path
# ratings<- get_dataframe(sql)
# ratings %<>% dplyr::sample_n(number_of_records) #shrink dataframe so that it doesn't take as long to train and run code
# save(ratings,file="ratings.Rda") #create saved dataset so we can re-use it on the models that we've saved.
user<-"JhWKw3FTZoRZ9riDd020LQ" #choose a random user

#Create the ratings matrix
load("ratings.Rda") #load presaved dataset with dataframe name "ratings"
source("ratings_matrix.R")
#ratings_mat<-ratings_matrix(ratings$user_id, ratings$business_id, ratings$stars)

#creating the rating matrix from a sparse matrix just in case it optimize computation time afterwards
ratings_mat<-ratings_matrix_sparse(ratings$user_id, ratings$business_id, ratings$stars)

#In case we normalize the ratings matrix:
#ratings_mat_normalized <- normalize(ratings_mat)

user_table<-ratings[ratings$user_id == user, ]
source("ratings_matrix.R")
user_matrix<-ratings_matrix(user_table$user_id, user_table$business_id, user_table$stars)
#user_locations<-which(grepl(user, ratings$user_id)) #show the location of users in data frame

#----------------------- Train models ------------------------------------------
# these two lines are outside the if statement because we currently use the test set to
# run predictions
source("split_train_test_data.R") 
eval_set <- split_train_test_data(ratings_mat,0.8)

if (model_training_required == TRUE){
  source("model_training.R")
}
#----------------------- Run predictions ----------------------------------------
source("predictions_on_test_data.R")

#----------------------- Doing recommendations for a specific user --------------

#get  predicted ratings from top n restaurants. n can be passed as parameter, otherwise its value by default is 100
source("recommended_restaurants_per_user.R")
predicted_ratings<-predict_ratings_per_user(Popular_model, ratings_mat, user, 20)
predictions<-predicted_ratings$Restaurant #to see only the restaurants name 
user_restaurants_visited<-(subset(ratings,user_id==user))[,1]
predictions %<>% as.data.frame()

#----------------------- Map recommendations -------------------------------------
source("map_recommendations.R")
res_plot(get_restaurants(predictions)) #important to use get_restaurants functions in the res_plot function call

#----------------------- Show restaurants visited by user ------------------------
# table_for_user<-c(user_restaurants_visited, predictions)
# table_for_user %<>% as.data.frame()
# names(table_for_user)<-c("restaurants_visited", "predictions")
# table_for_user



#----------------------- Models Evaluation ----------------------------------------
#NOTE:the evaluation scheme is already created and stored in the variable eval_sets

#1. Evaluate Ratings: We can evaluate the ratings of a single model:
eval_accuracy <- calcPredictionAccuracy(x = Hybrid_predict_ratings, 
                                        data = recc_data_eval, 
                                        byUser = FALSE)
eval_accuracy
#visualize only those users with no NaN values when evaluating with param byUser = TRUE
head(eval_accuracy[complete.cases(eval_accuracy), ],10) #if byUser was set to FALSE, this will give an error

#To evaluate ratings of all models to compare them:
if (massive_models_ratings_evaluation == TRUE){
  source("Evaluate_ratings_all_models.R")
}

#if we already run the evaluation of all models, we can see the results here:
eval_ratings_results

#2. Evaluate Recommendations:
eval_results <- evaluate(eval_set, 
                         "UBCF",
                         type="topNList",
                         n=c(1, 3, 5, 10, 15, 20))

plot(eval_results, annotate=c(1,3), legend="bottomright", main = "ROC curve") # Receiver Operating Characteristic (ROC) Curve

plot(eval_results, "prec/rec", annotate=TRUE, main = "Precision-recall", legend="topleft") # Precision-Recall (P-R) Curves

getConfusionMatrix(eval_results)[[1]]

ptm <- proc.time() - ptm
ptm
save.image(file='variable_environment_20190211.RData')

