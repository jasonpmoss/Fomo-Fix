# Start the clock!
ptm_predict <- proc.time()
gc()


#Predict Recommendations
source("IBCF_predict.R")
IBCF_predict<-IBCF_predict_restaurants(recc_data_test, n_recommended)
print("IBCF restaurants predictions done") 
gc()

source("UBCF_predict.R")
UBCF_predict <- UBCF_predict_restaurants(recc_data_test, n_recommended)
print("UBCF restaurants predictions done")
gc()

source("Popular_predict.R")
Popular_predict <- Popular_predict_restaurants(ratings_mat, n_recommended)
print("Popular restaurants predictions done")
gc()

source("Popular_sentiment_predict.R")
Popular_sentiment_predict <- Popular_sentiment_predict_restaurants(rating_mat_popular_sentiment, n_recommended)
print("Popular sentiment restaurants predictions done")


source("Hybrid_predict.R")
Hybrid_predict <- Hybrid_predict_restaurants(ratings_mat)
print("Hybrid restaurants predictions done")
gc()




#Predict Ratings
source("IBCF_predict.R")
IBCF_predict_ratings<-IBCF_predict_ratings(recc_data_test)
gc()
print("IBCF ratings predictions done")

source("UBCF_predict.R")
UBCF_predict_ratings<-UBCF_predict_ratings(recc_data_test)
gc()
print("UBCF ratings predictions done")

source("Popular_predict.R")
Popular_predict_ratings<-Popular_predict_ratings(recc_data_test)
gc()
print("Popular ratings predictions done")

source("Popular_sentiment_predict.R")
Popular_sentiment_predict_ratings<-Popular_sentiment_predict_ratings(recc_data_test_sentiment)
gc()
print("Popular sentiment ratings predictions done")

source("Hybrid_predict.R")
Hybrid_predict_ratings<-Hybrid_predict_ratings(recc_data_test)
gc()
print("Hybrid ratings predictions done")

time_to_run_code_predict<-proc.time() - ptm_predict
time_to_run_code_predict
