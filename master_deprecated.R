#Author: Jason
# Start the clock!
ptm <- proc.time()
#----------------------------------------Attach packages--------------------------------------
source("libraries_required.R")

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

#Define an user to test the results of the models
user<-"Khmnj9gYXhIbl1dvoWHgCQ" #choose a random user
#user<- "kTny8RFBPj9du2aIRb8V0A"
#user<-recc_data_test@data@Dimnames[[1]][17] #choose a random user from the training set

#----------------------------------------Create ratings matrix-----------------------------------------------
# source("get_data.R") # has to be in the same working directory or specify full path
# ratings<- get_dataframe(sql)
# ratings %<>% dplyr::sample_n(number_of_records) #shrink dataframe so that it doesn't take as long to train and run code
# save(ratings,file="ratings.Rda") #create saved dataset so we can re-use it on the models that we've saved.

#Create the ratings matrix
load("ratings.Rda") #load presaved dataset with dataframe name "ratings"
source("ratings_matrix.R")
#ratings_mat<-ratings_matrix(ratings$user_id, ratings$business_id, ratings$stars)
#creating the rating matrix from a sparse matrix just in case it optimize computation time afterwards
ratings_mat<-ratings_matrix_sparse(ratings$user_id, ratings$business_id, ratings$stars)

#In case we normalize the ratings matrix:
ratings_mat_normalized <- normalize(ratings_mat)

# user_table<-ratings[ratings$user_id == user, ]
# source("ratings_matrix.R")
# user_matrix<-ratings_matrix(user_table$user_id, user_table$business_id, user_table$stars)
# user_locations<-which(grepl(user, ratings$user_id)) #show the location of users in data frame

#-----------------------------------------Train models---------------------------------------------
# Two ways to split data: simple split or cross validation with k-folds.
# While splitting data, an evaluation scheme is created to be used afterwards
source("split_train_test_data.R") 
eval_sets <- split_train_test_data(ratings_mat,0.8)
eval_sets <- split_train_test_data_crossval(ratings_mat,4)

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
#----------------------------------------Run predictions-------------------------------------------

#Recommend Restaurnats
source("IBCF_predict.R")
IBCF_recommended_restaurants<-IBCF_predict_restaurants(recc_data_test, n_recommended)

source("UBCF_predict.R")
UBCF_recommended_restaurants<-UBCF_predict_restaurants(recc_data_test, n_recommended)

source("Popular_predict.R")
Popular_recommended_restaurants<-Popular_predict_restaurants(ratings_mat, n_recommended)

source("Hybrid_predict.R")
Hybrid_recommended_restaurants<-Hybrid_predict_restaurants(ratings_mat)


#Predict Ratings
source("IBCF_predict.R")
IBCF_predict_ratings<-IBCF_predict_ratings(recc_data_test)

source("UBCF_predict.R")
UBCF_predict_ratings<-UBCF_predict_ratings(recc_data_test)

source("Popular_predict.R")
Popular_predict_ratings<-Popular_predict_ratings(ratings_mat)

source("Hybrid_predict.R")
Hybrid_predict_ratings<-Hybrid_predict_ratings(ratings_mat)

#-------------------------Doing recommendations for a specific user-------------

#get  predicted ratings from top n restaurants. n can be passed as parameter, otherwise its value by default is 100
source("recommended_restaurants_per_user.R")
predicted_ratings<-predict_ratings_per_user(Hybrid_model, ratings_mat, user, 20)
predictions<-predicted_ratings$Restaurant #to see only the restaurants name 
user_restaurants_visited<-(subset(ratings,user_id==user))[,1]
predictions %<>% as.data.frame()

#------------------------Map recommendations--------------------------------------------
source("map_recommendations.R")
res_plot(get_restaurants(predictions)) #important to use get_restaurants functions in the res_plot function call

#-----------------------show restaurants visited by user---------------------------------------
# table_for_user<-c(user_restaurants_visited, predictions)
# table_for_user %<>% as.data.frame()
# names(table_for_user)<-c("restaurants_visited", "predictions")
# table_for_user
ptm <- proc.time() - ptm
ptm

save.image(file='variable_environment_20190202.RData')

#------------------------Models Evaluation--------------------------------------------
#the evaluation scheme is already created and stored in the variable eval_sets

