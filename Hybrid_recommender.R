
Hybrid_predict<-function(model_1,model_2,model_3, weight_1,weight_2,weight_3){

recom <- HybridRecommender(
  model_1,
  model_2,
  model_3,
  weights = c(weight_1, weight_2, weight_3)
)
return(as(predict(recom, recc_data_test), "list"))
}

#------------------------test function------------------------------------------
# UBCF_model <- readRDS("./UBCF_model.rds")
# IBCF_model <- readRDS("./IBCF_model.rds")
# Popular_model <- readRDS("./Popular_model.rds")
#Hybrid_predict(UBCF_model, IBCF_model, Popular_model, UBCF_weight, IBCF_weight, Popular_weight)
#recom
#getModel(recom)

Hybrid_predict_unweighted<-function(IBCF,UBCF,Popular){
  final_recommendations <- c(IBCF, UBCF, Popular)
  final_recommendations <- unique(unlist(strsplit(final_recommendations, " "))) # bring back unique items only
  final_recommendations %<>% data.frame(stringsAsFactors = FALSE)
  names(final_recommendations) <- "business_id"
  user_restaurants_visits<-(subset(ratings,user_id==user))[,1] #restaurants the user has previously visited
  final_recommendations <- anti_join(final_recommendations,user_restaurants_visits) # eliminate restaurants the user has previously visited
  return (final_recommendations)
}