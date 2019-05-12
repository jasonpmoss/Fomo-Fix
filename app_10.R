#library(shinydashboard)

#NOTE: the code is splitted into three parts:
#      1. All code required to load and prepare the data that the app will use, including the FOMO FIX functions
#      2. UI: where we define the interface of the shiny app
#      3. server: all background computation required while using the app to generate the outputs


#################################################
##          LOAD DATASET                       ##
#################################################

#install.packages("recommerderlab")
#install.packages("readr")
library(readr)
library(dplyr)
library(plyr)
library(recommenderlab)
library(magrittr)
library(readxl)
library(DMwR2)
library(RJSONIO)
library(leaflet)
library(tidyr)
library(shiny)
library(shinyWidgets)
library(shinyjs)
library(bigrquery)
#setwd("~/NYU/Courses/Capstone Project/FOMO Fix/Yelp/Data")
st <- read_csv("Categories.txt", col_names = FALSE)
st <- as.data.frame(st)
catg <- st[,2]
names(catg) <- st[,1]
rm(st)

city_list <- read_xlsx("City_Names.xlsx")
state_list <- read_xlsx("List_of_States.xlsx")
full_set <- read_csv("full set without text.csv")

# Creating layouts for 2 tabs: default and advanced view
library(shinyWidgets)
library(shinyjs)

layout1 <-
  sidebarLayout( 
    sidebarPanel(selectizeInput('User', 'Select User', 
                                #RAFA 11-May: code below updated:
                                # choices = rownames(rec_table_test),
                                # selected = rownames(rec_table_test)[1])
                                choices = unlist(recc_data_test@data@Dimnames[1]),
                                selected = unlist(recc_data_test@data@Dimnames[1])[1])
                 ,
                 radioButtons("model", label ="What is your current mood?",
                              choices = list("SURPRISE ME! (daring)" = 1,
                                             "Where would friends go?" =2,
                                             "What is trending?" = 3,
                                             "Where would I go? (safe)" = 4),
                              selected = 1)
                 ,
                 sliderInput("n_recommendations",
                             "Number of recommendations:",
                             min = 1,
                             max = 5,
                             value = 3)
                 , p("_______________________________")
                 , strong("Mood Details")
                 , p("")
                 , strong("Surprise me:")
                 , p("Recommender based on FOMO Fix Hybrid model.")
                 , strong("Where would friends go:")
                 , p("Recommender based on user-based collaborative filtering")
                 , strong("What is trending:")
                 , p("Recommender based on popularity-based collaborative filtering.")
                 , strong("Where would I go:")
                 , p("Recommender based on item-based collaborative filtering")
                 
    )
    ,
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("mymap1",height = 690)
    ))

layout2 <-
  sidebarLayout(
  sidebarPanel(selectizeInput('User', 'Select User', 
                              #RAFA 11-May: code below updated:
                              # choices = rownames(rec_table_test),
                              # selected = rownames(rec_table_test)[1])
                              choices = unlist(recc_data_test@data@Dimnames[1]),
                              selected = unlist(recc_data_test@data@Dimnames[1])[1])
               ,
               selectInput("city_list", label = "Select city for recommendation", 
                           choices = city_list$City, selected = city_list$City[1])
               ,
               selectInput("catg", label = "What type of food outlet are you looking for?", 
                           choices = catg, selected = catg[1])
               ,
               radioButtons("model", label ="What is your current mood?",
                            choices = list("SURPRISE ME! (daring)" = 1,
                                           "Where would friends go?" =2,
                                           "What is trending?" = 3,
                                           "Where would I go? (safe)" = 4),
                            selected = 1),
               sliderInput("n_recommendations",
                           "Number of recommendations:",
                           min = 1,
                           max = 5,
                           value = 3)
               , p("_______________________________")
               , strong("Mood Details")
               , p("")
               , strong("Surprise me:")
               , p("A Hybrid FOMO Fix recommender.")
               , strong("Where would friends go:")
               , p("Recommender based on user-based collaborative filtering")
               , strong("What is trending:")
               , p("Recommender based on popularity-based collaborative filtering.")
               , strong("Where would I go:")
               , p("Recommender based on item-based collaborative filtering")
  )
  ,
  # Show a plot of the generated distribution
  mainPanel(
    leafletOutput("mymap2",height = 838)
  )
)

