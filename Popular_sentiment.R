sql_sentiment <- "SELECT * FROM `fomofix-217307.fomofixds.fin_LV_Restaurant_Sentiments`"
sentiment <- query_exec(sql_sentiment, project = project, use_legacy_sql = FALSE)

sentiment$adjusted_bing <- (sentiment$sentiment_score_bing + 6)/2
rating_sentiment <- inner_join(ratings, sentiment, by="business_id")
rating_sentiment$adjusted_stars <- (rating_sentiment$stars + rating_sentiment$adjusted_bing)/2

rating_sentiment<- data.frame(rating_sentiment$business_id, rating_sentiment$user_id, rating_sentiment$adjusted_bing)
rating_mat_popular_sentiment<-ratings_matrix_sparse(rating_sentiment$rating_sentiment.user_id, rating_sentiment$rating_sentiment.business_id, rating_sentiment$rating_sentiment.adjusted_bing)
source("split_train_test_data.R") 
eval_sets_sentiment<- split_train_test_data_sentiment_crossval(rating_mat_popular_sentiment,folds = 4)