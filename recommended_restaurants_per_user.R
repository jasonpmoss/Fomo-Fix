#Author: Rafa

#Description: this function allows filtering a list of predicted items by the name of the user for which the recommendation is done
#INPUT: a "topNList" object containing predictions and the name of an user as a string of characters
#OUTPUT: the list of string of characters containing the names of the restaurants recommended for that particula user

index_list <- function(matrix, user){
  #extract the list of index of the recommended restaurants for the user
  restaurants_index <- matrix@items[[user]]
  
  #returns the names of thoese restaurants
  return(matrix@itemLabels[restaurants_index])
  
}

#------- test ---------------------------

matrix <- recc_predicted #where recc_predicted is the output of the function "predict" of a recommender model
user <- "DTo6vHKzyx8RmMrVbTgowg"
index_list(matrix, user)
