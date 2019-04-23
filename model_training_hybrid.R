# #Train the Hybrid model

source("Hybrid_train.R")
Hybrid_train(UBCF_C_E_100, IBCF_N_E, Popular_C, Popular_sentiment_model, 0.3, 0.3, 0.3, 0.1)
print("Hybrid training Done")
Hybrid_model <- readRDS("./hybrid_model.rds")
gc()


