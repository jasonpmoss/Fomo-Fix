View(getData(eval_sets_sentiment, "known"))
View(getData(eval_sets_sentiment, "unknown"))
View(getData(eval_sets_sentiment, "train"))


ratings_test<- ratings #ratings[c(1:2,40,100,3005),]
#ratings_test<-rbind(ratings_test,c(ratings_test[1,1],ratings_test[2,2],ratings_test[5,3]),c(ratings_test[1,2],ratings_test[2,2],2),c(ratings_test[1,1],ratings_test[1,2],3))
ratings_test
ratings_test_rr <- as(ratings_test, "realRatingMatrix")
View(ratings_test_rr)

test_matrix <- recc_data_test@data #ratings_test_rr@data
test_matrix
#test_matrix[4,3]<-5
#ratings_test_rr@data <- test_matrix
#ratings_test_rr@data
test_matrix["_n9XdwgtuyI_5BCGIEYstw","8_hy-FrbC9zcakjKH_yaXA"]

test_matrix["zx_j6OuuHHa2afVoAZuLpA","9M4eZJfPkgSMOWKrcUWSEg"]

test_matrix["qwc30hKEL7DRzEznxZo28A","BUcI9HUM-JEZZnJmXJKvpg"]<-2
test_matrix["zx_j6OuuHHa2afVoAZuLpA","9M4eZJfPkgSMOWKrcUWSEg"]<-3
ratings_test_rr@data <- test_matrix
ratings_test_rr@data

for (i in 1:(nrow(ratings_test))){
     print(test_matrix[ratings_test[i,1],ratings_test[i,2]])
    # print(ratings_test[i,3])
}
test_matrix2<-test_matrix

test_matrix["AA4lxVlnFnmQL5g0jgLDTg","9M4eZJfPkgSMOWKrcUWSEg"]<-1
for (i in 1:(nrow(merge_data))){
  test_matrix[merge_data[i,1],merge_data[i,2]]
  test_matrix[merge_data[i,1],merge_data[i,2]]<-ratings_test[i,3]
}

test_matrix[ratings_test[1,1],ratings_test[1,2]]
recc_data_test@data
rating_mat_df <- as(ratings_mat, "data.frame")
rating_mat_df
recc_data_test_df <- as(recc_data_test, "data.frame")
merge_data<- merge(recc_data_test_df, rating_mat_df, by=c("user","item"))
merge_data <- merge_data[,-3]
colnames(merge_data) <- c("user", "item", "rating")
#data_test <- as(merge_data, "realRatingMatrix")
data_test@data@x <- merge_data[,3]
     
            