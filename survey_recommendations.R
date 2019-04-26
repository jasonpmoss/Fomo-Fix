#Author: Jason
# Start the clock!
ptm <- proc.time()

#----------------------- Attach packages --------------------------------------
source("libraries_required.R")
#----------------------- Inputs -----------------------------------------------
rating_threshold <- 3.5
n_recommended <- 3

#----------------------- Create ratings matrix ---------------------------------

#Extract the dataset from GoogleBigQuery:
project <- "fomofix-217307"

sql <- "SELECT business_id, user_id, stars FROM `fomofix-217307.fomofixds.fin_LV_Restaurant_Reviews_1_5_Year`;"
  
#Execute the query and store the result
ratings <- query_exec(sql, project = project, use_legacy_sql = FALSE)
sql_survey_results<- "SELECT * FROM `fomofix-217307.fomofixds.Live_Survey_Results_ratings`"
#sql_survey_results<- "SELECT * FROM `fomofix-217307.fomofixds.Live_Survey_Results_ratings`"
survey_results<-query_exec(sql_survey_results, project = project, use_legacy_sql = FALSE)
survey_results %<>% distinct(.)
survey_results <- subset(survey_results, business_id != "#NAME?")
#Save it as a sparse RealRatingMatrix object
source("ratings_matrix.R")
ratings_mat <- ratings_matrix_sparse(ratings$user_id, ratings$business_id, ratings$stars)
source("ratings_matrix.R")
ratings_mat_survey_results<-ratings_matrix_sparse(survey_results$user_id, survey_results$business_id, survey_results$stars)

source("Popular_sentiment.R")

#----------------------- Train models ------------------------------------------
source("split_train_test_data_survey.R") 
eval_set_survey <- split_train_test_data_survey(ratings_mat, 1)

source("model_training_survey.R")

source("predictions_on_survey.R")


#----------------------- Create the Hybrid Model-----------------------------------
#Train
source("model_training_hybrid_survey.R")

#Predict
source("predictions_on_test_data_hybrid_survey.R")

# Evaluate hybrid ratings
#source("Evaluate_ratings_Hybrid.R")

# Evaluate hybrid recommendations
#source("Evaluate_recommendations_hybrid.R")

#----------------------- Doing recommendations for all users --------------


survey_predictions_df<- as(Hybrid_predict_ratings,"data.frame")

survey_predictions_df %<>%    arrange(desc(rating)) %>%   group_by(user) %>%   top_n(n = 5)

restaurant_list<-get_restaurants(data.frame(unique(survey_predictions_df$item)))
survey_predictions_df<-merge(survey_predictions_df,restaurant_list, by.x="item", by.y="business_id")
write.csv(survey_predictions_df, file = "survey_recommendation_result.csv", row.names = FALSE)


#----------------------- Doing recommendations for a specific user --------------
user<-ratings_mat_survey_results@data@Dimnames[[1]][5] #choose a random user
#get  predicted ratings from top n restaurants. n can be passed as parameter, otherwise its value by default is 100
source("recommended_restaurants_per_user.R")
predicted_ratings<-predict_ratings_per_user(Hybrid_model_survey, ratings_mat, user, 5)
#predictions<-predicted_ratings$Restaurant #to see only the restaurants name 
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
