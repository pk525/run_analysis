getwd()
setwd()

## data to be cleaned:
url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
# create a temporary directory & downloading in temp file:
tf = tempfile()
download.file(url,tf,mode="wb")
tf
[1] "C:\\Users\\PK\\AppData\\Local\\Temp\\RtmpM1cYS8\\file15b4813472"
# save the downloaded file in working directory:
zipdir <- tempfile()
unzip(tf, exdir = zipdir)
lt<- list.files(zipdir)
length(lt)
lt
unlink(tf)
setwd(zdir)
zdir<- tempdir()
con<-unzip(lt,exdir=zdir)

setwd(zipdir)
## Checking list of files in the folder"UCI HAR Dataset" lying in the working directory:

lf<-list.files("./UCI HAR Dataset")
lf
## [1] "activity_labels.txt" "features.txt"        "features_info.txt"  
## [4] "README.txt"          "test"                "train"     

setwd( "C:/Users/PK/Desktop/gettingcleaning workspace/UCI HAR Dataset")
## checking & reading every files:
## as the header is also one of the subjects hence header= FALSE:

activity.labels<-read.table("./UCI HAR Dataset/activity_labels.txt",header=F,stringsAsFactors=FALSE)

# removing " _ "from the activity names:

activity.labels$V2<- gsub("_"," ",activity.labels$V2)
# reading  rest of the files:

features<- read.table("./UCI HAR Dataset/features.txt",header=F,stringsAsFactors=FALSE)
features.info<-read.table("./UCI HAR Dataset/features_info.txt",header=F,sep="\t",stringsAsFactors=FALSE)
readme<-read.table("./UCI HAR Dataset/README.txt",header=F,sep="\t",stringsAsFactors=FALSE)

## opening and reading the files in test and train folders:

list.files("./UCI HAR Dataset/train")
##[1] "Inertial Signals"  "subject_train.txt" "X_train.txt"      
##[4] "y_train.txt" 

##As the files in the "inertial signals" folder is not part of the data set hence reading other files:

subtr<- read.table("./UCI HAR Dataset/train/subject_train.txt",header=T,stringsAsFactors=FALSE)
dim(subtr)
# list of subject from 1 to 30 in 7351 rows of observations.

trxt<-read.table("./UCI HAR Dataset/train/X_train.txt",header=T,stringsAsFactors=FALSE)

tryt<- read.table("./UCI HAR Dataset/train/y_train.txt",header=T,stringsAsFactors=FALSE)

## listing files from test folder of UCI folder:

list.files("./UCI HAR Dataset/test")
## [1] "Inertial Signals" "subject_test.txt" "X_test.txt"       "y_test.txt" 


## As the files in the "inertial signals" folder is not part of the data set,hence reading other files:

suxt<-read.table("./UCI HAR Dataset/test/subject_test.txt",header=T,stringsAsFactors=FALSE)

txt<- read.table("./UCI HAR Dataset/test/X_test.txt",header=T,stringsAsFactors=FALSE)

tyt<- read.table("./UCI HAR Dataset/test/y_test.txt",header=T,stringsAsFactors=FALSE)

## selecting variables with mean and Standard dev from features.txt files:

selectfeat<- features[(grep("*-mean|-std*",features[,2])),]

#removing the variable "-meanFreq" from the selectfeat data frame:

selectfeat1<- selectfeat[!grepl("-meanFreq",selectfeat[,2]),]

##convert  variable names in selectfeat1 to descriptive variable names:

selectfeat1$V2 <- gsub("[(),]","",selectfeat1$V2)
selectfeat1$V2 <- gsub("BodyBody", "Body",selectfeat1$V2)
selectfeat1$V2 <- gsub("f", "Frequency",selectfeat1$V2,fixed=TRUE)
selectfeat1$V2 <- sub("^t", "Time",selectfeat1$V2) # for changing only first "t"


## appending subject and activity of train variable data:
train.data<- cbind(trxt,subtr,tryt)

##trimming the train.data by its variables for measurements of only mean and std $ checking:

trim.train.data<- train.data[,c(selectfeat1[,1],562,563)]  # 562 & 563 are subject & Activity columns.

# replacing the column names to trim.train.data with long variable name:

colnames(trim.train.data)[1:68]<- c(selectfeat1[,2],"Subject","Activity")

## appending test variable data,subject,y label:
test.data<- cbind(txt,suxt,tyt)

##trimming the test.data by its variables for measurements of only mean and std:

trim.test.data<- test.data[,c(selectfeat1[,1],562,563)]

# replacing the variable names with long variable names:

colnames(trim.test.data)[1:68]<- c(selectfeat1[,2],"Subject","Activity")


## merging the two dataframes:
merg.data<- rbind(trim.train.data,trim.test.data)

# replacing the numeric activity in merg.data by activity names from activity.labels file:

#m<- match(merg.data$Activity,activity.labels[,1])

merg.data$Act.labels<- activity.labels[match(merg.data$Activity,activity.labels[,1]),2]

dim(merg.data)

#Removing the numerical variable column of Activity of merg.data & checking:
merg.data<- merg.data[,-68]
dim(merg.data)

## Calculating the average for activity and subject wise of the variables of mean & std & checking:

library("plyr")

small.merg.data<-ddply(merg.data,c("Subject","Act.labels"),numcolwise(mean))
head(small.merg.data,10)

## saving the data set in txt file in working directory:
write.table(small.merg.data,file="Second.Tidy.Data.txt",sep=",",row.names=TRUE)
## reading the saved file :
head(read.table(file.choose(),header=T,sep=","),20)