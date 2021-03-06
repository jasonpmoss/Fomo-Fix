library(recommenderlab)

#we already have the evaluationScheme saved in the eval_set variable. We will use it
#scheme <- evaluationScheme(ratings_mat, method="cross-validation", k=4, given=-1, goodRating=3.5)

algorithms <- list("UBCF_N_C_5" = list(name= "UBCF", param=list(normalize = NULL, method="Cosine", nn=5)),
                   "UBCF_N_C_10" = list(name= "UBCF", param=list(normalize = NULL,method="Cosine", nn=10)),
                   "UBCF_N_C_15" = list(name= "UBCF", param=list(normalize = NULL,method="Cosine", nn=15)),
                   "UBCF_N_C_25" = list(name= "UBCF", param=list(normalize = NULL, method="Cosine", nn=25)),
                   "UBCF_N_C_50" = list(name= "UBCF", param=list(normalize = NULL,method="Cosine", nn=50)),
                   "UBCF_N_C_100" = list(name= "UBCF", param=list(normalize = NULL,method="Cosine", nn=100)),
                   "UBCF_N_E_5" = list(name= "UBCF", param=list(normalize = NULL, method="Euclidean", nn=5)),
                   "UBCF_N_E_10" = list(name= "UBCF", param=list(normalize = NULL,method="Euclidean", nn=10)),
                   "UBCF_N_E_15" = list(name= "UBCF", param=list(normalize = NULL,method="Euclidean", nn=15)),
                   "UBCF_N_E_25" = list(name= "UBCF", param=list(normalize = NULL, method="Euclidean", nn=25)),
                   "UBCF_N_E_50" = list(name= "UBCF", param=list(normalize = NULL,method="Euclidean", nn=50)),
                   "UBCF_N_E_100" = list(name= "UBCF", param=list(normalize = NULL,method="Euclidean", nn=100)),
                   "UBCF_N_J_5" = list(name= "UBCF", param=list(normalize = NULL, method="Jaccard", nn=5)),
                   "UBCF_N_J_10" = list(name= "UBCF", param=list(normalize = NULL,method="Jaccard", nn=10)),
                   "UBCF_N_J_15" = list(name= "UBCF", param=list(normalize = NULL,method="Jaccard", nn=15)),
                   "UBCF_N_J_25" = list(name= "UBCF", param=list(normalize = NULL, method="Jaccard", nn=25)),
                   "UBCF_N_J_50" = list(name= "UBCF", param=list(normalize = NULL,method="Jaccard", nn=50)),
                   "UBCF_N_J_100" = list(name= "UBCF", param=list(normalize = NULL,method="Jaccard", nn=100)),
                   "UBCF_C_C_5" = list(name= "UBCF", param=list(normalize = "center", method="Cosine", nn=5)),
                   "UBCF_C_C_10" = list(name= "UBCF", param=list(normalize = "center",method="Cosine", nn=10)),
                   "UBCF_C_C_15" = list(name= "UBCF", param=list(normalize = "center",method="Cosine", nn=15)),
                   "UBCF_C_C_25" = list(name= "UBCF", param=list(normalize = "center", method="Cosine", nn=25)),
                   "UBCF_C_C_50" = list(name= "UBCF", param=list(normalize = "center",method="Cosine", nn=50)),
                   "UBCF_C_C_100" = list(name= "UBCF", param=list(normalize = "center",method="Cosine", nn=100)),
                   "UBCF_C_E_5" = list(name= "UBCF", param=list(normalize = "center", method="Euclidean", nn=5)),
                   "UBCF_C_E_10" = list(name= "UBCF", param=list(normalize = "center",method="Euclidean", nn=10)),
                   "UBCF_C_E_15" = list(name= "UBCF", param=list(normalize = "center",method="Euclidean", nn=15)),
                   "UBCF_C_E_25" = list(name= "UBCF", param=list(normalize = "center", method="Euclidean", nn=25)),
                   "UBCF_C_E_50" = list(name= "UBCF", param=list(normalize = "center",method="Euclidean", nn=50)),
                   "UBCF_C_E_100" = list(name= "UBCF", param=list(normalize = "center",method="Euclidean", nn=100)),
                   "UBCF_C_J_5" = list(name= "UBCF", param=list(normalize = "center", method="Jaccard", nn=5)),
                   "UBCF_C_J_10" = list(name= "UBCF", param=list(normalize = "center",method="Jaccard", nn=10)),
                   "UBCF_C_J_15" = list(name= "UBCF", param=list(normalize = "center",method="Jaccard", nn=15)),
                   "UBCF_C_J_25" = list(name= "UBCF", param=list(normalize = "center", method="Jaccard", nn=25)),
                   "UBCF_C_J_50" = list(name= "UBCF", param=list(normalize = "center",method="Jaccard", nn=50)),
                   "UBCF_C_J_100" = list(name= "UBCF", param=list(normalize = "center",method="Jaccard", nn=100)),
                   "UBCF_Z_C_5" = list(name= "UBCF", param=list(normalize = "Z-score", method="Cosine", nn=5)),
                   "UBCF_Z_C_10" = list(name= "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=10)),
                   "UBCF_Z_C_15" = list(name= "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=15)),
                   "UBCF_Z_C_25" = list(name= "UBCF", param=list(normalize = "Z-score", method="Cosine", nn=25)),
                   "UBCF_Z_C_50" = list(name= "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=50)),
                   "UBCF_Z_C_100" = list(name= "UBCF", param=list(normalize = "Z-score",method="Cosine", nn=100)),
                   "UBCF_Z_E_5" = list(name= "UBCF", param=list(normalize = "Z-score", method="Euclidean", nn=5)),
                   "UBCF_Z_E_10" = list(name= "UBCF", param=list(normalize = "Z-score",method="Euclidean", nn=10)),
                   "UBCF_Z_E_15" = list(name= "UBCF", param=list(normalize = "Z-score",method="Euclidean", nn=15)),
                   "UBCF_Z_E_25" = list(name= "UBCF", param=list(normalize = "Z-score", method="Euclidean", nn=25)),
                   "UBCF_Z_E_50" = list(name= "UBCF", param=list(normalize = "Z-score",method="Euclidean", nn=50)),
                   "UBCF_Z_E_100" = list(name= "UBCF", param=list(normalize = "Z-score",method="Euclidean", nn=100)),
                   "UBCF_Z_J_5" = list(name= "UBCF", param=list(normalize = "Z-score", method="Jaccard", nn=5)),
                   "UBCF_Z_J_10" = list(name= "UBCF", param=list(normalize = "Z-score",method="Jaccard", nn=10)),
                   "UBCF_Z_J_15" = list(name= "UBCF", param=list(normalize = "Z-score",method="Jaccard", nn=15)),
                   "UBCF_Z_J_25" = list(name= "UBCF", param=list(normalize = "Z-score", method="Jaccard", nn=25)),
                   "UBCF_Z_J_50" = list(name= "UBCF", param=list(normalize = "Z-score",method="Jaccard", nn=50)),
                   "UBCF_Z_J_100" = list(name= "UBCF", param=list(normalize = "Z-score",method="Jaccard", nn=100)),
                   "IBCF_N_C" = list(name="IBCF", param=list(normalize = NULL, method="Cosine")),
                   "IBCF_C_C" = list(name="IBCF", param=list(normalize = "center", method="Cosine")),
                   "IBCF_Z_C" = list(name="IBCF", param=list(normalize = "Z-score", method="Cosine")),
                   "IBCF_N_E" = list(name="IBCF", param=list(normalize = NULL, method="Euclidean")),
                   "IBCF_C_E" = list(name="IBCF", param=list(normalize = "center", method="Euclidean")),
                   "IBCF_Z_E" = list(name="IBCF", param=list(normalize = "Z-score", method="Euclidean")),
                   "IBCF_N_J" = list(name="IBCF", param=list(normalize = NULL, method="Jaccard")),
                   "IBCF_C_J" = list(name="IBCF", param=list(normalize = "center", method="Jaccard")),
                   "IBCF_Z_J" = list(name="IBCF", param=list(normalize = "Z-score", method="Jaccard")),
                   "IBCF_N_C_5" = list(name="IBCF", param=list(normalize = NULL, method="Cosine", k=5)),
                   "IBCF_N_C_10" = list(name="IBCF", param=list(normalize = NULL, method="Cosine", k=10)),
                   "IBCF_N_C_15" = list(name="IBCF", param=list(normalize = NULL, method="Cosine", k=15)),
                   "IBCF_N_C_50" = list(name="IBCF", param=list(normalize = NULL, method="Cosine", k=50)),
                   "IBCF_N_C_100" = list(name="IBCF", param=list(normalize = NULL, method="Cosine", k=100)),
                   "IBCF_N_C_alpha_0.1" = list(name="IBCF", param=list(normalize = NULL, method="Cosine", alpha = 0.1)),
                   "IBCF_N_C_alpha_0.25" = list(name="IBCF", param=list(normalize = NULL, method="Cosine", alpha = 0.25)),
                   "IBCF_N_C_alpha_0.75" = list(name="IBCF", param=list(normalize = NULL, method="Cosine", alpha = 0.75)),
                   "IBCF_N_C_alpha_0.9" = list(name="IBCF", param=list(normalize = NULL, method="Cosine", alpha = 0.9)),
                   "Popular_N" = list(name="Popular", param=list(normalize = NULL)),
                   "Popular_C" = list(name="Popular", param=list(normalize = "center")),
                   "Popular_Z" = list(name="Popular", param=list(normalize = "Z-score")),
                   "Popular_sentiment_N" = list(name="Popular", param=list(normalize = NULL)),
                   "Popular_sentiment_C" = list(name="Popular", param=list(normalize = "center")),
                   "Popular_sentiment_Z" = list(name="Popular", param=list(normalize = "Z-score")))
                   #"SVD_N" = list(name="SVD", param=list(normalize = NULL)),
                   #"SVD_C" = list(name="SVD", param=list(normalize = "center")),
                   #"SVD_Z" = list(name="SVD", param=list(normalize = "Z-score")))
  
eval_results <- evaluate(eval_set, algorithms, type="topNList", n=c(1, 5, 10, 15, 20, 50, 100))

# plot(eval_results, annotate=c(1,3), legend="topleft", main = "ROC curve") # Receiver Operating Characteristic (ROC) Curve
# #NOTE:A model with no skill at each threshold is represented by a diagonal line from 
# #the bottom left of the plot to the top right and has an AUC of 0.5 --> JUST OUR CASE!!
# 
# plot(eval_results, "prec/rec", annotate=TRUE, main = "Precision-recall", legend="topleft") # Precision-Recall (P-R) Curves
# #NOTE: A model with perfect skill is depicted as a point at [1.0,1.0]. 
# #A skilful model is represented by a curve that bows towards [1.0,1.0] above the flat line of no skill.
# #JUST THE OPPOSITE TO OUR CASE!!!
# 
# #we can display the results of the evaluation of one model, including all the splits:
# avg(eval_results)

#or we can observe each confusion matrix separetly. 
#Note: if we use k-fold then we get "k" confusion matrix per model, one per fold  
#getConfusionMatrix(eval_results$UBCF_N_C)

#If we want to take account of all the splits at the same time, we can just sum up the indices:
# columns_to_sum <- c("TP", "FP", "FN", "TN")
# indices_summed <- Reduce("+", getConfusionMatrix(eval_results$UBCF_N_C))[,columns_to_sum]
# head(indices_summed)

