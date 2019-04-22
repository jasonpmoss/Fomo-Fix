
Hybrid_train<-function(model_1,model_2,model_3,model_4, weight_1,weight_2,weight_3,weight_4){

  recom <- HybridRecommender(
    model_1,
    model_2,
    model_3,
    model_4,
    weights = c(weight_1, weight_2, weight_3, weight_4)
  )
  # save the model to disk
  saveRDS(recom, "./Hybrid_model.rds")
  
  return(recom)
}

#------------------------test function------------------------------------------
# UBCF_model <- readRDS("./UBCF_model.rds")
# IBCF_model <- readRDS("./IBCF_model.rds")
# Popular_model <- readRDS("./Popular_model.rds")
#Hybrid_train(UBCF_model, IBCF_model, Popular_model, UBCF_weight, IBCF_weight, Popular_weight)
#recom
#getModel(recom)