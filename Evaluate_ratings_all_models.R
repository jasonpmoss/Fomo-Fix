library(recommenderlab)

#we build several models with different configurations to evaluate them

# UBCF Models
# Train UBCF Non-normalized - Cosine distance models with different values of nearest neighbors
UBCF_N_C_5 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL, method="Cosine", nn=5))
UBCF_N_C_10 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Cosine", nn=10))
UBCF_N_C_15 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Cosine", nn=15))
UBCF_N_C_25 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL, method="Cosine", nn=25))
UBCF_N_C_50 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Cosine", nn=50))
UBCF_N_C_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Cosine", nn=100))

# Train UBCF Non-normalized - Euclidean distance models with different values of nearest neighbors
UBCF_N_E_5 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL, method="Euclidean", nn=5))
UBCF_N_E_10 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Euclidean", nn=10))
UBCF_N_E_15 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Euclidean", nn=15))
UBCF_N_E_25 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL, method="Euclidean", nn=25))
UBCF_N_E_50 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Euclidean", nn=50))
UBCF_N_E_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Euclidean", nn=100))

# Train UBCF Non-normalized - Jaccard distance models with different values of nearest neighbors
UBCF_N_J_5 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL, method="Jaccard", nn=5))
UBCF_N_J_10 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Jaccard", nn=10))
UBCF_N_J_15 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Jaccard", nn=15))
UBCF_N_J_25 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL, method="Jaccard", nn=25))
UBCF_N_J_50 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Jaccard", nn=50))
UBCF_N_J_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = NULL,method="Jaccard", nn=100))

# Train UBCF center normalized - Cosine distance models with different values of nearest neighbors
UBCF_C_C_5 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center", method="Cosine", nn=5))
UBCF_C_C_10 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Cosine", nn=10))
UBCF_C_C_15 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Cosine", nn=15))
UBCF_C_C_25 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center", method="Cosine", nn=25))
UBCF_C_C_50 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Cosine", nn=50))
UBCF_C_C_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Cosine", nn=100))

# Train UBCF center normalized - Euclidean distance models with different values of nearest neighbors
UBCF_C_E_5 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center", method="Euclidean", nn=5))
UBCF_C_E_10 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Euclidean", nn=10))
UBCF_C_E_15 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Euclidean", nn=15))
UBCF_C_E_25 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center", method="Euclidean", nn=25))
UBCF_C_E_50 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Euclidean", nn=50))
UBCF_C_E_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Euclidean", nn=100))

# Train UBCF center normalized - Jaccard distance models with different values of nearest neighbors
UBCF_C_J_5 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center", method="Jaccard", nn=5))
UBCF_C_J_10 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Jaccard", nn=10))
UBCF_C_J_15 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Jaccard", nn=15))
UBCF_C_J_25 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center", method="Jaccard", nn=25))
UBCF_C_J_50 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Jaccard", nn=50))
UBCF_C_J_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "center",method="Jaccard", nn=100))

# Train UBCF z-score normalized - Cosine distance models with different values of nearest neighbors
UBCF_Z_C_5 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score", method="Cosine", nn=5))
UBCF_Z_C_10 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=10))
UBCF_Z_C_15 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=15))
UBCF_Z_C_25 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score", method="Cosine", nn=25))
UBCF_Z_C_50 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=50))
UBCF_Z_C_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=100))

# Train UBCF z-score normalized - Euclidean distance models with different values of nearest neighbors
UBCF_Z_E_5 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score", method="Euclidean", nn=5))
UBCF_Z_E_10 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Euclidean", nn=10))
UBCF_Z_E_15 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Euclidean", nn=15))
UBCF_Z_E_25 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score", method="Euclidean", nn=25))
UBCF_Z_E_50 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Euclidean", nn=50))
UBCF_Z_E_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Euclidean", nn=100))

# Train UBCF z-score normalized - Jaccard distance models with different values of nearest neighbors
UBCF_Z_J_5 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score", method="Jaccard", nn=5))
UBCF_Z_J_10 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Jaccard", nn=10))
UBCF_Z_J_15 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Jaccard", nn=15))
UBCF_Z_J_25 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score", method="Jaccard", nn=25))
UBCF_Z_J_50 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Jaccard", nn=50))
UBCF_Z_J_100 <- Recommender(recc_data_train, "UBCF", param=list(normalize = "Z-score",method="Jaccard", nn=100))

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

# Train Popular
Popular_sentiment_N <- Recommender(recc_data_train_sentiment, "Popular", param=list(normalize = NULL))
Popular_sentiment_C <- Recommender(recc_data_train_sentiment, "Popular", param=list(normalize = "center"))
Popular_sentiment_Z <- Recommender(recc_data_train_sentiment, "Popular", param=list(normalize = "Z-score"))

# Compute predicted ratings
p_UBCF_N_C_5 <- predict(UBCF_N_C_5, recc_data_test, type="ratings")
p_UBCF_N_C_10 <- predict(UBCF_N_C_10, recc_data_test, type="ratings")
p_UBCF_N_C_15 <- predict(UBCF_N_C_15, recc_data_test, type="ratings")
p_UBCF_N_C_25 <- predict(UBCF_N_C_25, recc_data_test, type="ratings")
p_UBCF_N_C_50 <- predict(UBCF_N_C_50, recc_data_test, type="ratings")
p_UBCF_N_C_100 <- predict(UBCF_N_C_100, recc_data_test, type="ratings")
p_UBCF_N_E_5 <- predict(UBCF_N_E_5, recc_data_test, type="ratings")
p_UBCF_N_E_10 <- predict(UBCF_N_E_10, recc_data_test, type="ratings")
p_UBCF_N_E_15 <- predict(UBCF_N_E_15, recc_data_test, type="ratings")
p_UBCF_N_E_25 <- predict(UBCF_N_E_25, recc_data_test, type="ratings")
p_UBCF_N_E_50 <- predict(UBCF_N_E_50, recc_data_test, type="ratings")
p_UBCF_N_E_100 <- predict(UBCF_N_E_100, recc_data_test, type="ratings")
p_UBCF_N_J_5 <- predict(UBCF_N_J_5, recc_data_test, type="ratings")
p_UBCF_N_J_10 <- predict(UBCF_N_J_10, recc_data_test, type="ratings")
p_UBCF_N_J_15 <- predict(UBCF_N_J_15, recc_data_test, type="ratings")
p_UBCF_N_J_25 <- predict(UBCF_N_J_25, recc_data_test, type="ratings")
p_UBCF_N_J_50 <- predict(UBCF_N_J_50, recc_data_test, type="ratings")
p_UBCF_N_J_100 <- predict(UBCF_N_J_100, recc_data_test, type="ratings")

