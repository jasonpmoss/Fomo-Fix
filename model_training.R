# Start the clock!
ptm <- proc.time()

#Train the IBCF model
source("IBCF_train.R")
IBCF_train(recc_data_train)
print("IBCF training Done")
IBCF_model <- readRDS("./IBCF_model.rds")
gc()

#Train the UBCF model
source("UBCF_train.R")
UBCF_train(recc_data_train)
print("UBCF training Done")
UBCF_model <- readRDS("./UBCF_model.rds")
gc()

#Train the Popular model
source("Popular_train.R")
Popular_train(recc_data_train)
print("Popular training done")
Popular_model <- readRDS("./Popular_model.rds")
gc()

#Train the Popular sentiment model
source("Popular_sentiment_train.R")
Popular_sentiment_train(recc_data_train_sentiment)
print("Popular sentiment training done")
Popular_sentiment_model <- readRDS("./Popular_sentiment_model.rds")


#Train the Hybrid model
source("Hybrid_train.R")
#set up the weights of each model into the Hybrid model:
IBCF_weight<-0.45
UBCF_weight<-0.45
Popular_weight<-0.05
Popular_sentiment_weight <-0.05
Hybrid_train(UBCF_model, IBCF_model, Popular_model, Popular_sentiment_model, UBCF_weight,IBCF_weight, Popular_weight, Popular_sentiment_weight)
print("Hybrid training done")
Hybrid_model<-readRDS("./Hybrid_model.rds")
gc()

time_to_run_code<-proc.time() - ptm
time_to_run_code
