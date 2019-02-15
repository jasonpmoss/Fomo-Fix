#Author: Jason

library(recommenderlab)
library(bigrquery)
library(data.table) #use this library to change row and column names below and handle large data

#---------------this functions get the list of business ids from the predictor and generates the restaurant dataframe----#

ratings_matrix<-function(users, businesses, stars){
  reviews<-data.frame(users,businesses,stars)
  ratingmat = dcast(reviews, users~businesses, value.var = "stars")
  row.names(ratingmat) <- ratingmat$users
  ratingmat = as.matrix(ratingmat[,-1])
  ratingmat = as(ratingmat, "realRatingMatrix")
  return(ratingmat)
}


ratings_matrix_sparse<-function(users, businesses, stars){
  reviews<-data.frame(users,businesses,stars)
  ratingmat = dcast(reviews, users~businesses, value.var = "stars")
  row.names(ratingmat) <- ratingmat$users
  ratingmat = as.matrix(ratingmat[,-1])
  #substitude NAs by zeros
  ratingmat[is.na(ratingmat)] <- 0
  #convert it into sparseMatrix
  ratingmat <- as(ratingmat, "sparseMatrix")
  #create a new reaRatingMatrix using the sparse matrix
  ratingmat_sparse = new("realRatingMatrix", data = ratingmat)
  #remove the ratingmat matrix to optimize memory usage
  rm(ratingmat)
  return(ratingmat_sparse)
}

filter_relevant_data<-function(ratingmat){
  #Implement here the function depending on what needs to be filtered
  return(ratingmat)
}
#----------------------------------------testing the function-----------------------------------------------#

#ratings_matrix(ratings$user_id, ratings$business_id, ratings$stars)

#------------------------------------------------------------------------------------------------------#