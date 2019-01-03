sql <- "select * from `fomofix-217307.fomofixds.lv_testset`;"
source("get_data.R") #has to be in the same working directory or specify full path
ratings<- get_dataframe(sql)
#ratings$full #this is the large dataframe
#ratings$small #this is a smaller dataframe to deal with challenges from large dataframes

source("ratings_matrix.R")

ratings_matrix<-ratings_matrix(ratings$small$user_id, ratings$small$business_id, ratings$small$stars)
#ratings_matrix


