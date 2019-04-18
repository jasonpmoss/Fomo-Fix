library(recommenderlab)

#we build several models with different configurations to evaluate them

# UBCF Models
# Train UBCF cosine similarity models
# Non-normalized - Cosine distance
UBCF_N_C <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL, method="Cosine"))
# Centered - Cosine distance
UBCF_C_C <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Cosine"))
# Z-score normalization - Cosine distance
UBCF_Z_C <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Cosine"))

# Train UBCF Euclidean Distance models
# Non-normalized - Euclidean Distance
UBCF_N_E <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL, method="Euclidean"))
# centered - Euclidean Distance
UBCF_C_E <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Euclidean"))
# Z-score normalization  - Euclidean Distance
UBCF_Z_E <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Euclidean"))

# Train UBCF Euclidean Distance models
# Non-normalized - Jaccard Distance
UBCF_N_J <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL, method="Jaccard"))
# centered - Euclidean Distance
UBCF_C_J <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Jaccard"))
# Z-score normalization  - Euclidean Distance
UBCF_Z_J <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Jaccard"))

# Train UBCF Non-normalized - Cosine distance models with different values of nearest neighbors
UBCF_N_C_5 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL, method="Cosine", nn=5))
UBCF_N_C_10 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Cosine", nn=10))
UBCF_N_C_15 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=15))
UBCF_N_C_50 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=50))
UBCF_N_C_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=100))

# IBCF Models
# Train IBCF cosine similarity models
# Non-normalized - Cosine distance
IBCF_N_C <- Recommender(recc_data_train, "IBCF", param=list(normalize = NULL, method="Cosine"))
# Centered - Cosine distance
IBCF_C_C <- Recommender(recc_data_train, "IBCF", param=list(normalize = "center",method="Cosine"))
# Z-score normalization - Cosine distance
IBCF_Z_C <- Recommender(recc_data_train, "IBCF", param=list(normalize = "Z-score",method="Cosine"))

# Train IBCF Euclidean Distance models
# Non-normalized - Euclidean Distance
IBCF_N_E <- Recommender(recc_data_train, "IBCF", param=list(normalize = NULL, method="Euclidean"))
# centered - Euclidean Distance
IBCF_C_E <- Recommender(recc_data_train, "IBCF", param=list(normalize = "center",method="Euclidean"))
# Z-score normalization  - Euclidean Distance
IBCF_Z_E <- Recommender(recc_data_train, "IBCF", param=list(normalize = "Z-score",method="Euclidean"))

# Train IBCF Euclidean Distance models
# Non-normalized - Jaccard Distance
IBCF_N_J <- Recommender(recc_data_train, "IBCF", param=list(normalize = NULL, method="Jaccard"))
# centered - Euclidean Distance
IBCF_C_J <- Recommender(recc_data_train, "IBCF", param=list(normalize = "center",method="Jaccard"))
# Z-score normalization  - Euclidean Distance
IBCF_Z_J <- Recommender(recc_data_train, "IBCF", param=list(normalize = "Z-score",method="Jaccard"))

# Train IBCF Non-normalized - Cosine distance models with different values of nearest neighbors
IBCF_N_C_5 <- Recommender(recc_data_train, "IBCF", param=list(normalize = NULL, method="Cosine", k=5))
IBCF_N_C_10 <- Recommender(recc_data_train, "IBCF", param=list(normalize = "center",method="Cosine", k=10))
IBCF_N_C_15 <- Recommender(recc_data_train, "IBCF", param=list(normalize = "Z-score",method="Cosine", k=15))
IBCF_N_C_50 <- Recommender(recc_data_train, "IBCF", param=list(normalize = "Z-score",method="Cosine", k=50))
IBCF_N_C_100 <- Recommender(recc_data_train, "IBCF", param=list(normalize = "Z-score",method="Cosine", k=100))

# Train IBCF Non-normalized - Cosine distance models with different values of alpha
IBCF_N_C_alpha_0.1 <- Recommender(recc_data_train, "IBCF", param=list(normalize = NULL, method="Cosine", alpha=0.1))
IBCF_N_C_alpha_0.25 <- Recommender(recc_data_train, "IBCF", param=list(normalize = "center",method="Cosine", alpha=0.25))
IBCF_N_C_alpha_0.75 <- Recommender(recc_data_train, "IBCF", param=list(normalize = "Z-score",method="Cosine", alpha=0.75))
IBCF_N_C_alpha_0.9 <- Recommender(recc_data_train, "IBCF", param=list(normalize = "Z-score",method="Cosine", alpha=0.9))

