source("Hybrid_predict_survey.R")
Hybrid_predict_survey <- Hybrid_predict_restaurants_survey(recc_data_test_survey)
print("Hybrid restaurants predictions done")
gc()

source("Hybrid_predict_survey.R")
Hybrid_predict_ratings<-Hybrid_predict_ratings_survey(recc_data_test_survey)
gc()
print("Hybrid ratings predictions done")

#Hybrid_predict_ratings_survey@data@x[Hybrid_predict_ratings_survey@data@x[] < 1] <- 1
#Hybrid_predict_ratings_survey@data@x[Hybrid_predict_ratings_survey@data@x[] > 5] <- 5