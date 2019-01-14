#two recommender models here. See notes on master.
library(recommenderlab)

Hybrid_predict<-function(recom){
  return(as(predict(recom, recc_data_test), "list"))
}

Hybrid_predict_unweighted<-function(IBCF,UBCF,Popular){
  final_recommendations <- c(IBCF, UBCF, Popular)
  final_recommendations <- unique(unlist(strsplit(final_recommendations, " "))) # bring back unique items only
  final_recommendations %<>% data.frame(stringsAsFactors = FALSE)
  names(final_recommendations) <- "business_id"
  user_restaurants_visits<-(subset(ratings,user_id==user))[,1] #restaurants the user has previously visited
  final_recommendations <- anti_join(final_recommendations,user_restaurants_visits) # eliminate restaurants the user has previously visited
  return (final_recommendations)
}