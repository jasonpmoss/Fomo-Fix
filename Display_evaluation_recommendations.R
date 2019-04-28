
#function to compute the average of the confusion matrix and to filter the right columns
avg_conf_matr <- function(results) {
  tmp <- results %>% avg(getConfusionMatrix())
  tmp <- data.frame(n_recommendations = row.names(tmp), tmp)
  tmp <- tmp[,c("n_recommendations","precision","recall","TPR","FPR")]
}

source("remove_chart_junk.R")
myChartAttr <- myChartAttr_fn()

#Compute the average confusion matrix per model and cleans the results

# Using map() to iterate function across all models
tide_confusion_matrix <- function(results){
  tiddy_conf_mat <- c()
  tiddy_conf_mat <- results %>%
                    map(avg_conf_matr) %>% 
                    # Turning into an unnested tibble
                    enframe() %>%
                    # Unnesting to have all variables on same level
                    unnest()
  tiddy_conf_mat
}


#Display ROC curve
display_roc_curves <- function(conf_mat){
  conf_mat %>%
    ggplot(aes(FPR, TPR, 
               colour = fct_reorder2(as.factor(name), 
                                     FPR, TPR))) +
    geom_line() +
    #geom_label(aes(label = n_recommendations))  +
    labs(title = "ROC curves", colour = "Model") +
    theme_grey(base_size = 14) + myChartAttr
}


#Display Precision-Recall curve
display_precision_recall_curves <- function(conf_mat){
  conf_mat %>%
  ggplot(aes(recall, precision, 
             colour = fct_reorder2(as.factor(name),  
                                   precision, recall))) +
  geom_line() +
  #geom_label(aes(label = n_recommendations))  +
  labs(title = "Precision-Recall curves", colour = "Model") +
  theme_grey(base_size = 14) + myChartAttr
}
