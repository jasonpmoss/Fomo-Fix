#Author: Jasonpmoss

library(dplyr)
library(magrittr)

#----------------------------------------Inputs-----------------------------------------------#
sql <- "SELECT
  *
FROM
  `fomofix-217307.fomofixds.lv_testset`
WHERE
  stars>0;"

number_of_records<-10000
#user to be recommended for:
#user<-ratings$user_id[17] #find a random user at location 17
user<-"_ijx1PqANQVFLGNWCibdig" #this will always need to be updated because this user might not be in the sample
n_recommended<-3
#which(grepl("_ijx1PqANQVFLGNWCibdig", ratings$user_id))

#----------------------------------------Main code-----------------------------------------------#

source("get_data.R") # has to be in the same working directory or specify full path
ratings<- get_dataframe(sql)
ratings %<>% dplyr::sample_n(number_of_records) #shrink dataframe so that it doesn't take as long to train and run code

source("ratings_matrix.R")
ratings_mat<-ratings_matrix(ratings$user_id, ratings$business_id, ratings$stars)
#user_table<-ratings[ratings$user_id == user, ]
#user_locations<-which(grepl(user, ratings$user_id))

#train models:

source("split_train_test_data.R")
split_train_test_data(ratings_mat,0.8)
source("IBCF_train.R")
IBCF_train(ratings_mat)

source("UBCF_train.R")
UBCF_train(ratings_mat)

#run predictions:

source("IBCF_predict.R")
IBCF_predict<-IBCF_predict(recc_data_test, n_recommended)

source("UBCF_predict.R")
UBCF_predict<-UBCF_predict(recc_data_test, n_recommended)

source("Popular_predict.R")
Popular_predict<-Popular_train(ratings_mat)

source("recommended_restaurants_per_user.R")
top_n_recommended_restaurants_per_user(UBCF_predict,user,n_recommended)

## Jason, this rocks

