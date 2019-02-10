library(recommenderlab)

#we already have the evaluationScheme saved in the eval_set variable. We will use it
scheme <- evaluationScheme(ratings_mat, method="cross-validation", k=4, given=-1, goodRating=3.5)

algorithms <- list("UBCF_N_C" = list(name="UBCF", param=list(normalize = NULL, method="Cosine")), 
                   "UBCF_C_C" = list(name="UBCF", param=list(normalize = "center", method="Cosine")), 
                   "UBCF_Z_C" = list(name="UBCF", param=list(normalize = "Z-score", method="Cosine")), 
                   "UBCF_N_E" = list(name="UBCF", param=list(normalize = NULL, method="Euclidean")),
                   "UBCF_C_E" = list(name="UBCF", param=list(normalize = "center", method="Euclidean")),
                   "UBCF_Z_E" = list(name="UBCF", param=list(normalize = "Z-score", method="Euclidean"))
                   )
# A more exhaustive list of models to evaluate:
# algorithms <- list("UBCF_N_C" = list(name="UBCF", param=list(normalize = NULL, method="Cosine")),
#                    "UBCF_C_C" = list(name="UBCF", param=list(normalize = "center", method="Cosine")),
#                    "UBCF_Z_C" = list(name="UBCF", param=list(normalize = "Z-score", method="Cosine")),
#                    "UBCF_N_E" = list(name="UBCF", param=list(normalize = NULL, method="Euclidean")),
#                    "UBCF_C_E" = list(name="UBCF", param=list(normalize = "center", method="Euclidean")),
#                    "UBCF_Z_E" = list(name="UBCF", param=list(normalize = "Z-score", method="Euclidean")),
#                    "IBCF_N_C" = list(name="IBCF", param=list(normalize = NULL, method="Cosine")),
#                    "IBCF_C_C" = list(name="IBCF", param=list(normalize = "center", method="Cosine")),
#                    "IBCF_Z_C" = list(name="IBCF", param=list(normalize = "Z-score", method="Cosine")),
#                    "IBCF_N_E" = list(name="IBCF", param=list(normalize = NULL, method="Euclidean")),
#                    "IBCF_C_E" = list(name="IBCF", param=list(normalize = "center", method="Euclidean")),
#                    "IBCF_Z_E" = list(name="IBCF", param=list(normalize = "Z-score", method="Euclidean")),
#                    "Popular_N" = list(name="Popular", param=list(normalize = NULL)),
#                    "Popular_C" = list(name="Popular", param=list(normalize = "center")),
#                    "Popular_Z" = list(name="Popular", param=list(normalize = "Z-score")))
                   
eval_results <- evaluate(scheme, algorithms, type="topNList", n=c(1, 5, 10, 15, 20, 50, 100))

plot(eval_results, annotate=c(1,3), legend="topleft", main = "ROC curve") # Receiver Operating Characteristic (ROC) Curve
#NOTE:A model with no skill at each threshold is represented by a diagonal line from 
#the bottom left of the plot to the top right and has an AUC of 0.5 --> JUST OUR CASE!!

plot(eval_results, "prec/rec", annotate=TRUE, main = "Precision-recall", legend="topleft") # Precision-Recall (P-R) Curves
#NOTE: A model with perfect skill is depicted as a point at [1.0,1.0]. 
#A skilful model is represented by a curve that bows towards [1.0,1.0] above the flat line of no skill.
#JUST THE OPPOSITE TO OUR CASE!!!

#we can display the results of the evaluation of one model, including all the splits:
getConfusionMatrix(eval_results$UBCF_N_C)

#If we want to take account of all the splits at the same time, we can just sum up the indices:
columns_to_sum <- c("TP", "FP", "FN", "TN")
indices_summed <- Reduce("+", getConfusionMatrix(eval_results$UBCF_N_C))[,columns_to_sum]
head(indices_summed)

#or just compute the average of them
avg(eval_results$UBCF_N_C)

#for all results: 
#avg(eval_results)


#STILL UNDER TEST: how to test the performance of a model with different nearest_neighbours
vector_k <- c(5, 10, 20, 30, 40)
models_to_evaluate <- lapply(vector_k, function(k){
  list(name = "UBCF", param = list(method = "cosine", nn = vector_k))
}
)

names(models_to_evaluate) <- paste0("UBCF_k_", vector_k)

n_recommendations <- c(1, 5, 10, 15, 20, 50, 100)
list_results <- evaluate(x = eval_set, 
                         method = models_to_evaluate, 
                         n = n_recommendations)


