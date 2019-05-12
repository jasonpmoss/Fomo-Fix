## app.R ##
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinyjs)
library(leaflet)
library(readr)
library(dplyr)
library(plyr)
library(recommenderlab)
library(magrittr)
library(readxl)
library(DMwR2)
library(RJSONIO)
library(tidyr)
library(bigrquery)


st <- read_csv("Categories.txt", col_names = FALSE)
st <- as.data.frame(st)
catg <- st[,2]
names(catg) <- st[,1]
rm(st)

city_list <- read_xlsx("City_Names.xlsx")
state_list <- read_xlsx("List_of_States.xlsx")
full_set <- read_csv("full set without text.csv")

ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "FOMO Fix",
                  dropdownMenu(type = "messages",
                               messageItem(
                                 from = "FOMO Fix team",
                                 message = "New app available in Google Play",
                                 icon = icon("glyphicon glyphicon-phone", lib="glyphicon"),
                                 time = "2019-05-10"
                               ),
                               messageItem(
                                 from = "FOMO Fix team",
                                 message = "New survey available",
                                 icon = icon("glyphicon glyphicon-list-alt", lib="glyphicon"),
                                 time = "2019-05-15"
                               )
                  ),
                  dropdownMenu(type = "notifications",
                               notificationItem(
                                 text = "7 new recommendations for you!",
                                 icon("glyphicon glyphicon-bullhorn", lib="glyphicon")
                               ),
                               notificationItem(
                                 text = "Trendy today",
                                 icon = icon("exclamation-triangle"),
                                 status = "warning"
                               ),
                               notificationItem(
                                 text = "New hype among your friends",
                                 icon = icon("users"),
                                 status = "warning"
                               )
                  )
                  
                ),
  dashboardSidebar(
    #collapsed = TRUE,
    ## Sidebar content
    dashboardSidebar(
      sidebarMenu(
        menuItem("Tune your recommendations", tabName = "dashboard", icon = icon("glyphicon glyphicon-cutlery", lib="glyphicon")),
        # menuItem("Advanced", tabName = "advanced", icon = icon("fas fa-tasks")),
        selectizeInput('User', 'Select User', 
                       choices = unlist(recc_data_test@data@Dimnames[1]),
                       selected = unlist(recc_data_test@data@Dimnames[1])[1]
                       ),
        # selectInput("city_list", label = "Select city for recommendation", 
        #             choices = city_list$City, selected = city_list$City[1]),
        radioButtons("model", label ="What is your current mood?",
                     choices = list("SURPRISE ME! (daring)" = 1,
                                    "Where would friends go?" =2,
                                    "What is trending?" = 3,
                                    "Where would I go? (safe)" = 4),
                     selected = 1),
        sliderInput("n_recommendations", "Number of recommendations:", 1, 10, 5)
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
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
        fluidRow(
          column(width = 8,
                 leafletOutput("mymap1",height = 450, width = "100%"),
                 p(), p(), p()
          
          # column(width = 3,
          #        #  # A static infoBox
          #        # infoBox("New Orders", 10 * 2, icon = icon("credit-card"))
          #        # Dynamic infoBoxes
          #        valueBoxOutput("successBox",width = NULL),
          #        valueBoxOutput("businessBox",width = NULL),
          #        valueBoxOutput("usersBox",width = NULL)
          ),
          column(width = 4,
            box(
              width = 12, status = "info",
              title = "Top restaurants",
              tableOutput("packageTable")
            )
          )
        ),
        fluidRow(
          infoBoxOutput("successBox",width = 3),
          infoBoxOutput("businessBox",width = 3),
          infoBoxOutput("usersBox",width = 3),
          infoBoxOutput("reviewsBox",width = 3)
        ),
        fluidRow(
          box(
            width = NULL, background = "black",
            "Mood Details:\n
Surprise me:\n
Recommender based on FOMO Fix Hybrid model."
          )
        )
      )
    )
  )
)


server <- function(input, output) {
  output$mymap1 <- renderLeaflet({  
      user <- input$User
      if (input$model == 1){
        predicted_ratings<-predict_ratings_per_user(Hybrid_model, ratings_mat, user, 10)
      }
      else if(input$model == 2){
        predicted_ratings<-predict_ratings_per_user(UBCF_N_J_100, ratings_mat, user, 10)
      }
      else  if(input$model == 3){
        predicted_ratings<-predict_ratings_per_user(Popular_N, ratings_mat, user, 10)
      }
      else if (input$model == 4){
        predicted_ratings<-predict_ratings_per_user(IBCF_N_C_100, ratings_mat, user, 10)
      }
      
      #filter recommendations and display them in the map
      predictions<-predicted_ratings$Restaurant #to see only the restaurants name      
      predictions<-predictions[1:input$n_recommendations] #get the first "n_recommendations"      
      predictions %<>% as.data.frame()
      res_plot(get_restaurants(predictions))
    })
  
  output$packageTable <- renderTable({
    user <- input$User
    if (input$model == 1){
      predicted_ratings<-predict_ratings_per_user(Hybrid_model, ratings_mat, user, 10)
    }
    else if(input$model == 2){
      predicted_ratings<-predict_ratings_per_user(UBCF_N_J_100, ratings_mat, user, 10)
    }
    else  if(input$model == 3){
      predicted_ratings<-predict_ratings_per_user(Popular_N, ratings_mat, user, 10)
    }
    else if (input$model == 4){
      predicted_ratings<-predict_ratings_per_user(IBCF_N_C_100, ratings_mat, user, 10)
    }
    
    #filter recommendations and display them in the map
    predictions<-predicted_ratings$Restaurant #to see only the restaurants name      
    predictions<-predictions[1:input$n_recommendations] #get the first "n_recommendations"      
    predictions %<>% as.data.frame()
    predictions_display <- as.data.frame(get_restaurants(predictions)[2:3])
    colnames(predictions_display) <- c(" ", "Stars")
    predictions_display 
  }, rownames = TRUE, colnames = TRUE, digits = 1)
  
  output$successBox <- renderInfoBox({
    infoBox(
      "Succesful Recommendations", "87%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "green"
    )
  })
  
  output$businessBox <- renderInfoBox({
    infoBox(
      "#Restaurants", dim(recc_data_test)[2],  icon = icon("glyphicon glyphicon-cutlery", lib="glyphicon"),
      color = "blue"
    )
  })
  
  output$usersBox <- renderInfoBox({
    infoBox(
      "#Users", dim(recc_data_test)[1], icon = icon("users"),
      color = "blue"
    )
  })
  
  output$reviewsBox <- renderInfoBox({
    infoBox(
      "#Reviews", 345.296, icon = icon("glyphicon glyphicon-pencil", lib="glyphicon"),
      color = "red"
    )
  })
}

shinyApp(ui, server)

