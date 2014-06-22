##Getting & Cleaning Data: Course Project
##Creating a Tidy Data Set from Messy Samsung Data

#Preliminary reading in of files
#Read in features.txt and activity_labels.txt for labelling
features<-read.table("features.txt",colClasses=c("integer","character"),stringsAsFactors=FALSE)
activity_labels<-read.table("activity_labels.txt",colClasses=c("integer","character"),stringsAsFactors=FALSE)
#Rename Activities with Descriptive Names
activity_labels[,2]<-c("Walking","Walking Up Stairs","Walking Down Stairs","Sitting","Standing Up","Laying Down")
colnames(activity_labels)<-c("Action_ID","Action")


##STEP 1: Merging Training and Test Sets
##Read in Test data and create one Test data frame
subject_test<-read.table("subject_test.txt",stringsAsFactors=FALSE)
X_test<-read.table("X_test.txt",stringsAsFactors=FALSE)
y_test<-read.table("y_test.txt",stringsAsFactors=FALSE)
Test<-cbind.data.frame(subject_test,y_test,X_test)

##Read in Train data and create one Train data frame
subject_train<-read.table("subject_train.txt",stringsAsFactors=FALSE)
X_train<-read.table("X_train.txt",stringsAsFactors=FALSE)
y_train<-read.table("y_train.txt",stringsAsFactors=FALSE)
Train<-cbind.data.frame(subject_train,y_train,X_train)

##Merge into one large data set and rename the data frame using labels from features.txt
merge.data<-rbind.data.frame(Test,Train)
merge.names<-colnames(merge.data)
merge.names<-c("Subject","Activity",features[,2])
colnames(merge.data)<-merge.names


##STEP 2: Extracting Means and Standard Deviations
##Extract columns involving the mean and standard deviation of the measurements
Index.means.stds<-c(grep("mean()",colnames(merge.data),fixed=TRUE),grep("std()",colnames(merge.data),fixed=TRUE))
Ordered.Index<-Index.means.stds[order(Index.means.stds,decreasing=FALSE)]

##Form a table with Subject, Activity, Means, & Standard Devs
Means.Stds<-merge.data[,c(1,2,Ordered.Index)]


##STEP 3: Use Descriptive Activity Names to Name Activities (Note: renamed activities in line 9)
##Merge Means.Stds.Data with activity_labels to get descriptive activity labels
Data<-merge(activity_labels,Means.Stds,by.x="Action_ID",by.y="Activity")

##Order data by subject, breaking ties with activity ID number
Subject.Index<-order(Data[,3],Data[,1])
Ordered.Data<-Data[Subject.Index,]


##STEP 4: Appropriately Label Variable Names with Description
##Melt the data using Action_ID, Action, and Subject as ID variables
column.names<-colnames(Ordered.Data)
Data<-melt(Ordered.Data,id=column.names[1:3])

##Begin Splitting Data into different factors for Variable Name clarity:
        ##Domain: Time=1,Frequency=2
        ##Acceleration Type: Body=1,Gravity=2
        ##Signal: Acc=1, Gyro=2
        ##Jerk: Yes=1, No=2
        ##Mag: Yes=1, No=2
        ##Function: Mean=1, Std=2
        ##Direction: X=1, Y=2, Z=3, None=4
Domain<-vector(mode="integer",length=nrow(Data))
domain.index<-grep("f",Data[,ncol(Data)-1],fixed=TRUE)
Domain[setdiff(1:nrow(Data),domain.index)]<-1
Domain[domain.index]<-2
Domain<-factor(Domain,levels=c(1,2),labels=c("Time","Frequency"))
D.Data<-cbind(Domain,Data)

Type<-vector(mode="integer",length=nrow(Data))
type.index<-grep("Body",D.Data[,ncol(D.Data)-1],fixed=TRUE)
Type[type.index]<-1
Type[setdiff(1:nrow(D.Data),type.index)]<-2
Type<-factor(Type,levels=c(1,2),labels=c("Body","Gravity"))
D.T.Data<-cbind(Type,D.Data)