p_UBCF_C_C_5 <- predict(UBCF_C_C_5, recc_data_test, type="ratings")
p_UBCF_C_C_10 <- predict(UBCF_C_C_10, recc_data_test, type="ratings")
p_UBCF_C_C_15 <- predict(UBCF_C_C_15, recc_data_test, type="ratings")
p_UBCF_C_C_25 <- predict(UBCF_C_C_25, recc_data_test, type="ratings")
p_UBCF_C_C_50 <- predict(UBCF_C_C_50, recc_data_test, type="ratings")
p_UBCF_C_C_100 <- predict(UBCF_C_C_100, recc_data_test, type="ratings")
p_UBCF_C_E_5 <- predict(UBCF_C_E_5, recc_data_test, type="ratings")
p_UBCF_C_E_10 <- predict(UBCF_C_E_10, recc_data_test, type="ratings")
p_UBCF_C_E_15 <- predict(UBCF_C_E_15, recc_data_test, type="ratings")
p_UBCF_C_E_25 <- predict(UBCF_C_E_25, recc_data_test, type="ratings")
p_UBCF_C_E_50 <- predict(UBCF_C_E_50, recc_data_test, type="ratings")
p_UBCF_C_E_100 <- predict(UBCF_C_E_100, recc_data_test, type="ratings")
p_UBCF_C_J_5 <- predict(UBCF_C_J_5, recc_data_test, type="ratings")
p_UBCF_C_J_10 <- predict(UBCF_C_J_10, recc_data_test, type="ratings")
p_UBCF_C_J_15 <- predict(UBCF_C_J_15, recc_data_test, type="ratings")
p_UBCF_C_J_25 <- predict(UBCF_C_J_25, recc_data_test, type="ratings")
p_UBCF_C_J_50 <- predict(UBCF_C_J_50, recc_data_test, type="ratings")
p_UBCF_C_J_100 <- predict(UBCF_C_J_100, recc_data_test, type="ratings")

p_UBCF_Z_C_5 <- predict(UBCF_Z_C_5, recc_data_test, type="ratings")
p_UBCF_Z_C_10 <- predict(UBCF_Z_C_10, recc_data_test, type="ratings")
p_UBCF_Z_C_15 <- predict(UBCF_Z_C_15, recc_data_test, type="ratings")
p_UBCF_Z_C_25 <- predict(UBCF_Z_C_25, recc_data_test, type="ratings")
p_UBCF_Z_C_50 <- predict(UBCF_Z_C_50, recc_data_test, type="ratings")
p_UBCF_Z_C_100 <- predict(UBCF_Z_C_100, recc_data_test, type="ratings")
p_UBCF_Z_E_5 <- predict(UBCF_Z_E_5, recc_data_test, type="ratings")
p_UBCF_Z_E_10 <- predict(UBCF_Z_E_10, recc_data_test, type="ratings")
p_UBCF_Z_E_15 <- predict(UBCF_Z_E_15, recc_data_test, type="ratings")
p_UBCF_Z_E_25 <- predict(UBCF_Z_E_25, recc_data_test, type="ratings")
p_UBCF_Z_E_50 <- predict(UBCF_Z_E_50, recc_data_test, type="ratings")
p_UBCF_Z_E_100 <- predict(UBCF_Z_E_100, recc_data_test, type="ratings")
p_UBCF_Z_J_5 <- predict(UBCF_Z_J_5, recc_data_test, type="ratings")
p_UBCF_Z_J_10 <- predict(UBCF_Z_J_10, recc_data_test, type="ratings")
p_UBCF_Z_J_15 <- predict(UBCF_Z_J_15, recc_data_test, type="ratings")
p_UBCF_Z_J_25 <- predict(UBCF_Z_J_25, recc_data_test, type="ratings")
p_UBCF_Z_J_50 <- predict(UBCF_Z_J_50, recc_data_test, type="ratings")
p_UBCF_Z_J_100 <- predict(UBCF_Z_J_100, recc_data_test, type="ratings")

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

p_Popular_sentiment_N <- predict(Popular_sentiment_N, recc_data_test_sentiment, type="ratings")
p_Popular_sentiment_C <- predict(Popular_sentiment_C, recc_data_test_sentiment, type="ratings")
p_Popular_sentiment_Z <- predict(Popular_sentiment_Z, recc_data_test_sentiment, type="ratings")


# Set all predictions that fall outside the valid range to the boundary values
p_UBCF_N_C_5@data@x[p_UBCF_N_C_5@data@x[] < 1] <- 1
p_UBCF_N_C_10@data@x[p_UBCF_N_C_10@data@x[] < 1] <- 1
p_UBCF_N_C_15@data@x[p_UBCF_N_C_15@data@x[] < 1] <- 1
p_UBCF_N_C_25@data@x[p_UBCF_N_C_25@data@x[] < 1] <- 1
p_UBCF_N_C_50@data@x[p_UBCF_N_C_50@data@x[] < 1] <- 1
p_UBCF_N_C_100@data@x[p_UBCF_N_C_100@data@x[] < 1] <- 1
p_UBCF_N_E_5@data@x[p_UBCF_N_E_5@data@x[] < 1] <- 1
p_UBCF_N_E_10@data@x[p_UBCF_N_E_10@data@x[] < 1] <- 1
p_UBCF_N_E_15@data@x[p_UBCF_N_E_15@data@x[] < 1] <- 1
p_UBCF_N_E_25@data@x[p_UBCF_N_E_25@data@x[] < 1] <- 1
p_UBCF_N_E_50@data@x[p_UBCF_N_E_50@data@x[] < 1] <- 1
p_UBCF_N_E_100@data@x[p_UBCF_N_E_100@data@x[] < 1] <- 1
p_UBCF_N_J_5@data@x[p_UBCF_N_J_5@data@x[] < 1] <- 1
p_UBCF_N_J_10@data@x[p_UBCF_N_J_10@data@x[] < 1] <- 1
p_UBCF_N_J_15@data@x[p_UBCF_N_J_15@data@x[] < 1] <- 1
p_UBCF_N_J_25@data@x[p_UBCF_N_J_25@data@x[] < 1] <- 1
p_UBCF_N_J_50@data@x[p_UBCF_N_J_50@data@x[] < 1] <- 1
p_UBCF_N_J_100@data@x[p_UBCF_N_J_100@data@x[] < 1] <- 1

