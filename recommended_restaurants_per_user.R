#Author: Rafa

#Description: this function returns all predicted items for a given user given the prediction for several users
#INPUT: a "topNList" object containing predictions, the name of an user as a string of characters and an integer indicating the number of recommendations to return
#OUTPUT: the list of string of characters containing the names of the restaurants recommended for that particula user
recommendations_from_topNlist <- function(topNlist_predictions, user){
  #extract the list of index of the recommended restaurants for the user
  restaurants_index <- matrix@items[[user]]
  
  #returns the names of thoese restaurants
  return(matrix@itemLabels[restaurants_index])
  
}


#Description: this function returns the top "n" predicted items for a given user given the prediction for several users
#INPUT: a "topNList" object containing predictions and the name of an user as a string of characters
#OUTPUT: the list of string of characters containing the names of the restaurants recommended for that particula user
top_n_recommendations_from_topNlist <- function(topNlist_predictions, user, num_recommendations){
  #extract the list of index of the recommended restaurants for the user
  restaurants_index <- matrix@items[[user]][1:num_recommendations]
  
  #returns the names of thoese restaurants
  return(matrix@itemLabels[restaurants_index])
  
}

#Description: this function predicts restaurants for an user given a recommender model. 
#It computes the recommendation on the fly only for that user, it does not require to predict for the whole test data
#INPUT: a recommender model object, the realRatingMatrix object containing ratings (the test dataset), the user name as a string and the number of recommendations to get
#OUTPUT: the list of string of characters containing the names of the restaurants recommended for that particula user
predict_per_user <- function(recommender_model, ratings_dataset, user, n_recommendations){
  #get the index of the user in the ratings dataset
  user_position <- match(user,rownames(ratings_dataset@data))
  
  #returns the names of the predicted restaurants
  predictions <- predict(recommender_model,user_position, data = ratings_dataset,n=n_recommendations)
  
  #convert the topNList object into a List
  predictions_list <- as(predictions, "list")
  
  #returns the list of restaurants in a "cleaner" way
  return(predictions_list[[user]])
}
#------- test ---------------------------

# matrix <- recc_predicted #where recc_predicted is the output of the function "predict" of a recommender model
# user <- "DTo6vHKzyx8RmMrVbTgowg"
# n <- 2
# top_n_recommended_restaurants_per_user(matrix, user, n)
# all_recommended_restaurants_per_user(matrix, user)

# predictions_per_user(UBCF_model, ratings_mat, "nBFGk7PsSqghFpojwX4WOw", 5)