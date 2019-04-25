# Start the clock!
ptm_predict <- proc.time()
gc()
recc_data_test_survey

#Predict Recommendations
source("IBCF_predict.R")
IBCF_predict_survey<-IBCF_predict_restaurants(recc_data_test_survey, n_recommended)
print("IBCF restaurants predictions done") 
gc()

source("UBCF_predict.R")
UBCF_predict_survey <- UBCF_predict_restaurants(recc_data_test_survey, n_recommended)
print("UBCF restaurants predictions done")
gc()

source("Popular_predict.R")
Popular_predict <- Popular_predict_restaurants(recc_data_test_survey, n_recommended)
print("Popular restaurants predictions done")
gc()

source("Popular_sentiment_predict.R")
Popular_sentiment_predict <- Popular_sentiment_predict_restaurants(rating_mat_popular_sentiment, n_recommended)
print("Popular sentiment restaurants predictions done")


#Predict Ratings
source("IBCF_predict.R")
IBCF_predict_ratings_survey<-IBCF_predict_ratings(recc_data_test_survey)
gc()
print("IBCF ratings predictions done")

source("UBCF_predict.R")
UBCF_predict_ratings_survey<-UBCF_predict_ratings(recc_data_test_survey)
gc()
print("UBCF ratings predictions done")

source("Popular_predict.R")
Popular_predict_ratings_survey<-Popular_predict_ratings(ratings_mat)
gc()
print("Popular ratings predictions done")

source("Popular_sentiment_predict.R")
Popular_sentiment_predict_ratings_survey<-Popular_sentiment_predict_ratings(rating_mat_popular_sentiment)
gc()
print("Popular sentiment ratings predictions done")

time_to_run_code_predict<-proc.time() - ptm_predict
time_to_run_code_predict