p_UBCF_C_C_5@data@x[p_UBCF_C_C_5@data@x[] < 1] <- 1
p_UBCF_C_C_10@data@x[p_UBCF_C_C_10@data@x[] < 1] <- 1
p_UBCF_C_C_15@data@x[p_UBCF_C_C_15@data@x[] < 1] <- 1
p_UBCF_C_C_25@data@x[p_UBCF_C_C_25@data@x[] < 1] <- 1
p_UBCF_C_C_50@data@x[p_UBCF_C_C_50@data@x[] < 1] <- 1
p_UBCF_C_C_100@data@x[p_UBCF_C_C_100@data@x[] < 1] <- 1
p_UBCF_C_E_5@data@x[p_UBCF_C_E_5@data@x[] < 1] <- 1
p_UBCF_C_E_10@data@x[p_UBCF_C_E_10@data@x[] < 1] <- 1
p_UBCF_C_E_15@data@x[p_UBCF_C_E_15@data@x[] < 1] <- 1
p_UBCF_C_E_25@data@x[p_UBCF_C_E_25@data@x[] < 1] <- 1
p_UBCF_C_E_50@data@x[p_UBCF_C_E_50@data@x[] < 1] <- 1
p_UBCF_C_E_100@data@x[p_UBCF_C_E_100@data@x[] < 1] <- 1
p_UBCF_C_J_5@data@x[p_UBCF_C_J_5@data@x[] < 1] <- 1
p_UBCF_C_J_10@data@x[p_UBCF_C_J_10@data@x[] < 1] <- 1
p_UBCF_C_J_15@data@x[p_UBCF_C_J_15@data@x[] < 1] <- 1
p_UBCF_C_J_25@data@x[p_UBCF_C_J_25@data@x[] < 1] <- 1
p_UBCF_C_J_50@data@x[p_UBCF_C_J_50@data@x[] < 1] <- 1
p_UBCF_C_J_100@data@x[p_UBCF_C_J_100@data@x[] < 1] <- 1

p_UBCF_Z_C_5@data@x[p_UBCF_Z_C_5@data@x[] < 1] <- 1
p_UBCF_Z_C_10@data@x[p_UBCF_Z_C_10@data@x[] < 1] <- 1
p_UBCF_Z_C_15@data@x[p_UBCF_Z_C_15@data@x[] < 1] <- 1
p_UBCF_Z_C_25@data@x[p_UBCF_Z_C_25@data@x[] < 1] <- 1
p_UBCF_Z_C_50@data@x[p_UBCF_Z_C_50@data@x[] < 1] <- 1
p_UBCF_Z_C_100@data@x[p_UBCF_Z_C_100@data@x[] < 1] <- 1
p_UBCF_Z_E_5@data@x[p_UBCF_Z_E_5@data@x[] < 1] <- 1
p_UBCF_Z_E_10@data@x[p_UBCF_Z_E_10@data@x[] < 1] <- 1
p_UBCF_Z_E_15@data@x[p_UBCF_Z_E_15@data@x[] < 1] <- 1
p_UBCF_Z_E_25@data@x[p_UBCF_Z_E_25@data@x[] < 1] <- 1
p_UBCF_Z_E_50@data@x[p_UBCF_Z_E_50@data@x[] < 1] <- 1
p_UBCF_Z_E_100@data@x[p_UBCF_Z_E_100@data@x[] < 1] <- 1
p_UBCF_Z_J_5@data@x[p_UBCF_Z_J_5@data@x[] < 1] <- 1
p_UBCF_Z_J_10@data@x[p_UBCF_Z_J_10@data@x[] < 1] <- 1
p_UBCF_Z_J_15@data@x[p_UBCF_Z_J_15@data@x[] < 1] <- 1
p_UBCF_Z_J_25@data@x[p_UBCF_Z_J_25@data@x[] < 1] <- 1
p_UBCF_Z_J_50@data@x[p_UBCF_Z_J_50@data@x[] < 1] <- 1
p_UBCF_Z_J_100@data@x[p_UBCF_Z_J_100@data@x[] < 1] <- 1

p_UBCF_N_C_5@data@x[p_UBCF_N_C_5@data@x[] > 5] <- 5
p_UBCF_N_C_10@data@x[p_UBCF_N_C_10@data@x[] > 5] <- 5
p_UBCF_N_C_15@data@x[p_UBCF_N_C_15@data@x[] > 5] <- 5
p_UBCF_N_C_25@data@x[p_UBCF_N_C_25@data@x[] > 5] <- 5
p_UBCF_N_C_50@data@x[p_UBCF_N_C_50@data@x[] > 5] <- 5
p_UBCF_N_C_100@data@x[p_UBCF_N_C_100@data@x[] > 5] <- 5
p_UBCF_N_E_5@data@x[p_UBCF_N_E_5@data@x[] > 5] <- 5
p_UBCF_N_E_10@data@x[p_UBCF_N_E_10@data@x[] > 5] <- 5
p_UBCF_N_E_15@data@x[p_UBCF_N_E_15@data@x[] > 5] <- 5
p_UBCF_N_E_25@data@x[p_UBCF_N_E_25@data@x[] > 5] <- 5
p_UBCF_N_E_50@data@x[p_UBCF_N_E_50@data@x[] > 5] <- 5
p_UBCF_N_E_100@data@x[p_UBCF_N_E_100@data@x[] > 5] <- 5
p_UBCF_N_J_5@data@x[p_UBCF_N_J_5@data@x[] > 5] <- 5
p_UBCF_N_J_10@data@x[p_UBCF_N_J_10@data@x[] > 5] <- 5
p_UBCF_N_J_15@data@x[p_UBCF_N_J_15@data@x[] > 5] <- 5
p_UBCF_N_J_25@data@x[p_UBCF_N_J_25@data@x[] > 5] <- 5
p_UBCF_N_J_50@data@x[p_UBCF_N_J_50@data@x[] > 5] <- 5
p_UBCF_N_J_100@data@x[p_UBCF_N_J_100@data@x[] > 5] <- 5

