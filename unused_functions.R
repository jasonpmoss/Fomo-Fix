
############################## CODE FROM Display_evaluation_recommendations.R#################################

# Create FOMO fix color
lineColor_fn <- function(){
line_Color = c(
  "#7a2525","#932d2d","#ab3434","#c43c3c","#dc4343","#f54b4b","#f55d4b","#dc5343","#c44a3c","#ab4134",
  "#93372d","#f66d5d","#f77d6e","#f88d81","#f99d93","#faaea5","#fbbeb7","#fccec9","#fddedb","#feeeed",
  "#0e0d0d","#131212","#181717","#1d1b1b","#222020","#272424","#2c2929","#312e2e","#272424","#3c3939",
  "#524f4f","#676565","#7d7b7b","#939191","#a8a7a7","#bebdbd","#d3d3d3","#c4c3c3","#d8d7d7","#ebebeb",
  "#7a2525","#932d2d","#ab3434","#c43c3c","#dc4343","#f54b4b","#f55d4b","#dc5343","#c44a3c","#ab4134",
  "#93372d","#f66d5d","#f77d6e","#f88d81","#f99d93","#faaea5","#fbbeb7","#fccec9","#fddedb","#feeeed",
  "#0e0d0d","#131212","#181717","#1d1b1b","#222020","#272424","#2c2929","#312e2e","#272424","#3c3939",
  "#524f4f","#676565","#7d7b7b","#939191","#a8a7a7","#bebdbd","#d3d3d3","#c4c3c3","#d8d7d7")
}


#Display ROC curve with fomo fix color
library(forcats)
display_roc_curves_FOMO_Color <- function(conf_mat){
  lineColor <- lineColor_fn()
  myChart <- myChartAttr_fn()
  conf_mat %>%
    ggplot(aes(FPR, TPR, 
               colour = fct_reorder2(as.factor(name), 
                                     FPR, TPR))) +
    geom_line(size=1) +
    geom_label(aes(label = n_recommendations))  +
    labs(title = "ROC curves", colour = "Model") +
    theme_grey(base_size = 14) + myChart + scale_colour_manual(values=lineColor)
}

#Code to plot results using the standard plot funtion:
plot(eval_results, annotate=c(1,3), legend="bottomright", main = "ROC curve") # Receiver Operating Characteristic (ROC) Curve
#Precision-Recall:
plot(eval_results, "prec/rec", annotate=TRUE, main = "Precision-recall", legend="topleft") # Precision-Recall (P-R) Curves
#Confusion Matrix:
getConfusionMatrix(eval_results[[1]])
avg(eval_results)


##############################################################################################################


