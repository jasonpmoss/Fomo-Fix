#code based on: http://www.sthda.com/english/articles/32-r-graphics-essentials/128-plot-time-series-data-using-ggplot/

install.packages("gtrendsR")
install.packages("reshape2")
library(gtrendsR)
library(reshape2)

google.trends = gtrends(c("Momofuku"),geo = c("US-NV"), gprop = "news", time = "all")[[1]]
google.trends = dcast(google.trends, date ~ keyword + geo, value.var = "hits")
rownames(google.trends) = google.trends$date
#google.trends$date = NULL
# Sys.setenv(TZ = "UTC")
#plot(google.trends)

library(ggplot2)
ggplot(data = google.trends, aes(x = google.trends$date, y = google.trends$`Momofuku`))+
  geom_line(color = "#00AFBB", size = 1) + 
  stat_smooth(color = "#FC4E07", fill = "#FC4E07",method = "loess")

  