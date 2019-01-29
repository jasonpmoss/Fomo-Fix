#I'm trying to use multiple cores. This file isn't used for any part of our solution

library("future")
plan(multiprocess)

future({source("IBCF_train.R")
        IBCF_train(ratings_mat)
        print("IBCF Done")}
        , envir = parent.frame(),
       globals = list(ratings_mat = ratings_mat), packages = NULL, lazy = FALSE, seed = NULL)

future({source("UBCF_train.R")
  UBCF_train(ratings_mat)
  print("UBCF Done")}
  , envir = parent.frame(),
  globals = list(ratings_mat = ratings_mat), packages = NULL, lazy = FALSE, seed = NULL)

future({source("Popular_train.R")
  Popular_train(ratings_mat)
  print("Popular done")}
  , envir = parent.frame(),
  globals = list(ratings_mat = ratings_mat), packages = NULL, lazy = FALSE, seed = NULL)

future({IBCF_weight<-0.45
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