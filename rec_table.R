#Author: Jason
library(readr)
full_set <- read_csv("/Volumes/GoogleDrive/My Drive/NYU MSBA/Courses/Capstone/dataset/Yelp Data Selection/full set without text.csv")
reviews_full <- as.data.frame(full_set)
users <-unique(reviews_full$user_id) #create list of user_ids
businesses <- unique(reviews_full$business_id) #create list of business_ids
which(businesses == "" | is.na(businesses), arr.ind = TRUE) #check if there are any blank or NA records in the business and user id lists
which(users == "" | is.na(users), arr.ind = TRUE)
users<- na.omit(users) #clean out NA records (if there are any)
businesses<- na.omit(businesses)
library(data.table) #use this library to change row and column names below
rec_table<-data.frame(matrix(NA, nrow = length(users), ncol = 1)) #create recommender table
(setattr(rec_table, "row.names", users)) #label rows as user ids
rec_table[,businesses] <- NA #label column names as business ids
rec_table <- rec_table[,-1] #remove first dummy column
for (i in seq_len(nrow(full_set))){  #populate rec_table
  rec_table[full_set$user_id[i],full_set$business_id[i]] <- full_set$stars_1[i]
}
u<-0
b<-0
for (i in seq_len(nrow(rec_table))){  #create list of friendly user names
  u[i] <- paste0("u_",i)
}
for (i in seq_len(ncol(rec_table))){  #create list of friendly business names 
  b[i] <- paste0("b_",i)
}
#rename users to friendly names
(setattr(rec_table, "row.names", u)) #label rows as user ids
names(rec_table)<-b