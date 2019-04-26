# #Train the Hybrid model

source("Hybrid_train_survey.R")
Hybrid_train_survey(UBCF_model_survey, IBCF_model_survey, Popular_model, Popular_sentiment_model, 0.5, 0, 0.25, 0.25)
print("Hybrid training Done")
Hybrid_model_survey <- readRDS("./hybrid_model_survey.rds")
gc()


