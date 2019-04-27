# #Train the Hybrid model

source("Hybrid_train.R")
Hybrid_train(UBCF_N_J_100, IBCF_N_C_100, Popular_N, Popular_sentiment_N, 0.5, 0, 0.25, 0.25)
print("Hybrid training Done")
Hybrid_model <- readRDS("./hybrid_model.rds")
gc()


