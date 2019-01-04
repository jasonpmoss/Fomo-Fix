#Author: Jason

sql <- "SELECT
  *
FROM
  `fomofix-217307.fomofixds.lv_testset`
WHERE
  stars>0
LIMIT
  100000;"

source("get_data.R") #h as to be in the same working directory or specify full path
ratings<- get_dataframe(sql)
#ratings$full #this is the large dataframe
#ratings$small #this is a smaller dataframe to deal with challenges from large dataframes

source("ratings_matrix.R")

ratings_matrix<-ratings_matrix(ratings$small$user_id, ratings$small$business_id, ratings$small$stars)
#ratings_matrix

source("IBCF_predict.R")