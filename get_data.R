#----------------------------------------Data import and creation-----------------------------------------------#
# we need to define data input requirements 

get_dataframe <-function(sql_query){
  project <- "fomofix-217307" #project ID 
  output <- bq_project_query(project, sql, destination_table = NULL, quiet = NA)
  
  reviews_big <- bq_table_download(output)
  reviews_small<-reviews_full[1:100000,]
  
  return(list(full=reviews_full,small=reviews_small)) #two dataframe sizes while we work out our requirements/restrictions
}

#----------------------------------------testing the function-----------------------------------------------#

# sql <- "select * from `fomofix-217307.fomofixds.lv_testset`;"
# x<- get_dataframe(sql)
# x$full
# x$small
