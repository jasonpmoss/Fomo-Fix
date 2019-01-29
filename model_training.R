#I'm trying to use multiple cores. This file isn't used for any part of our solution

# Start the clock!
ptm <- proc.time()
library("future")
plan(multiprocess)
IBCF_future<- future({source("IBCF_train.R")
              IBCF_train(ratings_mat)
              print("IBCF Done")}
              , envir = parent.frame(),
             globals = list(ratings_mat = ratings_mat), packages = NULL, lazy = FALSE, seed = NULL)

UBCF_future<- future({source("UBCF_train.R")
                UBCF_train(ratings_mat)
                print("UBCF Done")}
                , envir = parent.frame(),
                globals = list(ratings_mat = ratings_mat), packages = NULL, lazy = FALSE, seed = NULL)

Popular_future<-future({source("Popular_train.R")
                  Popular_train(ratings_mat)
                  print("Popular done")}
                  , envir = parent.frame(),
                  globals = list(ratings_mat = ratings_mat), packages = NULL, lazy = FALSE, seed = NULL)
                
Hybrid_future<- future({IBCF_weight<-0.45
                UBCF_weight<-0.45
                Popular_weight<-0.1
                
                UBCF_model <- readRDS("./UBCF_model.rds")
                IBCF_model <- readRDS("./IBCF_model.rds")
                Popular_model <- readRDS("./Popular_model.rds")
                
                source("Hybrid_train.R")
                Hybrid_train <- Hybrid_train(UBCF_model, IBCF_model, Popular_model, UBCF_weight, IBCF_weight, Popular_weight)
                Hybrid_model <- readRDS("./Hybrid_model.rds")}
                  , envir = parent.frame(),
                  globals = list(ratings_mat = ratings_mat), packages = NULL, lazy = FALSE, seed = NULL,
                  evaluator = plan("next"))

IBCF_future
UBCF_future
Popular_future

hold_for_traing_hybrid_future<-future({
                                while ((!resolved(IBCF_future)) | (!resolved(UBCF_future)) | (!resolved(Popular_future))) {
                                Sys.sleep(5)
                              }
                              Hybrid_future}
                                , envir = parent.frame(),
                                globals = list(ratings_mat = ratings_mat), packages = NULL, lazy = FALSE, seed = NULL)

hold_for_traing_hybrid_future

time_to_run_code<-proc.time() - ptm
time_to_run_code
