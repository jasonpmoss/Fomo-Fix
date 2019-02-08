library(recommenderlab)

#we already have the evaluationScheme saved in the eval_set variable. We will use it
#scheme <- evaluationScheme(ratings_mat, method="split", train=0.8, k=1, given=-1, goodRating=4)

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

plot(eval_results, annotate=c(1,3), legend="bottomright", main = "ROC curve") # Receiver Operating Characteristic (ROC) Curve

plot(eval_results, "prec/rec", annotate=TRUE, main = "Precision-recall", legend="topleft") # Precision-Recall (P-R) Curves

getConfusionMatrix(eval_results)[[1]]
