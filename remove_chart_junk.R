myChartAttr_fn <- function(){
  myChartAttr <-  theme_bw() +
    theme(panel.border = element_blank(), 
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), 
          axis.line = element_line(colour = "gray"), 
          axis.ticks.x=element_blank(), 
          axis.ticks.y=element_blank())
}
colorbar = c("#444444","#808080","#f55d4b")