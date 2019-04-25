# Start the clock!
ptm <- proc.time()

#Train the IBCF model
source("IBCF_train_survey.R")
IBCF_train_survey(recc_data_train_survey)
print("IBCF training Done")
IBCF_model_survey <- readRDS("./IBCF_model_survey.rds")
gc()

#Train the UBCF model
source("UBCF_train_survey.R")
UBCF_train_survey(recc_data_train_survey)
print("UBCF training Done")
UBCF_model_survey <- readRDS("./UBCF_model_survey.rds")
gc()

#Train the Popular model
source("Popular_train.R")
Popular_train(ratings_mat)
print("Popular training done")
Popular_model <- readRDS("./Popular_model.rds")
gc()

#Train the Popular sentiment model
source("Popular_sentiment_train.R")
Popular_sentiment_train(rating_mat_popular_sentiment)
print("Popular sentiment training done")
Popular_sentiment_model <- readRDS("./Popular_sentiment_model.rds")


# #Train the Hybrid model
# source("Hybrid_train.R")
# #set up the weights of each model into the Hybrid model:
# IBCF_weight<-0.45
# UBCF_weight<-0.45
# Popular_weight<-0.05
# Popular_sentiment_weight <-0.05
# Hybrid_train(UBCF_model, IBCF_model, Popular_model, Popular_sentiment_model, UBCF_weight,IBCF_weight, Popular_weight, Popular_sentiment_weight)
# print("Hybrid training done")
# Hybrid_model<-readRDS("./Hybrid_model.rds")
# gc()

time_to_run_code<-proc.time() - ptm
time_to_run_code
