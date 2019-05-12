#Extract the dataset from GoogleBigQuery:
project <- "fomofix-217307"

sql <- "SELECT r.business_id, r.name
FROM `fomofix-217307.fomofixds.fin_LV_Restaurant_Categories` c,
`fomofix-217307.fomofixds.fin_LV_Restaurants` r
WHERE c.business_id = r.business_id
AND c.Value = 'Rooftop Bar';"

#Execute the query and store the result
rooftops <- query_exec(sql, project = project, use_legacy_sql = FALSE)



##QUERY FOR SENTIMENT
sql <- "SELECT  r.business_id, r.name, 
rs.sentiment_score_syuzhet, 
rs.sentiment_score_bing,
rs.sentiment_score_afinn,
rs.sentiment_score_nrc
FROM `fomofix-217307.fomofixds.fin_LV_Restaurant_Categories` c,
`fomofix-217307.fomofixds.fin_LV_Restaurants` r,
`fomofix-217307.fomofixds.fin_LV_Restaurant_Sentiments` rs
WHERE c.business_id = r.business_id
AND r.business_id = rs.business_id
AND c.Value = 'Rooftop Bar';"

sentiments <- query_exec(sql, project = project, use_legacy_sql = FALSE)


#sentiment of the 30 rooftops
subset(sentiment, business_id %in% rooftops$business_id)


#users having rated the 30 rooftops
sql <- "SELECT  u.user_id, u.name, u.review_count, u.average_rating, u.first_review, u.last_review,
        rw.date, rw.stars, rw.business_id
FROM  `fomofix-217307.fomofixds.fin_LV_Restaurant_Users` u,
`fomofix-217307.fomofixds.fin_LV_Restaurant_Reviews` rw
WHERE rw.user_id = u.user_id
AND EXISTS (  SELECT 1 
FROM  `fomofix-217307.fomofixds.fin_LV_Restaurant_Categories` c,
`fomofix-217307.fomofixds.fin_LV_Restaurants` r
WHERE c.business_id = r.business_id
AND r.business_id = rw.business_id
AND c.Value = 'Rooftop Bar'
);"
users_rooftop <- query_exec(sql, project = project, use_legacy_sql = FALSE)


#Create new dataframe with Anyndia containing ratings of 5 for 20 of the 30 rooftops
anindya <- as.data.frame(cbind(
  rooftops$business_id[1:20], 
  rep("anindya",20),
  rep(5,20)))

colnames(anindya) <- c("business_id", "user_id", "stars")
anindya$business_id <- as.character(anindya$business_id)
anindya$user_id <- as.character(anindya$user_id)
anindya$stars <- as.integer(anindya$stars)

#we look for users having rated at least 5 rooftops with 5 stars
rooftop_users_5 <- subset(users_rooftop, stars=5)$user_id
rooftop_users_5_freq <- as.data.frame(table(subset(users_rooftop, stars=5)$user_id))
rooftop_users_5stars_5rooftops_freq <- subset(rooftop_users_5_freq, Freq>5)
rooftop_users_5stars_5rooftops <- as.character(rooftop_users_5stars_5rooftops_freq$Var1)
#there are 39 users that rated with 5 at least 5 rooftops in vegas

#we  copy their ratings into Anindya profile to make them similar
ratings_rooftop_users_5 <- subset(ratings, user_id = rooftop_users_5stars_5rooftops)
ratings_rooftop_users_5_anindya <- ratings_rooftop_users_5
ratings_rooftop_users_5_anindya$user_id <- rep("anindya",nrow(ratings_rooftop_users_5))
anindya <- rbind(anindya, ratings_rooftop_users_5_anindya)

#now anindya has the same ratings than those users having rated at least 5 rooftops with 5 stars,
#and he has also reviewed 20 rooftops with 5 stars

#NEXT: INSERT ANINDYA INTO THE TRAINING DATASET AND RUN THE MODELS WITH HIM