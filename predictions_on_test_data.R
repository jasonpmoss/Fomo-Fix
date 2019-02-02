library("future")
plan(multiprocess)
# Start the clock!
ptm_predict <- proc.time()

IBCF_predict_future<-future({
                              while (!resolved(IBCF_future)) {
                              Sys.sleep(5)}
                              source("IBCF_predict.R")
                              IBCF_predict<<-IBCF_predict(recc_data_test, n_recommended)
                              print("IBCF test predicitons done")}, 
                              envir = parent.frame(), globals = TRUE, packages = NULL, lazy = FALSE, seed = NULL)

UBCF_predict_future <- future({
  while (!resolved(UBCF_future)) {
    Sys.sleep(5)
  }
  source("UBCF_predict.R")
  UBCF_predict <<- UBCF_predict(recc_data_test, n_recommended)
  print("UBCF test predicitons done")},
envir = parent.frame(), globals = TRUE, packages = NULL, lazy = FALSE, seed = NULL)

Popular_predict_future <- future({
  while (!resolved(Popular_future)) {
    Sys.sleep(5)
  }
  source("Popular_predict.R")
  Popular_predict <<- Popular_predict(ratings_mat, n_recommended)
  print("Popular test predicitons done")},
envir = parent.frame(), globals = TRUE, packages = NULL, lazy = FALSE, seed = NULL)


Hybrid_predict_future <- future({
  while (!resolved(Hybrid_future)) {
    Sys.sleep(5)
  }
  source("Hybrid_predict.R")
  Hybrid_predict <<- Hybrid_predict(ratings_mat)
  print("Hybrid test predicitons done")},
envir = parent.frame(), globals = TRUE, packages = NULL, lazy = FALSE, seed = NULL)

IBCF_predict_future
UBCF_predict_future
Popular_predict_future
Hybrid_predict_future

IBCF_predict_future <- values(IBCF_predict_future)
UBCF_predict_future <- values(UBCF_predict_future)
Popular_predict_future <- values(Popular_predict_future)
Hybrid_predict_future <- values(Hybrid_predict_future)

time_to_run_code_predict<-proc.time() - ptm_predict
time_to_run_code_predict
