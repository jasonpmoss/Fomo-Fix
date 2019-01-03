#----------------------------------------Data import and creation-----------------------------------------------#
# we need to define data input requirements !!!!

get_dataframe <-function(sql_query){
  project <- "fomofix-217307" #project ID 
  output <- bq_project_query(project, sql, destination_table = NULL, quiet = NA)
  
  reviews_big <- bq_table_download(output)
  reviews_small<-reviews_big[1:10000,]
  
  return(list(full=reviews_big,small=reviews_small)) #two dataframe sizes while we work out our requirements/restrictions
}

#----------------------------------------testing the function-----------------------------------------------#

# sql <- "select * from `fomofix-217307.fomofixds.lv_testset`;"
# ratings<- get_dataframe(sql)
# ratings$full
# ratings$small
