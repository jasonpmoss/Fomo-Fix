library(recommenderlab)

scheme <- evaluationScheme(ratings_mat, method="split", train=0.8, k=1, given=-1, goodRating=4)

#algorithms <- list("random items" = list(name="RANDOM", param=NULL), "popular items" = list(name="POPULAR", param=NULL), "user-based CF" = list(name="UBCF", param=list(nn=50)), "item-based CF" = list(name="IBCF", param=list(k=50)), "SVD approximation" = list(name="SVD", param=list(k=50)))
algorithms <- list("random items" = list(name="RANDOM", param=NULL), "popular items" = list(name="POPULAR", param=NULL), "user-based CF" = list(name="UBCF", param=list(nn=50)), "item-based CF" = list(name="IBCF", param=list(k=50)), "Hybrid" = list(name="HYBRID", param=NULL))

results <- evaluate(scheme, algorithms, type="topNList", n=c(1, 3, 5, 10, 15, 20))

plot(results, annotate=c(1,3), legend="bottomright") # Receiver Operating Characteristic (ROC) Curve

plot(results, "prec/rec", annotate=3, legend="topleft") # Precision-Recall (P-R) Curves
