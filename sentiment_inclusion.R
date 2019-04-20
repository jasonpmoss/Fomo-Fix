recc_data_train@data@x<-(recc_data_train@data@x-mean(recc_data_train@data@x, na.rm=TRUE))/sd(recc_data_train@data@x, na.rm=TRUE)
recc_data_test@data@x<-(recc_data_test@data@x-mean(recc_data_test@data@x, na.rm=TRUE))/sd(recc_data_test@data@x, na.rm=TRUE)
recc_data_train

sql_sentiment <- "SELECT * FROM `fomofix-217307.fomofixds.fin_LV_Restaurant_Sentiments`"

fin_LV_Restaurant_Sentiments

sql <- "SELECT business_id, user_id, stars FROM `fomofix-217307.fomofixds.fin_LV_Restaurant_Reviews_6_Months`;"

#Execute the query and store the result
ratings <- query_exec(sql, project = project, use_legacy_sql = FALSE)
sentiment <- query_exec(sql, project = project, use_legacy_sql = FALSE)
sentiment$adjusted_bing <- (sentiment$sentiment_score_bing + 6)/2
summary(sentiment$adjusted_bing)
library(dplyr)
rating_sentiment <- inner_join(ratings, sentiment, by="business_id")
rating_sentiment$adjusted_stars <- (rating_sentiment$stars + rating_sentiment$adjusted_bing)/2
summary(rating_sentiment$adjusted_stars )
summary(rating_sentiment$stars)
hist(rating_sentiment$adjusted_stars )
hist(rating_sentiment$stars)


