# Converting the ratings_mat matrix into dataframe 
actual_rating_df <- as(ratings_mat, "data.frame")

# converting predicted rating matrix into dataframe
pred_rating_df <- as(Hybrid_predict_ratings, "data.frame")



# merge the ratings by user and business combination
### Left Join
merge_data<- merge(actual_rating_df, pred_rating_df, by=c("user","item"), all.x=TRUE)
names(merge_data) <- c("user", "item", "actual", "Predicted")
### Right Join
#merge_data<- merge(actual_rating_df, pred_rating_df, by=c("user","item"), all.y=TRUE)


### FULL Join
#merge_data<- merge(actual_rating_df, pred_rating_df, by=c("user","item"), all=TRUE)

#Remove colum 1 and 2 from data set 
#merge_data<-subset(merge_data, select = 3:4)

#Rename the columns
##names(merge_data) <- c("visited", "visit_pred")

View(merge_data)
