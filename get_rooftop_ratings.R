#Author: Jason

library(bigrquery)
library(leaflet)
library(dplyr)
library(magrittr)

#---------------this function gets the list of business ids from the predictor and generates the restaurant dataframe----
get_rooftop_ratings<-function(final_recommendations){
  
  with_sql_statement_string<-"WITH ordered_rest AS ("
  for (i in 1:nrow(final_recommendations)) {
    with_temp_string<-ifelse (i< nrow(final_recommendations), paste0("SELECT STRUCT('",
                                                                     final_recommendations[i,1],
                                                                     "' AS business_id, ", 
                                                                     i,
                                                                     " AS l_order) AS ordered_rest UNION ALL ",
                                                                     sep=""), paste0("SELECT STRUCT('",
                                                                                     final_recommendations[i,1],
                                                                                     "' AS business_id, ", 
                                                                                     i,
                                                                                     " AS l_order) AS ordered_rest )",
                                                                                     sep=""))   
    with_sql_statement_string<-paste(with_sql_statement_string,with_temp_string)
  }
  
  where_sql_statement_string <-" b.business_id = o.ordered_rest.business_id ORDER BY o.ordered_rest.l_order"
  
  
  # where_sql_statement_string <-""
  # for (i in 1:nrow(final_recommendations)) {
  #   where_temp_string<-ifelse (i< nrow(final_recommendations), paste("business_id= '",final_recommendations[i,1],"' or", sep=""),paste("business_id= '",final_recommendations[i,1],"'", sep=""))   
  #   where_sql_statement_string<-paste(where_sql_statement_string,where_temp_string)
  # }    
  
  sql_of_businesses_for_mapping<-"SELECT
  b.business_id,
  date,
  stars,
  user_id,
  review_id
  FROM
  `fomofix-217307.fomofixds.fin_LV_Restaurant_Reviews` b ,
  ordered_rest o
  WHERE"
  
  sql_of_businesses_for_mapping<-paste(with_sql_statement_string,sql_of_businesses_for_mapping, where_sql_statement_string)
  
  project <- "fomofix-217307" #project ID 
  output <- bq_project_query(project, sql_of_businesses_for_mapping, destination_table = NULL, quiet = NA)
  restaurant_df <<- bq_table_download(output) #create a dataframe that can be used later to publish a list of restaurants
  return(restaurant_df)
}


