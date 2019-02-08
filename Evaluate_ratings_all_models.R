library(recommenderlab)

#1. Train UBCF cosine similarity models
# Non-normalized - Cosine distance
UBCF_N_C <- Recommender(recc_data_train, "UBCF", 
                        param=list(normalize = NULL, method="Cosine"))
# Centered - Cosine distance
UBCF_C_C <- Recommender(recc_data_train, "UBCF", 
                        param=list(normalize = "center",method="Cosine"))
# Z-score normalization - Cosine distance
UBCF_Z_C <- Recommender(recc_data_train, "UBCF", 
                        param=list(normalize = "Z-score",method="Cosine"))

#2. Train UBCF Euclidean Distance models
# Non-normalized - Euclidean Distance
UBCF_N_E <- Recommender(recc_data_train, "UBCF", 
                        param=list(normalize = NULL, method="Euclidean"))
# centered - Euclidean Distance
UBCF_C_E <- Recommender(recc_data_train, "UBCF", 
                        param=list(normalize = "center",method="Euclidean"))
# Z-score normalization  - Euclidean Distance
UBCF_Z_E <- Recommender(recc_data_train, "UBCF", 
                        param=list(normalize = "Z-score",method="Euclidean"))
#3. Compute predicted ratings
p_UBCF_N_C <- predict(UBCF_N_C, recc_data_test, type="ratings")
p_UBCF_C_C <- predict(UBCF_C_C, recc_data_test, type="ratings")
p_UBCF_Z_C <- predict(UBCF_Z_C, recc_data_test, type="ratings")
p_UBCF_N_E <- predict(UBCF_N_E, recc_data_test, type="ratings")
p_UBCF_C_E <- predict(UBCF_C_E, recc_data_test, type="ratings")
p_UBCF_Z_E <- predict(UBCF_Z_E, recc_data_test, type="ratings")

#4. Set all predictions that fall outside the valid range to the boundary values
p_UBCF_N_C@data@x[p_UBCF_N_C@data@x[] < 1] <- 1
p_UBCF_N_C@data@x[p_UBCF_N_C@data@x[] > 5] <- 5

p_UBCF_C_C@data@x[p_UBCF_C_C@data@x[] < 1] <- 1
p_UBCF_C_C@data@x[p_UBCF_C_C@data@x[] > 5] <- 5

p_UBCF_Z_C@data@x[p_UBCF_Z_C@data@x[] < 1] <- 1
p_UBCF_Z_C@data@x[p_UBCF_Z_C@data@x[] > 5] <- 5

p_UBCF_N_E@data@x[p_UBCF_N_E@data@x[] < 1] <- 1
p_UBCF_N_E@data@x[p_UBCF_N_E@data@x[] > 5] <- 5

p_UBCF_N_E@data@x[p_UBCF_N_E@data@x[] < 1] <- 1
p_UBCF_N_E@data@x[p_UBCF_N_E@data@x[] > 5] <- 5

p_UBCF_Z_E@data@x[p_UBCF_N_C@data@x[] < 1] <- 1
p_UBCF_Z_E@data@x[p_UBCF_N_C@data@x[] > 5] <- 5

#4. Evaluate performance  
library(knitr)
eval_ratings_results <- rbind(
  calcPredictionAccuracy(p_UBCF_N_C, recc_data_eval),
  calcPredictionAccuracy(p_UBCF_C_C, recc_data_eval),
  calcPredictionAccuracy(p_UBCF_Z_C, recc_data_eval),
  calcPredictionAccuracy(p_UBCF_N_E, recc_data_eval),
  calcPredictionAccuracy(p_UBCF_C_E, recc_data_eval),
  calcPredictionAccuracy(p_UBCF_Z_E, recc_data_eval) 
)

eval_ratings_results <- data.frame(eval_ratings_results)
rownames(eval_ratings_results) <- c("UBCF_N_C", "UBCF_C_C", "UBCF_Z_C", "UBCF_N_E", "UBCF_C_E", "UBCF_Z_E")
eval_ratings_results <- eval_ratings_results[order(eval_ratings_results$RMSE ),]

kable(eval_ratings_results)

##NOTE1: we can do this again for all models: IBCF, Popular and Hybrid
##NOTE2: we have to include variation on other parameters: nearest neighbours for IBCF and UBCF 
##      and paramenter alpha in IBCF model only. 
##NOTE·: We can also change the way we split trainig/test dataset and compare evaluation of
##      different values of k for the cross-validation method with 2, 4, 6,... k-folds
##NOTE4: This will require a huge amount of time to run!!! current code took a whole night in my PC
