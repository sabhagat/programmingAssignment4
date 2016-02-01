subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
subject_total<-rbind(subject_train, subject_test)

X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
X_total<-rbind(X_train, X_test)

Y_test<-read.table("UCI HAR Dataset/test/Y_test.txt")
Y_train<-read.table("UCI HAR Dataset/train/Y_train.txt")
Y_total<-rbind(Y_train, Y_test) 

features<-read.table("UCI HAR Dataset/features.txt")
cols<-features[grepl("mean|std", features$V2),]
names(cols)<-c("id","name")
X_mean_std_cols_total<-X_total[,cols$id]
names(X_mean_std_cols_total)<-cols[,2]

activities<-read.table("UCI HAR Dataset/activity_labels.txt")
Y_total<-as.data.frame(merge(Y_total, activities)[,2])
names(Y_total)<-c("activities")

main<-cbind(subject_total, X_mean_std_cols_total, Y_total)
names(main)[1]<-c("id")

if (!file.exists("./UCI HAR Dataset/results")) dir.create("./UCI HAR Dataset/results")
write.table(main,"./UCI HAR Dataset/results/main_data.txt")

main_mean<-aggregate(subset(main,,2:80),by=list(main$id, main$activities),mean)
names(main_mean)[1]<-c("id")
names(main_mean)[2]<-c("activities")
write.table(main_mean,"./UCI HAR Dataset/results/main_mean_data.txt",row.names=FALSE)