# Train Popular
Popular_N <- Recommender(recc_data_train, "Popular", param=list(normalize = NULL))
Popular_C <- Recommender(recc_data_train, "Popular", param=list(normalize = "center"))
Popular_Z <- Recommender(recc_data_train, "Popular", param=list(normalize = "Z-score"))


# Compute predicted ratings
p_UBCF_N_C <- predict(UBCF_N_C, recc_data_test, type="ratings")
p_UBCF_C_C <- predict(UBCF_C_C, recc_data_test, type="ratings")
p_UBCF_Z_C <- predict(UBCF_Z_C, recc_data_test, type="ratings")
p_UBCF_N_E <- predict(UBCF_N_E, recc_data_test, type="ratings")
p_UBCF_C_E <- predict(UBCF_C_E, recc_data_test, type="ratings")
p_UBCF_Z_E <- predict(UBCF_Z_E, recc_data_test, type="ratings")
p_UBCF_N_J <- predict(UBCF_N_E, recc_data_test, type="ratings")
p_UBCF_C_J <- predict(UBCF_C_E, recc_data_test, type="ratings")
p_UBCF_Z_J <- predict(UBCF_Z_E, recc_data_test, type="ratings")
p_UBCF_N_C_5 <- predict(UBCF_N_C_5, recc_data_test, type="ratings")
p_UBCF_N_C_10 <- predict(UBCF_N_C_10, recc_data_test, type="ratings")
p_UBCF_N_C_15 <- predict(UBCF_N_C_15, recc_data_test, type="ratings")
p_UBCF_N_C_50 <- predict(UBCF_N_C_50, recc_data_test, type="ratings")
p_UBCF_N_C_100 <- predict(UBCF_N_C_100, recc_data_test, type="ratings")

p_IBCF_N_C <- predict(IBCF_N_C, recc_data_test, type="ratings")
p_IBCF_C_C <- predict(IBCF_C_C, recc_data_test, type="ratings")
p_IBCF_Z_C <- predict(IBCF_Z_C, recc_data_test, type="ratings")
p_IBCF_N_E <- predict(IBCF_N_E, recc_data_test, type="ratings")
p_IBCF_C_E <- predict(IBCF_C_E, recc_data_test, type="ratings")
p_IBCF_Z_E <- predict(IBCF_Z_E, recc_data_test, type="ratings")
p_IBCF_N_J <- predict(IBCF_N_E, recc_data_test, type="ratings")
p_IBCF_C_J <- predict(IBCF_C_E, recc_data_test, type="ratings")
p_IBCF_Z_J <- predict(IBCF_Z_E, recc_data_test, type="ratings")
p_IBCF_N_C_5 <- predict(IBCF_N_C_5, recc_data_test, type="ratings")
p_IBCF_N_C_10 <- predict(IBCF_N_C_10, recc_data_test, type="ratings")
p_IBCF_N_C_15 <- predict(IBCF_N_C_15, recc_data_test, type="ratings")
p_IBCF_N_C_50 <- predict(IBCF_N_C_50, recc_data_test, type="ratings")
p_IBCF_N_C_100 <- predict(IBCF_N_C_100, recc_data_test, type="ratings")
p_IBCF_N_C_alpha_0.1 <- predict(IBCF_N_C_alpha_0.1, recc_data_test, type="ratings")
p_IBCF_N_C_alpha_0.25 <- predict(IBCF_N_C_alpha_0.25, recc_data_test, type="ratings")
p_IBCF_N_C_alpha_0.75 <- predict(IBCF_N_C_alpha_0.75, recc_data_test, type="ratings")
p_IBCF_N_C_alpha_0.9 <- predict(IBCF_N_C_alpha_0.9, recc_data_test, type="ratings")

p_Popular_N <- predict(Popular_N, recc_data_test, type="ratings")
p_Popular_C <- predict(Popular_C, recc_data_test, type="ratings")
p_Popular_Z <- predict(Popular_Z, recc_data_test, type="ratings")


