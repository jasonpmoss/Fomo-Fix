library(bigrquery)

#----------------------------------------Data import and creation-----------------------------------------------#
# we need to define data input requirements !!!!

get_dataframe <-function(sql_query){
  project <- "fomofix-217307" #project ID 
  output <- bq_project_query(project, sql, destination_table = NULL, quiet = NA)
  ratings_big <- bq_table_download(output)
  return(ratings_big)
}

#----------------------------------------testing the function-----------------------------------------------#

# sql <- "select * from `fomofix-217307.fomofixds.lv_testset`;"
# ratings<- get_dataframe(sql)