# Define UI for application that draws a histogram
ui <- fluidPage(
  # Sidebar with a slider input for number of bins 
  titlePanel("FOMO Fix Recommender System"), 
  useShinyjs(),
  checkboxInput("adop", "Show advanced options", FALSE),
  tabsetPanel(id = "navbar",
              tabPanel(title = "Default", 
                       value = "tab1",
                       layout1
              ),
              tabPanel(title = "Advanced",
                       value = "tab2",
                       layout2
              )
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  observe({
    toggle(condition = input$adop, selector = "#navbar li a[data-value=tab2]")
  })
  #Support Functions:
  #function that given an user and a recommendation matrix, it returns recommended restaurants for that user

  #Output
  #output$recommendations <- renderPrint({
  output$mymap1 <- renderLeaflet({  

    #RAFA May-11: IMPORANT: if one model does not predict any restaurant, we need to be able to
    #display a message in the app or find a way to manage that scenario
    #a warning is diplayed when this happend: FOMOFIX Warning in predict_ratings_per_user function: The model did not recommend any restaurant for this user
    
    ## model == 1 : FOMO Fix
    ## model == 2 : UBCF
    ## model == 3 : Popularity
    ## model == 4 : IBCF
    user <- input$User
    if (input$model == 1){
      predicted_ratings<-predict_ratings_per_user(Hybrid_model, ratings_mat, user, 5)
    }
    else if(input$model == 2){
        predicted_ratings<-predict_ratings_per_user(UBCF_N_J_100, ratings_mat, user, 5)
    }
    else  if(input$model == 3){
        predicted_ratings<-predict_ratings_per_user(Popular_N, ratings_mat, user, 5)
    }
    else if (input$model == 4){
        predicted_ratings<-predict_ratings_per_user(IBCF_N_C_100, ratings_mat, user, 5)
    }

    #filter recommendations and display them in the map
    predictions<-predicted_ratings$Restaurant #to see only the restaurants name      
    predictions<-predictions[1:input$n_recommendations] #get the first "n_recommendations"      
    predictions %<>% as.data.frame()
    res_plot(get_restaurants(predictions)) #important to use get_restaurants functions in the res_plot function call
  }) 
  output$mymap2 <- renderLeaflet({  
    
    #RAFA May-11: IMPORANT: if one model does not predict any restaurant, we need to be able to
    #display a message in the app or find a way to manage that scenario
    #a warning is diplayed when this happend: FOMOFIX Warning in predict_ratings_per_user function: The model did not recommend any restaurant for this user
    ## model == 1 : FOMO Fix
    ## model == 2 : UBCF
    ## model == 3 : Popularity
    ## model == 4 : IBCF
    user <- input$User
    if (input$model == 1){
      predicted_ratings<-predict_ratings_per_user(Hybrid_model, ratings_mat, user, 5)
    }
    else if(input$model == 2){
      predicted_ratings<-predict_ratings_per_user(UBCF_N_J_100, ratings_mat, user, 5)
    }
    else  if(input$model == 3){
      predicted_ratings<-predict_ratings_per_user(Popular_N, ratings_mat, user, 5)
    }
    else if (input$model == 4){
      predicted_ratings<-predict_ratings_per_user(IBCF_N_C_100, ratings_mat, user, 5)
    }
    
    #filter recommendations and display them in the map
    #IMPORANT: ARE WE FILTERING THE TOP n RECOMMENDATIONS??? make sure 
    predictions<-predicted_ratings$Restaurant #to see only the restaurants name      
    predictions<-predictions[1:input$n_recommendations] #get the first "n_recommendations"      
    predictions %<>% as.data.frame()
    res_plot(get_restaurants(predictions)) #important to use get_restaurants functions in the res_plot function call
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