# Set all predictions that fall outside the valid range to the boundary values
# p_UBCF_N_C@data@x[p_UBCF_N_C@data@x[] < 1] <- 1
# p_UBCF_N_C@data@x[p_UBCF_N_C@data@x[] > 5] <- 5
# p_UBCF_C_C@data@x[p_UBCF_C_C@data@x[] < 1] <- 1
# p_UBCF_C_C@data@x[p_UBCF_C_C@data@x[] > 5] <- 5
# p_UBCF_Z_C@data@x[p_UBCF_Z_C@data@x[] < 1] <- 1
# p_UBCF_Z_C@data@x[p_UBCF_Z_C@data@x[] > 5] <- 5
# 
# p_UBCF_N_E@data@x[p_UBCF_N_E@data@x[] < 1] <- 1
# p_UBCF_N_E@data@x[p_UBCF_N_E@data@x[] > 5] <- 5
# p_UBCF_C_E@data@x[p_UBCF_N_E@data@x[] < 1] <- 1
# p_UBCF_C_E@data@x[p_UBCF_N_E@data@x[] > 5] <- 5
# p_UBCF_Z_E@data@x[p_UBCF_N_E@data@x[] < 1] <- 1
# p_UBCF_Z_E@data@x[p_UBCF_N_E@data@x[] > 5] <- 5
# 
# p_UBCF_N_J@data@x[p_UBCF_N_J@data@x[] < 1] <- 1
# p_UBCF_N_J@data@x[p_UBCF_N_J@data@x[] > 5] <- 5
# p_UBCF_C_J@data@x[p_UBCF_N_J@data@x[] < 1] <- 1
# p_UBCF_C_J@data@x[p_UBCF_N_J@data@x[] > 5] <- 5
# p_UBCF_Z_J@data@x[p_UBCF_N_J@data@x[] < 1] <- 1
# p_UBCF_Z_J@data@x[p_UBCF_N_J@data@x[] > 5] <- 5
# 
# p_UBCF_N_C_5@data@x[p_UBCF_N_C_5@data@x[] < 1] <- 1
# p_UBCF_N_C_5@data@x[p_UBCF_N_C_5@data@x[] > 5] <- 5
# p_UBCF_N_C_10@data@x[p_UBCF_N_C_10@data@x[] < 1] <- 1
# p_UBCF_N_C_10@data@x[p_UBCF_N_C_10@data@x[] > 5] <- 5
# p_UBCF_N_C_15@data@x[p_UBCF_N_C_15@data@x[] < 1] <- 1
# p_UBCF_N_C_15@data@x[p_UBCF_N_C_15@data@x[] > 5] <- 5
# p_UBCF_N_C_50@data@x[p_UBCF_N_C_50@data@x[] < 1] <- 1
# p_UBCF_N_C_50@data@x[p_UBCF_N_C_50@data@x[] > 5] <- 5
# p_UBCF_N_C_100@data@x[p_UBCF_N_C_100@data@x[] < 1] <- 1
# p_UBCF_N_C_100@data@x[p_UBCF_N_C_100@data@x[] > 5] <- 5
# 
# p_IBCF_N_C@data@x[p_IBCF_N_C@data@x[] < 1] <- 1
# p_IBCF_N_C@data@x[p_IBCF_N_C@data@x[] > 5] <- 5
# p_IBCF_C_C@data@x[p_IBCF_C_C@data@x[] < 1] <- 1
# p_IBCF_C_C@data@x[p_IBCF_C_C@data@x[] > 5] <- 5
# p_IBCF_Z_C@data@x[p_IBCF_Z_C@data@x[] < 1] <- 1
# p_IBCF_Z_C@data@x[p_IBCF_Z_C@data@x[] > 5] <- 5
# 
# p_IBCF_N_E@data@x[p_IBCF_N_E@data@x[] < 1] <- 1
# p_IBCF_N_E@data@x[p_IBCF_N_E@data@x[] > 5] <- 5
# p_IBCF_C_E@data@x[p_IBCF_N_E@data@x[] < 1] <- 1
# p_IBCF_C_E@data@x[p_IBCF_N_E@data@x[] > 5] <- 5
# p_IBCF_Z_E@data@x[p_IBCF_N_E@data@x[] < 1] <- 1
# p_IBCF_Z_E@data@x[p_IBCF_N_E@data@x[] > 5] <- 5
# 
# p_IBCF_N_J@data@x[p_IBCF_N_J@data@x[] < 1] <- 1
# p_IBCF_N_J@data@x[p_IBCF_N_J@data@x[] > 5] <- 5
# p_IBCF_C_J@data@x[p_IBCF_N_J@data@x[] < 1] <- 1
# p_IBCF_C_J@data@x[p_IBCF_N_J@data@x[] > 5] <- 5
# p_IBCF_Z_J@data@x[p_IBCF_N_J@data@x[] < 1] <- 1
# p_IBCF_Z_J@data@x[p_IBCF_N_J@data@x[] > 5] <- 5
# 
# p_IBCF_N_C_5@data@x[p_IBCF_N_C_5@data@x[] < 1] <- 1
# p_IBCF_N_C_5@data@x[p_IBCF_N_C_5@data@x[] > 5] <- 5
# p_IBCF_N_C_10@data@x[p_IBCF_N_C_10@data@x[] < 1] <- 1
# p_IBCF_N_C_10@data@x[p_IBCF_N_C_10@data@x[] > 5] <- 5
# p_IBCF_N_C_15@data@x[p_IBCF_N_C_15@data@x[] < 1] <- 1
# p_IBCF_N_C_15@data@x[p_IBCF_N_C_15@data@x[] > 5] <- 5
# p_IBCF_N_C_50@data@x[p_IBCF_N_C_50@data@x[] < 1] <- 1
# p_IBCF_N_C_50@data@x[p_IBCF_N_C_50@data@x[] > 5] <- 5
# p_IBCF_N_C_100@data@x[p_IBCF_N_C_100@data@x[] < 1] <- 1
# p_IBCF_N_C_100@data@x[p_IBCF_N_C_100@data@x[] > 5] <- 5
# 
# p_IBCF_N_C_alpha_0.1@data@x[p_IBCF_N_C_alpha_0.1@data@x[] < 1] <- 1
# p_IBCF_N_C_alpha_0.1@data@x[p_IBCF_N_C_alpha_0.1@data@x[] > 5] <- 5
# p_IBCF_N_C_alpha_0.25@data@x[p_IBCF_N_C_alpha_0.25@data@x[] < 1] <- 1
# p_IBCF_N_C_alpha_0.25@data@x[p_IBCF_N_C_alpha_0.25@data@x[] > 5] <- 5
# p_IBCF_N_C_alpha_0.75@data@x[p_IBCF_N_C_alpha_0.75@data@x[] < 1] <- 1
# p_IBCF_N_C_alpha_0.75@data@x[p_IBCF_N_C_alpha_0.75@data@x[] > 5] <- 5
# p_IBCF_N_C_alpha_0.9@data@x[p_IBCF_N_C_alpha_0.9@data@x[] < 1] <- 1
# p_IBCF_N_C_alpha_0.9@data@x[p_IBCF_N_C_alpha_0.9@data@x[] > 5] <- 5
# 
# p_Popular_N@data@x[p_Popular_N@data@x[] < 1] <- 1
# p_Popular_N@data@x[p_Popular_N@data@x[] > 5] <- 5
# p_Popular_C@data@x[p_Popular_C@data@x[] < 1] <- 1
# p_Popular_C@data@x[p_Popular_C@data@x[] > 5] <- 5
# p_Popular_Z@data@x[p_Popular_Z@data@x[] < 1] <- 1
# p_Popular_Z@data@x[p_Popular_Z@data@x[] > 5] <- 5

