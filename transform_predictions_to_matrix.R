library(dplyr) 
#add the restaurants ids
recc_list <- sapply(IBCF_predict@items, function(x){
  colnames(ratings_mat)[x]
})


#We store the recommendations into a matrix instead of a list, and we add "NA" to the missing values:
recc_matrix <- ldply(recc_list, rbind)

#We retrieve only those users having at least one recommendation (first recommended business different than "NA" --second column of the matrix != NA--)
recc_matrix_not_empty <- recc_matrix[!is.na(recc_matrix[2]),]
head(recc_matrix_not_empty)


#To access to the recommendations for a given user, we create the following function:
recommendations_for_user <- function(u, rec_mat){
  result <- rec_mat[rec_mat$.id==u,-1]
  result <- result[!is.na(result)]
  result
}

#For example, the recommendations for the following two users
print("Recommendations for user 0FMte0z-repSVWSJ_BaQTg:")
recommendations_for_user("0FMte0z-repSVWSJ_BaQTg", recc_matrix_not_empty)
print("Recommendations foruser 3nDUQBjKyVor5wV0reJChg:")
recommendations_for_user("3nDUQBjKyVor5wV0reJChg", recc_matrix_not_empty)

