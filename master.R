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

#user<-"_ijx1PqANQVFLGNWCibdig" #this will always need to be updated because this user might not be in the sample
n_recommended<-3
#which(grepl("_ijx1PqANQVFLGNWCibdig", ratings$user_id))
model_training_required <- FALSE #set this to TRUE to train new models

#----------------------------------------Create ratings matrix-----------------------------------------------
# source("get_data.R") # has to be in the same working directory or specify full path
# ratings<- get_dataframe(sql)
# ratings %<>% dplyr::sample_n(number_of_records) #shrink dataframe so that it doesn't take as long to train and run code
# save(ratings,file="ratings.Rda") #create saved dataset so we can re-use it on the models that we've saved.

load("ratings.Rda") #load presaved dataset with dataframe name "ratings"
user<-"_7A9uRTB8MEUGrloUdo8Fw" #ratings$user_id[17] #find a random user at location 17
source("ratings_matrix.R")
ratings_mat<-ratings_matrix(ratings$user_id, ratings$business_id, ratings$stars)
user_table<-ratings[ratings$user_id == user, ]
source("ratings_matrix.R")
user_matrix<-ratings_matrix(user_table$user_id, user_table$business_id, user_table$stars)
#user_locations<-which(grepl(user, ratings$user_id))

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
}
#----------------------------------------run predictions-------------------------------------------
source("IBCF_predict.R")
IBCF_predict<-IBCF_predict(recc_data_test, n_recommended)

source("UBCF_predict.R")
UBCF_predict<-UBCF_predict(recc_data_test, n_recommended)

source("Popular_predict.R")
Popular_predict<-Popular_train(ratings_mat, n_recommended)

source("Hybrid_predict.R")
Hybrid_predict_rec_list<-Hybrid_predict(ratings_mat)

source("recommended_restaurants_per_user.R")
top_n_recommended_restaurants_per_user(UBCF_predict,user,n_recommended)

# Convert recommendations to lists (hopefully, this will ease extraction of user specific recommendations)
IBCF_list<-as(IBCF_predict, "list")
UBCF_list<-as(UBCF_predict, "list")
Popular_list<-as(Popular_predict, "list")

# the following code is using dummy data to get an ALTERNATE hybrid recommender working

IBCF_top_n <- IBCF_list[[2]] # dummy predictions
UBCF_top_n <- UBCF_list[[1]] # dummy predictions
Popular_top_n <- Popular_list[[1]] # dummy predictions

#-----------------------this hybrid recommender uses equal weightings with no ability to change weightings--------------------
source("Hybrid_predict.R")
Hybrid_predict <- Hybrid_predict_unweighted(IBCF_top_n, UBCF_top_n, Popular_top_n)

#------------------------map recommendations--------------------------------------------
source("transform_predictions_to_matrix.R")
res_df<-recommendations_for_user(user,Hybrid_predict_rec_list)
source("map_recommendations.R")
res_plot(get_restaurants(res_df)) #Hybrid_predict_unweighted is a dataframe of business_ids

save.image(file='variable_environment_20190118.RData')


#-------------------------doing recommendations for a specific user-------------
source("recommended_restaurants_per_user.R")
#source("UBCF_train.R")
#UBCF_train(ratings_mat)
predictions<-predict_per_user(UBCF_model, recc_data_test, user, 10)
user_restaurants_visits<-(subset(ratings,user_id==user))[,1]

table_for_user<-c(predictions, user_restaurants_visits)
