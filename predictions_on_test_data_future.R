library("future")
plan(multiprocess)
# Start the clock!
ptm_predict <- proc.time()

IBCF_predict_future<-future({
                              source("IBCF_predict.R")
                              IBCF_predict<-IBCF_predict_restaurants(recc_data_test, n_recommended)
                              print("IBCF test predicitons done")}, 
                              envir = parent.frame(), globals = TRUE, packages = NULL, lazy = FALSE, seed = NULL)

UBCF_predict_future <- future({
  source("UBCF_predict.R")
  UBCF_predict <- UBCF_predict_restaurants(recc_data_test, n_recommended)
  print("UBCF test predicitons done")},
envir = parent.frame(), globals = TRUE, packages = NULL, lazy = FALSE, seed = NULL)

Popular_predict_future <- future({
  source("Popular_predict.R")
  Popular_predict <- Popular_predict_restaurants(ratings_mat, n_recommended)
  print("Popular test predicitons done")},
envir = parent.frame(), globals = TRUE, packages = NULL, lazy = FALSE, seed = NULL)


Hybrid_predict_future <- future({
  source("Hybrid_predict.R")
  Hybrid_predict <- Hybrid_predict_restaurants(ratings_mat)
  print("Hybrid test predicitons done")},
envir = parent.frame(), globals = TRUE, packages = NULL, lazy = FALSE, seed = NULL)

IBCF_predict_future
UBCF_predict_future
Popular_predict_future
Hybrid_predict_future

while ((!resolved(IBCF_predict_future)) |
       (!resolved(UBCF_predict_future)) | (!resolved(Popular_predict_future) | (!resolved(Hybrid_predict_future)))) {
  Sys.sleep(5)
}

IBCF_predict_future <- values(IBCF_predict_future)
UBCF_predict_future <- values(UBCF_predict_future)
Popular_predict_future <- values(Popular_predict_future)
Hybrid_predict_future <- values(Hybrid_predict_future)

#Predict Ratings
source("IBCF_predict.R")
IBCF_predict_ratings<-IBCF_predict_ratings(recc_data_test)

source("UBCF_predict.R")
UBCF_predict_ratings<-UBCF_predict_ratings(recc_data_test)

source("Popular_predict.R")
Popular_predict_ratings<-Popular_predict_ratings(recc_data_test)

source("Hybrid_predict.R")
Hybrid_predict_ratings<-Hybrid_predict_ratings(recc_data_test)


time_to_run_code_predict<-proc.time() - ptm_predict
time_to_run_code_predict
