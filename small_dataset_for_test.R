#Create a small and manageable ratings matrix

rating_small <- as.data.frame(cbind(
                    c("restaurant1","restaurant2","restaurant4", "restaurant1", "restaurant3", "restaurant4", "restaurant1", "restaurant4", "restaurant5"), 
                    c("user1","user1","user1","user2","user2","user2","user3","user3","user3"),
                    c(5, 1, 3, 5, 2, 4, 1, 5, 3)))

colnames(rating_small) <- c("business_id", "user_id", "stars")

user <- "user2"

model_training_required <- TRUE





