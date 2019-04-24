# #we already have the evaluationScheme saved in the eval_set variable. We will use it
# scheme <- evaluationScheme(rating_mat_popular_sentiment, method="cross-validation", k=4, given=-1, goodRating=3.5)
# 
# algorithms <- list(
#                    "Popular_sentiment_N" = list(name="Popular", param=list(normalize = NULL)),
#                    "Popular_sentiment_C" = list(name="Popular", param=list(normalize = "center")),
#                    "Popular_sentiment_Z" = list(name="Popular", param=list(normalize = "Z-score")))
#   
# eval_results_sentiment <- evaluate(scheme, algorithms, type="topNList", n=c(1, 5, 10, 15, 20, 50, 100))
# 
# plot(eval_results_sentiment, annotate=c(1,3), legend="topleft", main = "ROC curve") # Receiver Operating Characteristic (ROC) Curve
# #NOTE:A model with no skill at each threshold is represented by a diagonal line from 
# #the bottom left of the plot to the top right and has an AUC of 0.5 --> JUST OUR CASE!!
# 
# plot(eval_results_sentiment, "prec/rec", annotate=TRUE, main = "Precision-recall", legend="topleft") # Precision-Recall (P-R) Curves
# #NOTE: A model with perfect skill is depicted as a point at [1.0,1.0]. 
# #A skilful model is represented by a curve that bows towards [1.0,1.0] above the flat line of no skill.
# 
# #we can display the results of the evaluation of one model, including all the splits:
# avg(eval_results_sentiment)
# 
# #or we can observe each confusion matrix separetly. 
# #Note: if we use k-fold then we get "k" confusion matrix per model, one per fold  
# #getConfusionMatrix(eval_results$UBCF_N_C)
# 
# #If we want to take account of all the splits at the same time, we can just sum up the indices:
# # columns_to_sum <- c("TP", "FP", "FN", "TN")
# # indices_summed <- Reduce("+", getConfusionMatrix(eval_results$UBCF_N_C))[,columns_to_sum]
# # head(indices_summed)