p_UBCF_C_C_5@data@x[p_UBCF_C_C_5@data@x[] > 5] <- 5
p_UBCF_C_C_10@data@x[p_UBCF_C_C_10@data@x[] > 5] <- 5
p_UBCF_C_C_15@data@x[p_UBCF_C_C_15@data@x[] > 5] <- 5
p_UBCF_C_C_25@data@x[p_UBCF_C_C_25@data@x[] > 5] <- 5
p_UBCF_C_C_50@data@x[p_UBCF_C_C_50@data@x[] > 5] <- 5
p_UBCF_C_C_100@data@x[p_UBCF_C_C_100@data@x[] > 5] <- 5
p_UBCF_C_E_5@data@x[p_UBCF_C_E_5@data@x[] > 5] <- 5
p_UBCF_C_E_10@data@x[p_UBCF_C_E_10@data@x[] > 5] <- 5
p_UBCF_C_E_15@data@x[p_UBCF_C_E_15@data@x[] > 5] <- 5
p_UBCF_C_E_25@data@x[p_UBCF_C_E_25@data@x[] > 5] <- 5
p_UBCF_C_E_50@data@x[p_UBCF_C_E_50@data@x[] > 5] <- 5
p_UBCF_C_E_100@data@x[p_UBCF_C_E_100@data@x[] > 5] <- 5
p_UBCF_C_J_5@data@x[p_UBCF_C_J_5@data@x[] > 5] <- 5
p_UBCF_C_J_10@data@x[p_UBCF_C_J_10@data@x[] > 5] <- 5
p_UBCF_C_J_15@data@x[p_UBCF_C_J_15@data@x[] > 5] <- 5
p_UBCF_C_J_25@data@x[p_UBCF_C_J_25@data@x[] > 5] <- 5
p_UBCF_C_J_50@data@x[p_UBCF_C_J_50@data@x[] > 5] <- 5
p_UBCF_C_J_100@data@x[p_UBCF_C_J_100@data@x[] > 5] <- 5

p_UBCF_Z_C_5@data@x[p_UBCF_Z_C_5@data@x[] > 5] <- 5
p_UBCF_Z_C_10@data@x[p_UBCF_Z_C_10@data@x[] > 5] <- 5
p_UBCF_Z_C_15@data@x[p_UBCF_Z_C_15@data@x[] > 5] <- 5
p_UBCF_Z_C_25@data@x[p_UBCF_Z_C_25@data@x[] > 5] <- 5
p_UBCF_Z_C_50@data@x[p_UBCF_Z_C_50@data@x[] > 5] <- 5
p_UBCF_Z_C_100@data@x[p_UBCF_Z_C_100@data@x[] > 5] <- 5
p_UBCF_Z_E_5@data@x[p_UBCF_Z_E_5@data@x[] > 5] <- 5
p_UBCF_Z_E_10@data@x[p_UBCF_Z_E_10@data@x[] > 5] <- 5
p_UBCF_Z_E_15@data@x[p_UBCF_Z_E_15@data@x[] > 5] <- 5
p_UBCF_Z_E_25@data@x[p_UBCF_Z_E_25@data@x[] > 5] <- 5
p_UBCF_Z_E_50@data@x[p_UBCF_Z_E_50@data@x[] > 5] <- 5
p_UBCF_Z_E_100@data@x[p_UBCF_Z_E_100@data@x[] > 5] <- 5
p_UBCF_Z_J_5@data@x[p_UBCF_Z_J_5@data@x[] > 5] <- 5
p_UBCF_Z_J_10@data@x[p_UBCF_Z_J_10@data@x[] > 5] <- 5
p_UBCF_Z_J_15@data@x[p_UBCF_Z_J_15@data@x[] > 5] <- 5
p_UBCF_Z_J_25@data@x[p_UBCF_Z_J_25@data@x[] > 5] <- 5
p_UBCF_Z_J_50@data@x[p_UBCF_Z_J_50@data@x[] > 5] <- 5
p_UBCF_Z_J_100@data@x[p_UBCF_Z_J_100@data@x[] > 5] <- 5

p_IBCF_N_C@data@x[p_IBCF_N_C@data@x[] < 1] <- 1
p_IBCF_N_C@data@x[p_IBCF_N_C@data@x[] > 5] <- 5
p_IBCF_C_C@data@x[p_IBCF_C_C@data@x[] < 1] <- 1
p_IBCF_C_C@data@x[p_IBCF_C_C@data@x[] > 5] <- 5
p_IBCF_Z_C@data@x[p_IBCF_Z_C@data@x[] < 1] <- 1
p_IBCF_Z_C@data@x[p_IBCF_Z_C@data@x[] > 5] <- 5

p_IBCF_N_E@data@x[p_IBCF_N_E@data@x[] < 1] <- 1
p_IBCF_N_E@data@x[p_IBCF_N_E@data@x[] > 5] <- 5
p_IBCF_C_E@data@x[p_IBCF_C_E@data@x[] < 1] <- 1
p_IBCF_C_E@data@x[p_IBCF_C_E@data@x[] > 5] <- 5
p_IBCF_Z_E@data@x[p_IBCF_Z_E@data@x[] < 1] <- 1
p_IBCF_Z_E@data@x[p_IBCF_Z_E@data@x[] > 5] <- 5

p_IBCF_N_J@data@x[p_IBCF_N_J@data@x[] < 1] <- 1
p_IBCF_N_J@data@x[p_IBCF_N_J@data@x[] > 5] <- 5
p_IBCF_C_J@data@x[p_IBCF_C_J@data@x[] < 1] <- 1
p_IBCF_C_J@data@x[p_IBCF_C_J@data@x[] > 5] <- 5
p_IBCF_Z_J@data@x[p_IBCF_Z_J@data@x[] < 1] <- 1
p_IBCF_Z_J@data@x[p_IBCF_Z_J@data@x[] > 5] <- 5

p_IBCF_N_C_5@data@x[p_IBCF_N_C_5@data@x[] < 1] <- 1
p_IBCF_N_C_5@data@x[p_IBCF_N_C_5@data@x[] > 5] <- 5
p_IBCF_N_C_10@data@x[p_IBCF_N_C_10@data@x[] < 1] <- 1
p_IBCF_N_C_10@data@x[p_IBCF_N_C_10@data@x[] > 5] <- 5
p_IBCF_N_C_15@data@x[p_IBCF_N_C_15@data@x[] < 1] <- 1
p_IBCF_N_C_15@data@x[p_IBCF_N_C_15@data@x[] > 5] <- 5
p_IBCF_N_C_50@data@x[p_IBCF_N_C_50@data@x[] < 1] <- 1
p_IBCF_N_C_50@data@x[p_IBCF_N_C_50@data@x[] > 5] <- 5
p_IBCF_N_C_100@data@x[p_IBCF_N_C_100@data@x[] < 1] <- 1
p_IBCF_N_C_100@data@x[p_IBCF_N_C_100@data@x[] > 5] <- 5

