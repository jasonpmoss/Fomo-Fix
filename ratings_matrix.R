#Author: Jason

library(recommenderlab)
library(bigrquery)
library(data.table) #use this library to change row and column names below and handle large data
#----------------------------------------Data import and creation-----------------------------------------------#
# # we need to define data input requirements
# project <- "fomofix-217307" #  project ID 
# sql <- "select *
# from `fomofix-217307.fomofixds.lv_testset`;"
# output <- bq_project_query(project, sql, destination_table = NULL, quiet = NA)
# 
# reviews_full <- bq_table_download(output)
# reviews_full2<-reviews_full[1:100000,]

#---------------this functions get the list of business ids from the predictor and generates the restaurant dataframe----#

ratings_matrix<-function(users, businesses, ratings){
  
  users <-unique(users) #create list of user_ids
  businesses <- unique(businesses) #create list of business_ids
  users<- na.omit(users) #clean out NA records (if there are any)
  businesses<- na.omit(businesses)
  
  ratingmat = dcast(reviews_full2, user_id~business_id, value.var = "stars")
  ratingmat = as.matrix(ratingmat[,-1])
  ratingmat = as(ratingmat, "realRatingMatrix")
  return(ratingmat)
}
#----------------------------------------Data import and creation-----------------------------------------------#

# #testing the function
# input <- c(reviews_full2$user_id,reviews_full2$business_id, reviews_full2$stars) #this is a smaller data frame
# #input <- c(reviews_full$user_id,reviews_full$business_id, reviews_full$stars)
# x<-ratings_matrix(reviews_full2$user_id,reviews_full2$business_id, reviews_full2$stars) 
# x

#------------------------------------------------------------------------------------------------------#