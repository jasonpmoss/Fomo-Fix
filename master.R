#Author: Jason
#test comment

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
#user<-ratings$small$user_id[17]
user<-"_91FxFZYTaUGVIEnQhB5cw"
n_recommended<-3
#return user rating table:

#----------------------------------------Main code-----------------------------------------------#

source("get_data.R") # has to be in the same working directory or specify full path
ratings<- get_dataframe(sql)
#ratings$full #this is the large dataframe
#ratings$small #this is a smaller dataframe to deal with challenges from large dataframes
ratings %<>% dplyr::sample_n(number_of_records)

source("ratings_matrix.R")
ratings_mat<-ratings_matrix(ratings$user_id, ratings$business_id, ratings$stars)
#user_table<-ratings[ratings$user_id == user, ]
#user_locations<-which(grepl(user, ratings$user_id))
source("ratings_matrix.R")
user_matrix<-ratings_matrix(user_table$user_id, user_table$business_id, user_table$stars)


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