p_IBCF_N_C_alpha_0.1@data@x[p_IBCF_N_C_alpha_0.1@data@x[] < 1] <- 1
p_IBCF_N_C_alpha_0.1@data@x[p_IBCF_N_C_alpha_0.1@data@x[] > 5] <- 5
p_IBCF_N_C_alpha_0.25@data@x[p_IBCF_N_C_alpha_0.25@data@x[] < 1] <- 1
p_IBCF_N_C_alpha_0.25@data@x[p_IBCF_N_C_alpha_0.25@data@x[] > 5] <- 5
p_IBCF_N_C_alpha_0.75@data@x[p_IBCF_N_C_alpha_0.75@data@x[] < 1] <- 1
p_IBCF_N_C_alpha_0.75@data@x[p_IBCF_N_C_alpha_0.75@data@x[] > 5] <- 5
p_IBCF_N_C_alpha_0.9@data@x[p_IBCF_N_C_alpha_0.9@data@x[] < 1] <- 1
p_IBCF_N_C_alpha_0.9@data@x[p_IBCF_N_C_alpha_0.9@data@x[] > 5] <- 5

p_Popular_N@data@x[p_Popular_N@data@x[] < 1] <- 1
p_Popular_N@data@x[p_Popular_N@data@x[] > 5] <- 5
p_Popular_C@data@x[p_Popular_C@data@x[] < 1] <- 1
p_Popular_C@data@x[p_Popular_C@data@x[] > 5] <- 5
p_Popular_Z@data@x[p_Popular_Z@data@x[] < 1] <- 1
p_Popular_Z@data@x[p_Popular_Z@data@x[] > 5] <- 5

p_Popular_sentiment_N@data@x[p_Popular_sentiment_N@data@x[] < 1] <- 1
p_Popular_sentiment_N@data@x[p_Popular_sentiment_N@data@x[] > 5] <- 5
p_Popular_sentiment_C@data@x[p_Popular_sentiment_C@data@x[] < 1] <- 1
p_Popular_sentiment_C@data@x[p_Popular_sentiment_C@data@x[] > 5] <- 5
p_Popular_sentiment_Z@data@x[p_Popular_sentiment_Z@data@x[] < 1] <- 1
p_Popular_sentiment_Z@data@x[p_Popular_sentiment_Z@data@x[] > 5] <- 5


# Evaluate performance  
library(knitr)

