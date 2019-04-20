library(recommenderlab)

#we build several models with different configurations to evaluate them

# Train Popular
Popular_sentiment_N <- Recommender(recc_data_train_sentiment, "Popular", param=list(normalize = NULL))
Popular_sentiment_C <- Recommender(recc_data_train_sentiment, "Popular", param=list(normalize = "center"))
Popular_sentiment_Z <- Recommender(recc_data_train_sentiment, "Popular", param=list(normalize = "Z-score"))


# Compute predicted ratings

p_Popular_sentiment_N <- predict(Popular_sentiment_N, recc_data_test_sentiment, type="ratings")
p_Popular_sentiment_C <- predict(Popular_sentiment_C, recc_data_test_sentiment, type="ratings")
p_Popular_sentiment_Z <- predict(Popular_sentiment_Z, recc_data_test_sentiment, type="ratings")

# Set all predictions that fall outside the valid range to the boundary values

p_Popular_sentiment_N@data@x[p_Popular_sentiment_N@data@x[] < 1] <- 1
p_Popular_sentiment_N@data@x[p_Popular_sentiment_N@data@x[] > 5] <- 5
p_Popular_sentiment_C@data@x[p_Popular_sentiment_C@data@x[] < 1] <- 1
p_Popular_sentiment_C@data@x[p_Popular_sentiment_C@data@x[] > 5] <- 5
p_Popular_sentiment_Z@data@x[p_Popular_sentiment_Z@data@x[] < 1] <- 1
p_Popular_sentiment_Z@data@x[p_Popular_sentiment_Z@data@x[] > 5] <- 5

# Evaluate performance  
library(knitr)
accuracy_Popular_sentiment_N <- calcPredictionAccuracy(p_Popular_sentiment_N, recc_data_eval)
accuracy_Popular_sentiment_C <- calcPredictionAccuracy(p_Popular_sentiment_C, recc_data_eval)
accuracy_Popular_sentiment_Z <- calcPredictionAccuracy(p_Popular_sentiment_Z, recc_data_eval)


eval_ratings_results <- rbind(
  accuracy_Popular_sentiment_N,
  accuracy_Popular_sentiment_C,
  accuracy_Popular_sentiment_Z
)

eval_ratings_results <- data.frame(eval_ratings_results)
rownames(eval_ratings_results) <- c("p_Popular_sentiment_N",
                                    "p_Popular_sentiment_C",
                                    "p_Popular_sentiment_Z")
eval_ratings_results <- eval_ratings_results[order(eval_ratings_results$RMSE ),]
eval_ratings_results


library(tidyr)
eval_ratings_results$rec_type <- rownames(eval_ratings_results)

#### PLOT - ALL Model Errors ####
eval_ratings_results_long<- gather(eval_ratings_results, Error , Err_Value, RMSE:MAE)

library(ggplot2)
myChartAttr <-  theme_bw() +
  theme(panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "gray"), 
        axis.ticks.x=element_blank(), 
        axis.ticks.y=element_blank())
colorbar = c("#444444","#808080","#f55d4b")

# ggplot(eval_ratings_results_long, aes(fill = Error , x = rec_type, y=Err_Value)) +
#   geom_bar(position="dodge", stat="identity",width = 0.9) +
#   myChartAttr + 
#   labs(x="",y ="Error Rate") +
#   theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
#   scale_fill_manual(values=colorbar)


#### PLOT - Popular model Errors ####
eval_ratings_results_popular <- subset(eval_ratings_results, eval_ratings_results$rec_type %in% c("p_Popular_sentiment_N",
                                                                                               "p_Popular_sentiment_C",
                                                                                               "p_Popular_sentiment_Z"))

eval_ratings_results_long_popular<- gather(eval_ratings_results_popular, Error, Err_Value, RMSE:MAE)

ggplot(eval_ratings_results_long_popular, aes(fill = Error, x = rec_type, y=Err_Value)) +
  geom_bar(position="dodge", stat="identity",width = 0.4) +
  myChartAttr +
  labs(x="",y ="Error Rate") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.9)) +
  scale_fill_manual(values=colorbar)


##NOTE: We can also change the way we split trainig/test dataset and compare evaluation of
##      different values of k for the cross-validation method with 2, 4, 6,... k-folds


