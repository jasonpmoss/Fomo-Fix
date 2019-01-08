#Author: Jason

library(recommenderlab)
library(bigrquery)
library(data.table) #use this library to change row and column names below and handle large data

#---------------this functions get the list of business ids from the predictor and generates the restaurant dataframe----#

ratings_matrix<-function(users, businesses, stars){
  reviews<-data.frame(users,businesses,stars)
  ratingmat = dcast(reviews, users~businesses, value.var = "stars")
  ratingmat = as.matrix(ratingmat[,-1])
  ratingmat = as(ratingmat, "realRatingMatrix")
  return(ratingmat)
}
#----------------------------------------testing the function-----------------------------------------------#

#ratings_matrix(ratings$user_id, ratings$business_id, ratings$stars)

#------------------------------------------------------------------------------------------------------#