accuracy_UBCF_N_C_5    <- calcPredictionAccuracy(p_UBCF_N_C_5  , recc_data_eval)
gc()
accuracy_UBCF_N_C_10   <- calcPredictionAccuracy(p_UBCF_N_C_10 , recc_data_eval)
gc()
accuracy_UBCF_N_C_15   <- calcPredictionAccuracy(p_UBCF_N_C_15 , recc_data_eval)
gc()
accuracy_UBCF_N_C_25   <- calcPredictionAccuracy(p_UBCF_N_C_25 , recc_data_eval)
gc()
accuracy_UBCF_N_C_50   <- calcPredictionAccuracy(p_UBCF_N_C_50 , recc_data_eval)
gc()
accuracy_UBCF_N_C_100  <- calcPredictionAccuracy(p_UBCF_N_C_100, recc_data_eval)
gc()
accuracy_UBCF_N_E_5    <- calcPredictionAccuracy(p_UBCF_N_E_5  , recc_data_eval)
gc()
accuracy_UBCF_N_E_10   <- calcPredictionAccuracy(p_UBCF_N_E_10 , recc_data_eval)
gc()
accuracy_UBCF_N_E_15   <- calcPredictionAccuracy(p_UBCF_N_E_15 , recc_data_eval)
gc()
accuracy_UBCF_N_E_25   <- calcPredictionAccuracy(p_UBCF_N_E_25 , recc_data_eval)
gc()
accuracy_UBCF_N_E_50   <- calcPredictionAccuracy(p_UBCF_N_E_50 , recc_data_eval)
gc()
accuracy_UBCF_N_E_100  <- calcPredictionAccuracy(p_UBCF_N_E_100, recc_data_eval)
gc()
accuracy_UBCF_N_J_5    <- calcPredictionAccuracy(p_UBCF_N_J_5  , recc_data_eval)
gc()
accuracy_UBCF_N_J_10   <- calcPredictionAccuracy(p_UBCF_N_J_10 , recc_data_eval)
gc()
accuracy_UBCF_N_J_15   <- calcPredictionAccuracy(p_UBCF_N_J_15 , recc_data_eval)
gc()
accuracy_UBCF_N_J_25   <- calcPredictionAccuracy(p_UBCF_N_J_25 , recc_data_eval)
gc()
accuracy_UBCF_N_J_50   <- calcPredictionAccuracy(p_UBCF_N_J_50 , recc_data_eval)
gc()
accuracy_UBCF_N_J_100  <- calcPredictionAccuracy(p_UBCF_N_J_100, recc_data_eval)
gc() 
accuracy_UBCF_C_C_5    <- calcPredictionAccuracy(p_UBCF_C_C_5  , recc_data_eval)
gc()
accuracy_UBCF_C_C_10   <- calcPredictionAccuracy(p_UBCF_C_C_10 , recc_data_eval)
gc()
accuracy_UBCF_C_C_15   <- calcPredictionAccuracy(p_UBCF_C_C_15 , recc_data_eval)
gc()
accuracy_UBCF_C_C_25   <- calcPredictionAccuracy(p_UBCF_C_C_25 , recc_data_eval)
gc()
accuracy_UBCF_C_C_50   <- calcPredictionAccuracy(p_UBCF_C_C_50 , recc_data_eval)
gc()
accuracy_UBCF_C_C_100  <- calcPredictionAccuracy(p_UBCF_C_C_100, recc_data_eval)
gc()
accuracy_UBCF_C_E_5    <- calcPredictionAccuracy(p_UBCF_C_E_5  , recc_data_eval)
gc()
accuracy_UBCF_C_E_10   <- calcPredictionAccuracy(p_UBCF_C_E_10 , recc_data_eval)
gc()
accuracy_UBCF_C_E_15   <- calcPredictionAccuracy(p_UBCF_C_E_15 , recc_data_eval)
gc()
accuracy_UBCF_C_E_25   <- calcPredictionAccuracy(p_UBCF_C_E_25 , recc_data_eval)
gc()
accuracy_UBCF_C_E_50   <- calcPredictionAccuracy(p_UBCF_C_E_50 , recc_data_eval)
gc()
accuracy_UBCF_C_E_100  <- calcPredictionAccuracy(p_UBCF_C_E_100, recc_data_eval)
gc()
accuracy_UBCF_C_J_5    <- calcPredictionAccuracy(p_UBCF_C_J_5  , recc_data_eval)
gc()
accuracy_UBCF_C_J_10   <- calcPredictionAccuracy(p_UBCF_C_J_10 , recc_data_eval)
gc()
accuracy_UBCF_C_J_15   <- calcPredictionAccuracy(p_UBCF_C_J_15 , recc_data_eval)
gc()
accuracy_UBCF_C_J_25   <- calcPredictionAccuracy(p_UBCF_C_J_25 , recc_data_eval)
gc()
accuracy_UBCF_C_J_50   <- calcPredictionAccuracy(p_UBCF_C_J_50 , recc_data_eval)
gc()
accuracy_UBCF_C_J_100  <- calcPredictionAccuracy(p_UBCF_C_J_100, recc_data_eval)
gc()
accuracy_UBCF_Z_C_5    <- calcPredictionAccuracy(p_UBCF_Z_C_5  , recc_data_eval)
gc()
accuracy_UBCF_Z_C_10   <- calcPredictionAccuracy(p_UBCF_Z_C_10 , recc_data_eval)
gc()
accuracy_UBCF_Z_C_15   <- calcPredictionAccuracy(p_UBCF_Z_C_15 , recc_data_eval)
gc()
accuracy_UBCF_Z_C_25   <- calcPredictionAccuracy(p_UBCF_Z_C_25 , recc_data_eval)
gc()
accuracy_UBCF_Z_C_50   <- calcPredictionAccuracy(p_UBCF_Z_C_50 , recc_data_eval)
gc()
accuracy_UBCF_Z_C_100  <- calcPredictionAccuracy(p_UBCF_Z_C_100, recc_data_eval)
gc()
accuracy_UBCF_Z_E_5    <- calcPredictionAccuracy(p_UBCF_Z_E_5  , recc_data_eval)
gc()
accuracy_UBCF_Z_E_10   <- calcPredictionAccuracy(p_UBCF_Z_E_10 , recc_data_eval)
gc()
accuracy_UBCF_Z_E_15   <- calcPredictionAccuracy(p_UBCF_Z_E_15 , recc_data_eval)
gc()
accuracy_UBCF_Z_E_25   <- calcPredictionAccuracy(p_UBCF_Z_E_25 , recc_data_eval)
gc()
accuracy_UBCF_Z_E_50   <- calcPredictionAccuracy(p_UBCF_Z_E_50 , recc_data_eval)
gc()
accuracy_UBCF_Z_E_100  <- calcPredictionAccuracy(p_UBCF_Z_E_100, recc_data_eval)
gc()
accuracy_UBCF_Z_J_5    <- calcPredictionAccuracy(p_UBCF_Z_J_5  , recc_data_eval)
gc()
accuracy_UBCF_Z_J_10   <- calcPredictionAccuracy(p_UBCF_Z_J_10 , recc_data_eval)
gc()
accuracy_UBCF_Z_J_15   <- calcPredictionAccuracy(p_UBCF_Z_J_15 , recc_data_eval)
gc()
accuracy_UBCF_Z_J_25   <- calcPredictionAccuracy(p_UBCF_Z_J_25 , recc_data_eval)
gc()
accuracy_UBCF_Z_J_50   <- calcPredictionAccuracy(p_UBCF_Z_J_50 , recc_data_eval)
gc()
accuracy_UBCF_Z_J_100  <- calcPredictionAccuracy(p_UBCF_Z_J_100, recc_data_eval)
gc()
accuracy_IBCF_N_C     <- calcPredictionAccuracy(p_IBCF_N_C, recc_data_eval)    
gc()
accuracy_IBCF_C_C     <- calcPredictionAccuracy(p_IBCF_C_C, recc_data_eval)    
gc()
accuracy_IBCF_Z_C     <- calcPredictionAccuracy(p_IBCF_Z_C, recc_data_eval)    
gc()
accuracy_IBCF_N_E     <- calcPredictionAccuracy(p_IBCF_N_E, recc_data_eval)    
gc()
accuracy_IBCF_C_E     <- calcPredictionAccuracy(p_IBCF_C_E, recc_data_eval)    
gc()
accuracy_IBCF_Z_E     <- calcPredictionAccuracy(p_IBCF_Z_E, recc_data_eval)    
gc()
accuracy_IBCF_N_J     <- calcPredictionAccuracy(p_IBCF_N_J, recc_data_eval)    
gc()
accuracy_IBCF_C_J     <- calcPredictionAccuracy(p_IBCF_C_J, recc_data_eval)    
gc()
accuracy_IBCF_Z_J     <- calcPredictionAccuracy(p_IBCF_Z_J, recc_data_eval)    
gc()
accuracy_IBCF_N_C_5   <- calcPredictionAccuracy(p_IBCF_N_C_5, recc_data_eval)  
gc()
accuracy_IBCF_N_C_10  <- calcPredictionAccuracy(p_IBCF_N_C_10, recc_data_eval) 
gc()
accuracy_IBCF_N_C_15  <- calcPredictionAccuracy(p_IBCF_N_C_15, recc_data_eval) 
gc()
accuracy_IBCF_N_C_50  <- calcPredictionAccuracy(p_IBCF_N_C_50, recc_data_eval) 
gc()
accuracy_IBCF_N_C_100 <- calcPredictionAccuracy(p_IBCF_N_C_100, recc_data_eval)
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
accuracy_Popular_sentiment_N <- calcPredictionAccuracy(p_Popular_sentiment_N, recc_data_eval)
gc()
accuracy_Popular_sentiment_C <- calcPredictionAccuracy(p_Popular_sentiment_C, recc_data_eval)
gc()
accuracy_Popular_sentiment_Z <- calcPredictionAccuracy(p_Popular_sentiment_Z, recc_data_eval)
gc()


