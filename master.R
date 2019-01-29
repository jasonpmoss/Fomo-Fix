#Author: Jason
# Start the clock!
ptm <- proc.time()
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
user<-"JhWKw3FTZoRZ9riDd020LQ" #choose a random user
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
  source("model_training.R")
}
#----------------------------------------run predictions-------------------------------------------
source("predictions_on_test_data.R")

#-------------------------doing recommendations for a specific user-------------
source("recommended_restaurants_per_user.R")
#get predicted list of top N restaunrants
predicted_restaurants<-predict_per_user(Hybrid_model, recc_data_test, user, 10)
predicted_restaurants

#------the following code is just an experiment, when refined, it has to be encapsulated into a function
#------ for the sake of clarity
#get the indexes of those restaurants in the dataset
predicted_restaurants_index <- match(predicted_restaurants,colnames(recc_data_test@data))
predicted_restaurants_index

#get  predicted ratings from top N restaurants
predicted_ratings<-predict_ratings_per_user(Hybrid_model, recc_data_test, user)

#filter predicted ratings by the indexes to get only those that has been recommended
predicted_ratings@data@x[predicted_restaurants_index]

#create a dataframe with the recommended restaurants and their predicted ratings
predicted_restaurant_with_rating <- data.frame(as.table(setNames(predicted_ratings@data@x[predictions_index], predictions)))
colnames(predicted_restaurant_with_rating) <- c("Restaurant", "Predicted_Rating")
predicted_restaurant_with_rating
#----------------- till here is just experimenta code.
#NOTE: the code above seems to work for Popular and Hybrid, as their predict function return
#the rating values when using the argument type="ratings". IBCF and UBCF return only NAs
#This should happend for the restaurant they already rated, but not for new ones.... need to investigate this

user_restaurants_visited<-(subset(ratings,user_id==user))[,1]
predictions %<>% as.data.frame()
#------------------------map recommendations--------------------------------------------
source("map_recommendations.R")
res_plot(get_restaurants(predictions)) #Hybrid_predict_unweighted is a dataframe of business_ids
table_for_user<-c(user_restaurants_visited, predictions)
table_for_user %<>% as.data.frame()
names(table_for_user)<-c("restaurants_visited", "predictions")
table_for_user
# Stop the clock
time_to_run_code<-proc.time() - ptm
time_to_run_code
save.image(file='variable_environment_20190126.RData')
