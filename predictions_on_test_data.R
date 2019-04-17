# Start the clock!
ptm_predict <- proc.time()
gc()


#Predict Recommendations
source("IBCF_predict.R")
IBCF_predict<-IBCF_predict_restaurants(recc_data_test, n_recommended)
print("IBCF restaurants predicitons done") 
gc()

source("UBCF_predict.R")
UBCF_predict <- UBCF_predict_restaurants(recc_data_test, n_recommended)
print("UBCF restaurants predicitons done")
gc()

source("Popular_predict.R")
Popular_predict <- Popular_predict_restaurants(ratings_mat, n_recommended)
print("Popular restaurants predicitons done")
gc()

source("Hybrid_predict.R")
Hybrid_predict <- Hybrid_predict_restaurants(ratings_mat)
print("Hybrid restaurants predicitons done")
gc()


#Predict Ratings
source("IBCF_predict.R")
IBCF_predict_ratings<-IBCF_predict_ratings(recc_data_test)
gc()
print("IBCF ratings predicitons done")

source("UBCF_predict.R")
UBCF_predict_ratings<-UBCF_predict_ratings(recc_data_test)
gc()
print("UBCF ratings predicitons done")

source("Popular_predict.R")
Popular_predict_ratings<-Popular_predict_ratings(recc_data_test)
gc()
print("Popular ratings predicitons done")

source("Hybrid_predict.R")
Hybrid_predict_ratings<-Hybrid_predict_ratings(recc_data_test)
gc()
print("Hybrid ratings predicitons done")

time_to_run_code_predict<-proc.time() - ptm_predict
time_to_run_code_predict