# Evaluate performance  
library(knitr)

accuracy_UBCF_N_C <- calcPredictionAccuracy(p_UBCF_N_C, recc_data_eval)
gc()
accuracy_UBCF_C_C <- calcPredictionAccuracy(p_UBCF_C_C, recc_data_eval)
gc()
accuracy_UBCF_Z_C <- calcPredictionAccuracy(p_UBCF_Z_C, recc_data_eval)
gc()
accuracy_UBCF_N_E <- calcPredictionAccuracy(p_UBCF_N_E, recc_data_eval)
gc()
accuracy_UBCF_C_E <- calcPredictionAccuracy(p_UBCF_C_E, recc_data_eval)
gc()
accuracy_UBCF_Z_E <- calcPredictionAccuracy(p_UBCF_Z_E, recc_data_eval)
gc()
accuracy_UBCF_N_J <- calcPredictionAccuracy(p_UBCF_N_J, recc_data_eval)
gc()
accuracy_UBCF_C_J <- calcPredictionAccuracy(p_UBCF_C_J, recc_data_eval)
gc()
accuracy_UBCF_Z_J <- calcPredictionAccuracy(p_UBCF_Z_J, recc_data_eval)
gc()
accuracy_UBCF_N_C_5 <- calcPredictionAccuracy(p_UBCF_N_C_5, recc_data_eval)
gc()
accuracy_UBCF_N_C_10 <- calcPredictionAccuracy(p_UBCF_N_C_10, recc_data_eval)
gc()
accuracy_UBCF_N_C_15 <- calcPredictionAccuracy(p_UBCF_N_C_15, recc_data_eval)
gc()
accuracy_UBCF_N_C_50 <- calcPredictionAccuracy(p_UBCF_N_C_50, recc_data_eval)
gc()
accuracy_UBCF_N_C_100 <- calcPredictionAccuracy(p_UBCF_N_C_100, recc_data_eval)
gc()
accuracy_IBCF_N_C_alpha_0.1 <- calcPredictionAccuracy(p_IBCF_N_C_alpha_0.1, recc_data_eval)
gc()
accuracy_IBCF_N_C_alpha_0.25 <- calcPredictionAccuracy(p_IBCF_N_C_alpha_0.25, recc_data_eval)
gc()
accuracy_IBCF_N_C_alpha_0.75 <- calcPredictionAccuracy(p_IBCF_N_C_alpha_0.75, recc_data_eval)
gc()
accuracy_IBCF_N_C_alpha_0.9 <- calcPredictionAccuracy(p_IBCF_N_C_alpha_0.9, recc_data_eval)
gc()
accuracy_Popular_N <- calcPredictionAccuracy(p_Popular_N, recc_data_eval)
gc()
accuracy_Popular_C <- calcPredictionAccuracy(p_Popular_C, recc_data_eval)
gc()
accuracy_Popular_Z <- calcPredictionAccuracy(p_Popular_Z, recc_data_eval)
gc()

