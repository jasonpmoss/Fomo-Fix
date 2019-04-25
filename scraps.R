#ratingsmat is survey results
#data_test is recc_data_test_survey

dt <- recc_data_test_survey
rm <- survey_results
class(rm[1,1])
b_ids<-(colnames(dt))
u_ids<- unique(rm$user_id)
merge_data_survey<- data.frame(matrix(ncol=length(b_ids),nrow=length(u_ids)))
colnames(merge_data_survey) <- b_ids
modtypes<-u_ids
(setattr(merge_data_survey, "row.names", modtypes))
rownames(merge_data_survey)
colnames(merge_data_survey)
for (i in 1:(nrow(rm))){
  merge_data_survey[rm[i,2],rm[i,1]]<-rm[i,3]
}

merge_data_survey<-as.matrix(merge_data_survey)
merge_data_survey<-dropNA(merge_data_survey)
library("Matrix")
dt@data <- as(merge_data_survey, "dgCMatrix")


merge_data_survey
merge_data_survey[,"0m99JzzybBddbP9mr2y5XA"] #<-rm[i,3]
# merge_data_survey["cjcampagna@gmail.com","0m99JzzybBddbP9mr2y5XA"]<-1
order(colnames(merge_data_survey))
one<-as.data.frame(colnames(merge_data_survey))
two<- as.data.frame(b_ids)
colnames(one)<-"b_id"
colnames(two)<-"b_id"
anti_join(one,two)
b_ids
View(recc_data_test_survey)
View(dt)
