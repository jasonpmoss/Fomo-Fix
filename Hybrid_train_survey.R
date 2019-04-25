
Hybrid_train_survey<-function(model_1,model_2,model_3,model_4, weight_1,weight_2,weight_3,weight_4){
  
  recom <- HybridRecommender(
    model_1,
    model_2,
    model_3,
    model_4,
    weights = c(weight_1, weight_2, weight_3, weight_4)
  )
  # save the model to disk
  saveRDS(recom, "./Hybrid_model_survey.rds")
  
  return(recom)
}