eval_ratings_results <- rbind(
  accuracy_UBCF_N_C,
  accuracy_UBCF_C_C, 
  accuracy_UBCF_Z_C,
  accuracy_UBCF_N_E,
  accuracy_UBCF_C_E,
  accuracy_UBCF_Z_E,
  accuracy_UBCF_N_J,
  accuracy_UBCF_C_J,
  accuracy_UBCF_Z_J,
  accuracy_UBCF_N_C_5,
  accuracy_UBCF_N_C_10,
  accuracy_UBCF_N_C_15,
  accuracy_UBCF_N_C_50,
  accuracy_UBCF_N_C_100,
  accuracy_IBCF_N_C_alpha_0.1,
  accuracy_IBCF_N_C_alpha_0.25,
  accuracy_IBCF_N_C_alpha_0.75,
  accuracy_IBCF_N_C_alpha_0.9,
  accuracy_Popular_N,
  accuracy_Popular_C,
  accuracy_Popular_Z
)

eval_ratings_results <- data.frame(eval_ratings_results)
rownames(eval_ratings_results) <- c("UBCF_N_C", 
                                    "UBCF_C_C", 
                                    "UBCF_Z_C", 
                                    "UBCF_N_E", 
                                    "UBCF_C_E", 
                                    "UBCF_Z_E",
                                    "UBCF_N_J",
                                    "UBCF_C_J",
                                    "UBCF_Z_J",
                                    "UBCF_N_C_5",
                                    "UBCF_N_C_10",
                                    "UBCF_N_C_15",
                                    "UBCF_N_C_50",
                                    "UBCF_N_C_100",
                                    "IBCF_N_C_alpha_0.1",
                                    "IBCF_N_C_alpha_0.25",
                                    "IBCF_N_C_alpha_0.75",
                                    "IBCF_N_C_alpha_0.9",
                                    "p_Popular_N",
                                    "p_Popular_C",
                                    "p_Popular_Z")
eval_ratings_results <- eval_ratings_results[order(eval_ratings_results$RMSE ),]
eval_ratings_results

##NOTE: We can also change the way we split trainig/test dataset and compare evaluation of
##      different values of k for the cross-validation method with 2, 4, 6,... k-folds
