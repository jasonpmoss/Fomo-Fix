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
sql_rooftops<- "SELECT business_id FROM `fomofix-217307.fomofixds.rooftop_restaurant`;"

#Execute the query and store the result
ratings <- query_exec(sql, project = project, use_legacy_sql = FALSE)
source("get_rooftop_ratings.R")
qry_result<-as.data.frame(query_exec(sql_rooftops, project = project, use_legacy_sql = FALSE,max_pages = Inf))
rooftops<-get_rooftop_ratings(qry_result)
rooftops_df <-rooftops[,c(1,4,3)]
ratings<-rbind(ratings,rooftops_df)
ratings%<>% distinct(.)
survey_results<-anindya
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

#----------------------- Doing recommendations for all users --------------


survey_predictions_df<- as(Hybrid_predict_ratings,"data.frame")

survey_predictions_df %<>%    arrange(desc(rating)) %>%   group_by(user) %>%   top_n(n = 5)

restaurant_list<-get_restaurants(data.frame(unique(survey_predictions_df$item)))
survey_predictions_df<-merge(survey_predictions_df,restaurant_list, by.x="item", by.y="business_id")
#survey_predictions_df
predictions<-survey_predictions_df$item
#----------------------- Map recommendations -------------------------------------
source("map_recommendations.R")
predictions %<>% as.data.frame()
res_plot(get_restaurants(predictions)) #important to use get_restaurants functions in the res_plot function call