eval_ratings_results <- rbind(
  accuracy_UBCF_N_C_5  ,
  accuracy_UBCF_N_C_10 ,
  accuracy_UBCF_N_C_15 ,
  accuracy_UBCF_N_C_25 ,
  accuracy_UBCF_N_C_50 ,
  accuracy_UBCF_N_C_100,
  accuracy_UBCF_N_E_5  ,
  accuracy_UBCF_N_E_10 ,
  accuracy_UBCF_N_E_15 ,
  accuracy_UBCF_N_E_25 ,
  accuracy_UBCF_N_E_50 ,
  accuracy_UBCF_N_E_100,
  accuracy_UBCF_N_J_5  ,
  accuracy_UBCF_N_J_10 ,
  accuracy_UBCF_N_J_15 ,
  accuracy_UBCF_N_J_25 ,
  accuracy_UBCF_N_J_50 ,
  accuracy_UBCF_N_J_100,                                    
  accuracy_UBCF_C_C_5  , 
  accuracy_UBCF_C_C_10 , 
  accuracy_UBCF_C_C_15 , 
  accuracy_UBCF_C_C_25 , 
  accuracy_UBCF_C_C_50 , 
  accuracy_UBCF_C_C_100, 
  accuracy_UBCF_C_E_5  , 
  accuracy_UBCF_C_E_10 , 
  accuracy_UBCF_C_E_15 , 
  accuracy_UBCF_C_E_25 , 
  accuracy_UBCF_C_E_50 , 
  accuracy_UBCF_C_E_100, 
  accuracy_UBCF_C_J_5  , 
  accuracy_UBCF_C_J_10 , 
  accuracy_UBCF_C_J_15 , 
  accuracy_UBCF_C_J_25 , 
  accuracy_UBCF_C_J_50 , 
  accuracy_UBCF_C_J_100, 
  accuracy_UBCF_Z_C_5  , 
  accuracy_UBCF_Z_C_10 , 
  accuracy_UBCF_Z_C_15 , 
  accuracy_UBCF_Z_C_25 , 
  accuracy_UBCF_Z_C_50 , 
  accuracy_UBCF_Z_C_100, 
  accuracy_UBCF_Z_E_5  , 
  accuracy_UBCF_Z_E_10 , 
  accuracy_UBCF_Z_E_15 , 
  accuracy_UBCF_Z_E_25 , 
  accuracy_UBCF_Z_E_50 , 
  accuracy_UBCF_Z_E_100, 
  accuracy_UBCF_Z_J_5  , 
  accuracy_UBCF_Z_J_10 , 
  accuracy_UBCF_Z_J_15 , 
  accuracy_UBCF_Z_J_25 , 
  accuracy_UBCF_Z_J_50 , 
  accuracy_UBCF_Z_J_100,
  accuracy_IBCF_N_C,    
  accuracy_IBCF_C_C,    
  accuracy_IBCF_Z_C,    
  accuracy_IBCF_N_E,    
  accuracy_IBCF_C_E,    
  accuracy_IBCF_Z_E,    
  accuracy_IBCF_N_J,    
  accuracy_IBCF_C_J,    
  accuracy_IBCF_Z_J,    
  accuracy_IBCF_N_C_5,  
  accuracy_IBCF_N_C_10, 
  accuracy_IBCF_N_C_15, 
  accuracy_IBCF_N_C_50, 
  accuracy_IBCF_N_C_100,
  accuracy_IBCF_N_C_alpha_0.1,
  accuracy_IBCF_N_C_alpha_0.25,
  accuracy_IBCF_N_C_alpha_0.75,
  accuracy_IBCF_N_C_alpha_0.9,
  accuracy_Popular_N,
  accuracy_Popular_C,
  accuracy_Popular_Z,
  accuracy_Popular_sentiment_N,
  accuracy_Popular_sentiment_C,
  accuracy_Popular_sentiment_Z
)

eval_ratings_results <- data.frame(eval_ratings_results)
rownames(eval_ratings_results) <- c("UBCF_N_C_5",
                                    "UBCF_N_C_10",
                                    "UBCF_N_C_15",
                                    "UBCF_N_C_25",
                                    "UBCF_N_C_50",
                                    "UBCF_N_C_100",
                                    "UBCF_N_E_5",
                                    "UBCF_N_E_10",
                                    "UBCF_N_E_15",
                                    "UBCF_N_E_25",
                                    "UBCF_N_E_50",
                                    "UBCF_N_E_100",
                                    "UBCF_N_J_5",
                                    "UBCF_N_J_10",
                                    "UBCF_N_J_15",
                                    "UBCF_N_J_25",
                                    "UBCF_N_J_50",
                                    "UBCF_N_J_100",         
                                    "UBCF_C_C_5",
                                    "UBCF_C_C_10",
                                    "UBCF_C_C_15",
                                    "UBCF_C_C_25",
                                    "UBCF_C_C_50",
                                    "UBCF_C_C_100",
                                    "UBCF_C_E_5",
                                    "UBCF_C_E_10",
                                    "UBCF_C_E_15",
                                    "UBCF_C_E_25",
                                    "UBCF_C_E_50",
                                    "UBCF_C_E_100",
                                    "UBCF_C_J_5",
                                    "UBCF_C_J_10",
                                    "UBCF_C_J_15",
                                    "UBCF_C_J_25",
                                    "UBCF_C_J_50",
                                    "UBCF_C_J_100",     
                                    "UBCF_Z_C_5",
                                    "UBCF_Z_C_10",
                                    "UBCF_Z_C_15",
                                    "UBCF_Z_C_25",
                                    "UBCF_Z_C_50",
                                    "UBCF_Z_C_100",
                                    "UBCF_Z_E_5",
                                    "UBCF_Z_E_10",
                                    "UBCF_Z_E_15",
                                    "UBCF_Z_E_25",
                                    "UBCF_Z_E_50",
                                    "UBCF_Z_E_100",
                                    "UBCF_Z_J_5",
                                    "UBCF_Z_J_10",
                                    "UBCF_Z_J_15",
                                    "UBCF_Z_J_25",
                                    "UBCF_Z_J_50",
                                    "UBCF_Z_J_100",
                                    "IBCF_N_C",    
                                    "IBCF_C_C",    
                                    "IBCF_Z_C",    
                                    "IBCF_N_E",    
                                    "IBCF_C_E",    
                                    "IBCF_Z_E",    
                                    "IBCF_N_J",    
                                    "IBCF_C_J",    
                                    "IBCF_Z_J",    
                                    "IBCF_N_C_5",  
                                    "IBCF_N_C_10", 
                                    "IBCF_N_C_15", 
                                    "IBCF_N_C_50", 
                                    "IBCF_N_C_100",
                                    "IBCF_N_C_alpha_0.1",
                                    "IBCF_N_C_alpha_0.25",
                                    "IBCF_N_C_alpha_0.75",
                                    "IBCF_N_C_alpha_0.9",
                                    "p_Popular_N",
                                    "p_Popular_C",
                                    "p_Popular_Z",
                                    "p_Popular_sentiment_N",
                                    "p_Popular_sentiment_C",
                                    "p_Popular_sentiment_Z")
eval_ratings_results <- eval_ratings_results[order(eval_ratings_results$RMSE ),]
eval_ratings_results

#Remove chart junk 
source("remove_chart_junk.R")
myChartAttr <- myChartAttr_fn()

eval_ratings_results$rec_type <- rownames(eval_ratings_results)

