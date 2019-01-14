#Author: Jason

library(bigrquery)
library(leaflet)
library(dplyr)
library(magrittr)

#---------------this function gets the list of business ids from the predictor and generates the restaurant dataframe----
get_restaurants<-function(final_recommendations){
  
  where_sql_statement_string<-""
  for (i in 1:nrow(final_recommendations)) {
    temp_string<-ifelse (i< nrow(final_recommendations), paste("business_id= '",final_recommendations[i,1],"' or", sep=""),paste("business_id= '",final_recommendations[i,1],"'", sep=""))   
    where_sql_statement_string<-paste(where_sql_statement_string,temp_string)
  }
  
  sql_of_businesses_for_mapping<-"SELECT
  business_id,
  name,
  stars,
  review_count,
  city,
  state,
  latitude,
  longitude
  FROM
  `fomofix-217307.fomofixds.business`
  WHERE"
  
  sql_of_businesses_for_mapping<-paste(sql_of_businesses_for_mapping, where_sql_statement_string)
  
  project <- "fomofix-217307" #project ID 
  output <- bq_project_query(project, sql_of_businesses_for_mapping, destination_table = NULL, quiet = NA)
  restaurant_df <<- bq_table_download(output) #create a dataframe that can be used later to publish a list of restaurants
  return(restaurant_df)
}

#----------------function to plot restaurants on map----------------

res_plot <- function(res_df){ #this function will take a subset of restaurants as an input and generate a map of those restuarants
  
  #create the FOMO icon
  FOMO_icon <- makeIcon(
    iconUrl = "FomoFix.ico",
    iconWidth = 38, iconHeight = 50,
    iconAnchorX = 22, iconAnchorY = 94
  )
  
  #this creates the content to populate the popups over the restaurant name
  for (i in 1:nrow(res_df)){
    if (i==1) content<-NULL # need this line to initialise the content variable
    content[i]<- paste(sep = "<br/>",
                       res_df[i,"name"],
                       #res_df[i,"address"], #lots of nulls for some reason in the extract. Need to check in with Sheel on what the issue might be
                       paste("<b> rating: ",res_df[i,"stars"]," <b>")
    )
  }
  
  restaurants <- res_df %>% as.data.frame()
  restaurants$longitude %<>% as.double()
  restaurants$latitude %<>% as.double()
  restaurants_nv <- subset(restaurants,restaurants$state =="NV") #Update to read from Shiny
  m <- leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(lng=res_df$longitude, lat=res_df$latitude, 100, res_df$name, icon = FOMO_icon) %>%
    addPopups(res_df$longitude, res_df$latitude, content, options = popupOptions(closeButton = TRUE)) %>%
    setView(-115.1400, 36.1719, zoom = 18)
  #setView(-115.2873, 36.1434, zoom = 18)
  return(m %>% fitBounds(-115.2946, 36.1196, -115.0422, 36.2206))
}