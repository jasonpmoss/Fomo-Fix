source("Hybrid_predict.R")
Hybrid_predict <- Hybrid_predict_restaurants(recc_data_test)
print("Hybrid restaurants predictions done")
gc()

source("Hybrid_predict.R")
Hybrid_predict_ratings<-Hybrid_predict_ratings(recc_data_test)
gc()
print("Hybrid ratings predictions done")

Hybrid_predict_ratings@data@x[Hybrid_predict_ratings@data@x[] < 1] <- 1
Hybrid_predict_ratings@data@x[Hybrid_predict_ratings@data@x[] > 5] <- 5