#### PLOT - ALL Model Errors ####
eval_ratings_results_long<- gather(eval_ratings_results, Error , Err_Value, RMSE:MAE)

# ggplot(eval_ratings_results_long, aes(fill = Error , x = rec_type, y=Err_Value)) +
#   geom_bar(position="dodge", stat="identity",width = 0.9) +
#   myChartAttr + 
#   labs(x="",y ="Error Rate") +
#   theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
#   scale_fill_manual(values=colorbar)


#### PLOT - IBCF model Errors ####
eval_ratings_results_IBCF <- subset(eval_ratings_results, eval_ratings_results$rec_type %in% c("IBCF_N_C", 
                                                                    "IBCF_C_C",    
                                                                    "IBCF_Z_C",    
                                                                    "IBCF_N_E",    
                                                                    "IBCF_C_E",    
                                                                    "IBCF_Z_E",    
                                                                    "IBCF_N_J",    
                                                                    "IBCF_C_J",    
                                                                    "IBCF_Z_J",    
                                                                    "IBCF_N_C_5",  
                                                                    "IBCF_N_C_10", 
                                                                    "IBCF_N_C_15", 
                                                                    "IBCF_N_C_50", 
                                                                    "IBCF_N_C_100",
                                                                    "IBCF_N_C_alpha_0.1",
                                                                    "IBCF_N_C_alpha_0.25",
                                                                    "IBCF_N_C_alpha_0.75",
                                                                    "IBCF_N_C_alpha_0.9"))

eval_ratings_results_long_IBCF<- gather(eval_ratings_results_IBCF, Error, Err_Value, RMSE:MAE)

ggplot(eval_ratings_results_long_IBCF, aes(fill = Error, x = rec_type, y=Err_Value)) +
  geom_bar(position="dodge", stat="identity",width = 0.8) +
  myChartAttr +
  labs(x="",y ="Error Rate") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
  scale_fill_manual(values=colorbar)

eval_ratings_results_UBCF <- subset(eval_ratings_results, eval_ratings_results$rec_type %in% c("UBCF_N_C_5",
                                                                                               "UBCF_N_C_10",
                                                                                               "UBCF_N_C_15",
                                                                                               "UBCF_N_C_25",
                                                                                               "UBCF_N_C_50",
                                                                                               "UBCF_N_C_100",
                                                                                               "UBCF_N_E_5",
                                                                                               "UBCF_N_E_10",
                                                                                               "UBCF_N_E_15",
                                                                                               "UBCF_N_E_25",
                                                                                               "UBCF_N_E_50",
                                                                                               "UBCF_N_E_100",
                                                                                               "UBCF_N_J_5",
                                                                                               "UBCF_N_J_10",
                                                                                               "UBCF_N_J_15",
                                                                                               "UBCF_N_J_25",
                                                                                               "UBCF_N_J_50",
                                                                                               "UBCF_N_J_100",         
                                                                                               "UBCF_C_C_5",
                                                                                               "UBCF_C_C_10",
                                                                                               "UBCF_C_C_15",
                                                                                               "UBCF_C_C_25",
                                                                                               "UBCF_C_C_50",
                                                                                               "UBCF_C_C_100",
                                                                                               "UBCF_C_E_5",
                                                                                               "UBCF_C_E_10",
                                                                                               "UBCF_C_E_15",
                                                                                               "UBCF_C_E_25",
                                                                                               "UBCF_C_E_50",
                                                                                               "UBCF_C_E_100",
                                                                                               "UBCF_C_J_5",
                                                                                               "UBCF_C_J_10",
                                                                                               "UBCF_C_J_15",
                                                                                               "UBCF_C_J_25",
                                                                                               "UBCF_C_J_50",
                                                                                               "UBCF_C_J_100",     
                                                                                               "UBCF_Z_C_5",
                                                                                               "UBCF_Z_C_10",
                                                                                               "UBCF_Z_C_15",
                                                                                               "UBCF_Z_C_25",
                                                                                               "UBCF_Z_C_50",
                                                                                               "UBCF_Z_C_100",
                                                                                               "UBCF_Z_E_5",
                                                                                               "UBCF_Z_E_10",
                                                                                               "UBCF_Z_E_15",
                                                                                               "UBCF_Z_E_25",
                                                                                               "UBCF_Z_E_50",
                                                                                               "UBCF_Z_E_100",
                                                                                               "UBCF_Z_J_5",
                                                                                               "UBCF_Z_J_10",
                                                                                               "UBCF_Z_J_15",
                                                                                               "UBCF_Z_J_25",
                                                                                               "UBCF_Z_J_50",
                                                                                               "UBCF_Z_J_100"))

eval_ratings_results_long_UBCF<- gather(eval_ratings_results_UBCF, Error, Err_Value, RMSE:MAE)

ggplot(eval_ratings_results_long_UBCF, aes(fill = Error, x = rec_type, y=Err_Value)) +
  geom_bar(position="dodge", stat="identity",width = 0.9) +
  myChartAttr +
  labs(x="",y ="Error Rate") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
  scale_fill_manual(values=colorbar)


#### PLOT - Popular model Errors ####
eval_ratings_results_popular <- subset(eval_ratings_results, eval_ratings_results$rec_type %in% c("p_Popular_N",
                                                                                               "p_Popular_C",
                                                                                               "p_Popular_Z"))

eval_ratings_results_long_popular<- gather(eval_ratings_results_popular, Error, Err_Value, RMSE:MAE)

ggplot(eval_ratings_results_long_popular, aes(fill = Error, x = rec_type, y=Err_Value)) +
  geom_bar(position="dodge", stat="identity",width = 0.4) +
  myChartAttr +
  labs(x="",y ="Error Rate") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.9)) +
  scale_fill_manual(values=colorbar)

#### PLOT - Popular Sentiment model Errors ####
eval_ratings_results_popular <- subset(eval_ratings_results, eval_ratings_results$rec_type %in% c("p_Popular_sentiment_N",
                                                                                                  "p_Popular_sentiment_C",
                                                                                                  "p_Popular_sentiment_Z"))

eval_ratings_results_long_popular<- gather(eval_ratings_results_popular, Error, Err_Value, RMSE:MAE)

ggplot(eval_ratings_results_long_popular, aes(fill = Error, x = rec_type, y=Err_Value)) +
  geom_bar(position="dodge", stat="identity",width = 0.4) +
  myChartAttr +
  labs(x="",y ="Error Rate") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.9)) +
  scale_fill_manual(values=colorbar)

##NOTE: We can also change the way we split trainig/test dataset and compare evaluation of
##      different values of k for the cross-validation method with 2, 4, 6,... k-folds


