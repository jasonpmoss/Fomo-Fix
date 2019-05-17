#----------------------- Attach packages --------------------------------------
source("libraries_required.R")
#----------------------- Inputs -----------------------------------------------
rating_threshold <- 3.5
n_recommended <- 3

#----------------------- Create ratings matrix ---------------------------------

  project <- "fomofix-217307"
  sql <- "SELECT business_id, user_id, stars FROM `fomofix-217307.fomofixds.fin_LV_Restaurant_Reviews_1_5_Year`;"
  
  #Execute the query and store the result
  ratings <- query_exec(sql, project = project, use_legacy_sql = FALSE)

  #######ADDING DATA FOR ROOFTOPS RECOMMENDATIONS
  #get the list or rooftops
  sql_rooftops<- "SELECT business_id FROM `fomofix-217307.fomofixds.rooftop_restaurant`;"
  source("get_rooftop_ratings.R")
  qry_result<-as.data.frame(query_exec(sql_rooftops, project = project, use_legacy_sql = FALSE,max_pages = Inf))
  rooftops<-get_rooftop_ratings(qry_result)
  rooftops_df <-rooftops[,c(1,4,3)]
  rooftops_names <- unique(rooftops_df$business_id)
  
  subset(ratings, business_id %in% rooftops_names)
  
  #Popular model -> modify rooftops ratings to assign 5 stars to all ratings and include 
  #them in the ratings dataset
  rooftops_df$stars <- rep(5, length(rooftops_df$business_id))
  ratings <- rbind(ratings, rooftops_df)
  
  #User-based model -> create 20 users having rated all 16 rooftops with 5 stars
  user_names <- rep("anindya_friend_1",16)
  for (i in 2:20){
    user_names <- append(user_names, rep(paste0("anindya_friend_", i),16))
  }
  business_names <- rep(rooftops_names,20)
  anindya_friends <- cbind(as.character(business_names), 
                           as.character(user_names), 
                           as.integer(rep(5, 20*16)))
  colnames(anindya_friends) <- c("business_id", "user_id", "stars")
  ratings <- rbind(ratings, anindya_friends)
  
  #create anindya user
  anindya <- as.data.frame(cbind(
    rooftops_names[1:13], 
    rep("anindya",13),
    rep(5,13)))
  
  colnames(anindya) <- c("business_id", "user_id", "stars")
  anindya$business_id <- as.character(anindya$business_id)
  anindya$user_id <- as.character(anindya$user_id)
  anindya$stars <- as.integer(anindya$stars)
  
  ratings <- rbind(ratings, anindya)
  
  
####################################################

  source("ratings_matrix.R")
  ratings_mat <- ratings_matrix_sparse(ratings$user_id, ratings$business_id, ratings$stars)
  save(ratings_mat,file="ratings.Rda")

  
#########################################################
#ADDING ROOFTOPS TO THE SENTIMENT DATASET
sql_sentiment <- "SELECT * FROM `fomofix-217307.fomofixds.fin_LV_Restaurant_Sentiments`"
sentiment <- query_exec(sql_sentiment, project = project, use_legacy_sql = FALSE)


sentiment$sentiment_score_bing <- as.numeric(sentiment$sentiment_score_bing)
sentiment$adjusted_bing <- (sentiment$sentiment_score_bing + 6)/2
rating_sentiment <- inner_join(ratings, sentiment, by="business_id")
rating_sentiment$adjusted_stars <- (as.integer(rating_sentiment$stars) + rating_sentiment$adjusted_bing)/2

rating_sentiment<- data.frame(rating_sentiment$business_id, rating_sentiment$user_id, rating_sentiment$adjusted_bing)
rating_mat_popular_sentiment<-ratings_matrix_sparse(rating_sentiment$rating_sentiment.user_id, rating_sentiment$rating_sentiment.business_id, rating_sentiment$rating_sentiment.adjusted_bing)
source("split_train_test_data.R") 
eval_sets_sentiment<- split_train_test_data_sentiment_crossval(rating_mat_popular_sentiment,folds = 4)
###########################################################


#----------------------- Train models ------------------------------------------
source("split_train_test_data.R") 
eval_set <- split_train_test_data_crossval(ratings_mat, folds = 4)
model_training_required <- TRUE #set this to TRUE to train new models
if (model_training_required == TRUE){
  source("model_training.R")
}

#############################################################
##TRAIN MODELS FOR HYBRID
UBCF_N_J_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Jaccard", nn=100))
IBCF_N_C_100 <- Recommender(recc_data_train, "IBCF", param=list(normalize = "Z-score",method="Cosine", k=100))
Popular_N <- Recommender(recc_data_train, "Popular", param=list(normalize = NULL))
Popular_sentiment_N <- Recommender(recc_data_train_sentiment, "Popular", param=list(normalize = NULL))
#############################################################

#----------------------- Create the Hybrid Model-----------------------------------
#Train
source("model_training_hybrid.R")

user <- "anindya"
source("recommended_restaurants_per_user.R")
predicted_ratings<-predict_ratings_per_user(Hybrid_model, ratings_mat, user, 10)
predictions<-predicted_ratings$Restaurant #to see only the restaurants name 
predictions

predictions[predictions %in% rooftops_names]