Signal<-vector(mode="integer",length=nrow(Data))
signal.index<-grep("Acc",D.T.Data[,ncol(D.T.Data)-1],fixed=TRUE)
Signal[signal.index]<-1
Signal[setdiff(1:nrow(D.T.Data),signal.index)]<-2
Signal<-factor(Signal,levels=c(1,2),labels=c("Accelerometer","Gyroscope"))
D.T.S.Data<-cbind(Signal,D.T.Data)

Jerk<-vector(mode="integer",length=nrow(Data))
jerk.index<-grep("Jerk",D.T.S.Data[,ncol(D.T.S.Data)-1],fixed=TRUE)
Jerk[jerk.index]<-1
Jerk[setdiff(1:nrow(D.T.S.Data),jerk.index)]<-2
Jerk<-factor(Jerk,levels=c(1,2),labels=c("Jerk","No Jerk"))
D.T.S.J.Data<-cbind(Jerk,D.T.S.Data)

Mag<-vector(mode="integer",length=nrow(Data))
mag.index<-grep("Mag",D.T.S.J.Data[,ncol(D.T.S.J.Data)-1],fixed=TRUE)
Mag[mag.index]<-1
Mag[setdiff(1:nrow(D.T.S.J.Data),mag.index)]<-2
Mag<-factor(Mag,levels=c(1,2),labels=c("Mag","No Mag"))
D.T.S.J.M.Data<-cbind(Mag,D.T.S.J.Data)

Function<-vector(mode="integer",length=nrow(Data))
function.index<-grep("mean()",D.T.S.J.M.Data[,ncol(D.T.S.J.M.Data)-1],fixed=TRUE)
Function[function.index]<-1
Function[setdiff(1:nrow(D.T.S.J.M.Data),function.index)]<-2
Function<-factor(Function,levels=c(1,2),labels=c("Mean","Standard Deviation"))
D.T.S.J.M.F.Data<-cbind(Function,D.T.S.J.M.Data)

Direction<-vector(mode="integer",length=nrow(Data))
x.index<-grep("-X",D.T.S.J.M.F.Data[,ncol(D.T.S.J.M.F.Data)-1],fixed=TRUE)
y.index<-grep("-Y",D.T.S.J.M.F.Data[,ncol(D.T.S.J.M.F.Data)-1],fixed=TRUE)
z.index<-grep("-Z",D.T.S.J.M.F.Data[,ncol(D.T.S.J.M.F.Data)-1],fixed=TRUE)
Direction[x.index]<-1
Direction[y.index]<-2
Direction[z.index]<-3
Direction[setdiff(1:nrow(D.T.S.J.M.F.Data),c(x.index,y.index,z.index))]<-4
Direction<-factor(Direction,levels=c(1,2,3,4),labels=c("X","Y","Z","Not Specified"))
All.Data<-cbind(Direction,D.T.S.J.M.F.Data)

##Reorder Columns (removing original "variable" column) to create a long, tidy data set
##Note: I have included this Data Set on my GitHub repo, just for fun.
Tidy.Data<-All.Data[,c("Subject","Action_ID","Action","Domain","Type","Signal","Jerk","Mag","Function","Direction","value")]
colnames(Tidy.Data)<-c("Subject","Activity_ID","Activity","Domain","Acceleration Type","Signal","Jerk","Mag","Function","Direction","Measurement")


##STEP 5: Create a second, independent, tidy data set with the average of each variable
##        for each subject and activity
##Compute the Averages of the Measurements for each of the Subject's Activities
subsets<-split(Tidy.Data,Tidy.Data$Subject)
averages<-NULL
All_Ave<-NULL
#Computing averages for loop here:
for(i in 1:30){
        set<-subsets[[i]]
        Averages<-by(set$Measurement,set$Activity,FUN=mean)
        Ave<-cbind(i,Averages)
        All_Ave<-rbind(All_Ave,Ave)
}
Tidy.Data.2<-as.data.frame(All_Ave)
col<-rownames(All_Ave)
Tidy.Data.2<-cbind(Tidy.Data.2,col)
colnames(Tidy.Data.2)<-c("Subject","Averages","Activity")
Tidy.Data.2<-Tidy.Data.2[,c(1,3,2)]

##Write the Final Tidy Data Set to a .txt file
write.table(Tidy.Data.2,file="C:/Users/Llontop/Documents/gd-alldata/Tidy_Data_2.txt",sep="\t", row.names = F)