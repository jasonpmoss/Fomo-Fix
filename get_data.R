library(bigrquery)

#----------------------------------------Data import and creation-----------------------------------------------#
# we need to define data input requirements !!!!

get_dataframe <-function(sql_query){
  project <- "fomofix-217307" #project ID 
  output <- bq_project_query(project, sql, destination_table = NULL, quiet = NA)
  
  ratings_big <- bq_table_download(output)
  #ratings_small<-ratings_big[1:30000,]
  return(ratings_big)
  #return(list(full=ratings_big,small=ratings_small)) #two dataframe sizes while we work out our requirements/restrictions
}

#----------------------------------------testing the function-----------------------------------------------#

# sql <- "select * from `fomofix-217307.fomofixds.lv_testset`;"
# ratings<- get_dataframe(sql)

