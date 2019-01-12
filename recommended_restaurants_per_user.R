#Author: Rafa

#Description: this function resturns all predicted items for a given user
#INPUT: a "topNList" object containing predictions, the name of an user as a string of characters and an integer indicating the number of recommendations to return
#OUTPUT: the list of string of characters containing the names of the restaurants recommended for that particula user
all_recommended_restaurants_per_user <- function(matrix, user){
  #extract the list of index of the recommended restaurants for the user
  restaurants_index <- matrix@items[[user]]
  
  #returns the names of thoese restaurants
  return(matrix@itemLabels[restaurants_index])
  
}


#Description: this function resturns the top "n" predicted items for a given user
#INPUT: a "topNList" object containing predictions and the name of an user as a string of characters
#OUTPUT: the list of string of characters containing the names of the restaurants recommended for that particula user
top_n_recommended_restaurants_per_user <- function(matrix, user, num_recommendations){
  #extract the list of index of the recommended restaurants for the user
  restaurants_index <- matrix@items[[user]][1:num_recommendations]
  
  #returns the names of thoese restaurants
  return(matrix@itemLabels[restaurants_index])
  
}
#------- test ---------------------------

matrix <- recc_predicted #where recc_predicted is the output of the function "predict" of a recommender model
user <- "DTo6vHKzyx8RmMrVbTgowg"
n <- 2
top_n_recommended_restaurants_per_user(matrix, user, n)
all_recommended_restaurants_per_user(matrix, user)

