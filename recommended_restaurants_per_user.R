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

#This function returns a dataframe with the top n restaurants and their ratings. The number of recommendations
#by default is 100, but if indicated when calling the function it can be adapted
predict_ratings_per_user <- function(recommender_model, ratings_dataset, user, n_recommend=100){
  #get the index of the user in the ratings dataset
  user_position <- match(user,rownames(ratings_dataset@data))
  
  ##check if the user is present in the dataset
  if(!is.na(user_position)){ 
    #returns the predicted restaurants and their ratings
    predictions <- predict(recommender_model,user_position, data = ratings_dataset, type = "ratings")
    
    #check if the model didn´t predict any restaurant, and in that case it raises a warning
    if(rowCounts(predictions) == 0){
      warning("FOMOFIX Warning in predict_ratings_per_user function: The model did not recommend any restaurant for this user")
    }
    
    #reformat the realRatingMatrix into a dataframe with two columns: restaraunt and predicted_rating
    predictions <- as(predictions,"data.frame")
    
    #remove user column
    predictions <- predictions[,-1]
    
    #rename columns
    colnames(predictions) <- c("Restaurant","Predicted_Rating")
    
    #sort dataframe by Predicted_Rating in descendent order
    predictions <- predictions[order(predictions$Predicted_Rating, decreasing = TRUE),]
    
    #get only the top "n_recommend" results
    predictions <- head(predictions,n_recommend)
    
  }else {
    predictions <- "Error: the user passed to the function is not present in the dataset"
    warning("FOMOFIX Warning in predict_per_user function: the user passed to the function is not present in the dataset passed. The function will return the string error. Make sure you use an user available in the test dataset")
  }

  return(predictions)
}


#------- test ---------------------------

# matrix <- recc_predicted #where recc_predicted is the output of the function "predict" of a recommender model
# user <- "DTo6vHKzyx8RmMrVbTgowg"
# n <- 2
# top_n_recommended_restaurants_per_user(matrix, user, n)
# all_recommended_restaurants_per_user(matrix, user)

# predictions_per_user(UBCF_model, ratings_mat, "nBFGk7PsSqghFpojwX4WOw", 5)