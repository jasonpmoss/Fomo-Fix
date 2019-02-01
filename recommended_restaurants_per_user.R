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

  if(!is.na(user_position)){  
    #returns the names of the predicted restaurants
    predictions <- predict(recommender_model,user_position, data = ratings_dataset,n=n_recommendations)
  
    #convert the topNList object into a List
    predictions <- as(predictions, "list")
    
    #get only the user recommendations
    predictions <- predictions[[user]]
  }else {
    predictions <- "error"
    warning("FOMOFIX Warning in predict_per_user function: the user passed to the function is not present in the dataset passed. The function will return the string error. Make sure you use an user available in the test dataset")
  }
  
  return(predictions)
}

#THE FOLLOWING CODE HAS NOT BEEN PROPERLY TESTED. WE NEED TO CHECK IF IT GETS THE TOPN "N" RESTAURANTS
predict_ratings_per_user <- function(recommender_model, ratings_dataset, user){
  #get the index of the user in the ratings dataset
  user_position <- match(user,rownames(ratings_dataset@data))
  
  if(!is.na(user_position)){ 
    #returns the names of the predicted restaurants
    predictions <- predict(recommender_model,user_position, data = ratings_dataset, type = "ratings")
    
    #convert the topNList object into a List
    #predictions_list <- as(predictions, "list")
    
    #returns the list of restaurants in a "cleaner" way
    #return(as(predictions, "matrix")[,1:10])
  }else {
    predictions <- "error"
    warning("FOMOFIX Warning in predict_per_user function: the user passed to the function is not present in the dataset passed. The function will return the string error. Make sure you use an user available in the test dataset")
    
  }

  return(predictions)
}

predictions_as_dataframe <- function(predicted_restaurants, predicted_ratings, test_dataset){
  predicted_restaurants_index <- match(predicted_restaurants,colnames(test_dataset@data))

  #filter predicted ratings by the indexes to get only those that has been recommended
  predicted_restaurant_names <- predicted_ratings@data@Dimnames[[2]][predicted_restaurants_index]
  
  #create a dataframe with the recommended restaurants and their predicted ratings
  predicted_restaurant_with_rating <- data.frame(as.table(setNames(predicted_ratings@data@x, predicted_restaurant_names)))
  colnames(predicted_restaurant_with_rating) <- c("Restaurant", "Predicted_Rating")
  return (predicted_restaurant_with_rating)
}

#------- test ---------------------------

# matrix <- recc_predicted #where recc_predicted is the output of the function "predict" of a recommender model
# user <- "DTo6vHKzyx8RmMrVbTgowg"
# n <- 2
# top_n_recommended_restaurants_per_user(matrix, user, n)
# all_recommended_restaurants_per_user(matrix, user)

# predictions_per_user(UBCF_model, ratings_mat, "nBFGk7PsSqghFpojwX4WOw", 5)