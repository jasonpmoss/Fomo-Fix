#Author: Jason
#----------------------------------------Attach packages--------------------------------------
library(plyr)
library(dplyr)
library(magrittr)

#----------------------------------------Inputs-----------------------------------------------
# sql <- "SELECT
#   *
# FROM
#   `fomofix-217307.fomofixds.lv_testset`
# WHERE
#   stars>0;"

number_of_records<-10000
#user to be recommended for:

n_recommended<-3
#which(grepl("_ijx1PqANQVFLGNWCibdig", ratings$user_id))
model_training_required <- TRUE #set this to TRUE to train new models

#----------------------------------------Create ratings matrix-----------------------------------------------
# source("get_data.R") # has to be in the same working directory or specify full path
# ratings<- get_dataframe(sql)
# ratings %<>% dplyr::sample_n(number_of_records) #shrink dataframe so that it doesn't take as long to train and run code
# save(ratings,file="ratings.Rda") #create saved dataset so we can re-use it on the models that we've saved.

load("ratings.Rda") #load presaved dataset with dataframe name "ratings"
#user<-"L7Ti9kJxsI3_VZ7_4Nk7tQ" #choose a random user
user<- "kTny8RFBPj9du2aIRb8V0A"
source("ratings_matrix.R")
ratings_mat<-ratings_matrix(ratings$user_id, ratings$business_id, ratings$stars)
user_table<-ratings[ratings$user_id == user, ]
source("ratings_matrix.R")
user_matrix<-ratings_matrix(user_table$user_id, user_table$business_id, user_table$stars)
#user_locations<-which(grepl(user, ratings$user_id)) #show the location of users in data frame

#-----------------------------------------train models---------------------------------------------
# these two lines are outside the if statement because we currently use the test set to
# run predictions
source("split_train_test_data.R") 
split_train_test_data(ratings_mat,0.8)

if (model_training_required == TRUE){
  source("IBCF_train.R")
  IBCF_train(ratings_mat)
  
  source("UBCF_train.R")
  UBCF_train(ratings_mat)
  
  source("Popular_train.R")
  Popular_train(ratings_mat)
  
  IBCF_weight<-0.45
  UBCF_weight<-0.45
  Popular_weight<-0.1
  
  UBCF_model <- readRDS("./UBCF_model.rds")
  IBCF_model <- readRDS("./IBCF_model.rds")
  Popular_model <- readRDS("./Popular_model.rds")
  
  source("Hybrid_train.R")
  Hybrid_train <- Hybrid_train(UBCF_model, IBCF_model, Popular_model, UBCF_weight, IBCF_weight, Popular_weight)
  Hybrid_model <- readRDS("./Hybrid_model.rds")
}
#----------------------------------------run predictions-------------------------------------------
source("IBCF_predict.R")
IBCF_predict<-IBCF_predict(recc_data_test, n_recommended)

source("UBCF_predict.R")
UBCF_predict<-UBCF_predict(recc_data_test, n_recommended)

source("Popular_predict.R")
Popular_predict<-Popular_predict(ratings_mat, n_recommended)

source("Hybrid_predict.R")
Hybrid_predict<-Hybrid_predict(ratings_mat)

#-------------------------doing recommendations for a specific user-------------
source("recommended_restaurants_per_user.R")

#get  predicted ratings from top n restaurants. n can be passed as parameter, otherwise its value by default is 100
predicted_ratings<-predict_ratings_per_user(UBCF_model, recc_data_test, user, 10)
predicted_ratings
# predicted_ratings$Restaurant to see only the restaurants name 

user_restaurants_visited<-(subset(ratings,user_id==user))[,1]
predictions %<>% as.data.frame()
#------------------------map recommendations--------------------------------------------
source("map_recommendations.R")
res_plot(get_restaurants(predictions)) #Hybrid_predict_unweighted is a dataframe of business_ids
table_for_user<-c(user_restaurants_visited, predictions)
table_for_user %<>% as.data.frame()
names(table_for_user)<-c("restaurants_visited", "predictions")
table_for_user
save.image(file='variable_environment_20190126.RData')
