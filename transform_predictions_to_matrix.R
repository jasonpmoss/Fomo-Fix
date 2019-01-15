library(dplyr) 
#add the restaurants ids

recc_list <- sapply(Hybrid_predict_rec_list@items, function(x){
  colnames(ratings_mat)[x]
})

#We store the recommendations into a matrix instead of a list, and we add "NA" to the missing values:
recc_matrix <- plyr::ldply(recc_list, rbind)

#We retrieve only those users having at least one recommendation (first recommended business different than "NA" --second column of the matrix != NA--)
recc_matrix_not_empty <- recc_matrix[!is.na(recc_matrix[1]),]
head(recc_matrix_not_empty)

#To access to the recommendations for a given user, we create the following function:
recommendations_for_user <- function(u, rec_mat){
  result <- rec_mat[rec_mat$.id==u,-1]
  result <- result[!is.na(result)]
  return(as.data.frame(result))
}

#For example, the recommendations for the following two users
print(paste("Recommendations for user",user,":"))
recommendations_for_user(user, recc_matrix_not_empty)