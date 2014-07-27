																		README


	1. Listing related files: after downloading zip file and unzipping "UCI HAR Dataset" in current working directory, the same has been checked for and
	   following text files and folders have been observed:

		 "activity_labels.txt"   "features.txt"     "features_info.txt"   "README.txt"     "test"       "train" 
	
		1."activity_labels.txt": This text file is read into R console with the varaible name "activity.labels". It contains a data frame of six activities
		                         which has been performed by 30 volunteer participants(Subjects).The data frame is cleaned from character"_" before being
					 used in the small tidy second dataset.
	
		2. "feaurures.txt"  :   This text file is read into R console with variable name "features".It contains a data frame listing 561 measurements variable
					names in abbreviated forms.This later on has been trimmed to relevant 66 variable names on the basis of "mean" & "std" as per the 
					requirement of project as variable name of "selectfeat" and further cleaned and variables name of data frame has been expanded into
					descriptive names in the dataframe named "selectfeat1".the content of the dataframe "selectfeat1" has been further explained in the 
					"CodeBook.md" file.
	

		3. "features_info.txt": This text file is read into R console with a variable name "features.info". It contains the breif description of the variables generated
					 uunder the various test conditon and the equipments used for the generation of measurement values listed in text file "features.txt".It
					has been only used for the information sharing for the various variable vectors.

		4. "README.txt"       : This text file is read into R console with a variable name "readme".This single column dataframe explains the response data of 561 variable vectors
					listed in the "features.txt" after the use of Samsung smart phone embedded with accelerometer and gyroscope.These variables are 561 feature vector
					with time and frequency domain variables.Like "features_info.txt" this file also has been used for only information sharing about the project.

		5 "test"	     :  30% of the volunteers generated test data and this folder consists of 4 data files in it which are as follows:
					

					 "Inertial Signals"        "subject_test.txt"        "X_test.txt"       "y_test.txt" 

				 	5.1 Inertial signals: this data set is not the part of our project, hence ignored,

					


					5.3 "x_test.txt"    : this dataframe is read into R as a variable name "txt" and it enlist measurement data of all variables enlisted in features for the activities
								enlisted in subject_test.txt. It has 2947 measured values for 561 variables.
					5.4 "y_test.txt"    :this dataframe is read into R console as variable name "tyt" and it enlist	the activities nos (1:6) enlisted in activity.labels.
								
		6. "train"	    : 	70% of the volunteers generated test data and this folder consists of 4 data files in it which are as follows:

					 "Inertial Signals"  	"subject_train.txt" 		"X_train.txt"       "y_train.txt"

					6.1 "Inertial signals": this data set is not the part of our project, hence ignored.

					6.2 "subject_train.txt": this dataframe is read into R as a variable name"subtr" and it enlist the subjects no which has under gone the testing as activities
								duly listed in the activity.labels.It has subjects performing all 6 activities and having 7352 rows.
					6.3 "x_train.txt"    : this dataframe is read into R as a variable name "trxt" and it enlist measurement data of all variables enlisted in features for the activities
								enlisted in subject_test.txt. It has 7352 measured values for 561 variables.

					6.4 "y_test.txt"    :this dataframe is read into R console as variable name "tryt" and it enlist numerical the activities nos (1:6) enlisted in activity.labels.


	2. Process flow of script:	1. downloading the zipped file into current working directory
					2. create a temporary directory & file and save the file into temp files.
					3. unzip file in the current directory as folder "UCI HAR Dataset".
					4.listing files of the folder "UCI HAR Dataset" getting 4 txt.files and two folders of "test" and "train".


					"activity_labels.txt" "features.txt"        "features_info.txt" 
 
					 "README.txt"          "test"                "train"     

					5.  reading & checking every files:
					6. as the header is also one of the subjects hence header= FALSE in every file.
					7. removing " _ "from the activity names of activity.labels for cleaning the activity names
					8. reading feature.txt, feature_ info.txt, README .txt.
					9. opening and reading the files in test and train folder and checking for dim() for every files
					10 As the files in the inertial signals folder is not part of the data set hence not read.
					
					11. selecting variables in "selectfeat" with only mean and std(Standard deviation) from features.txt files.Also
					    removing the variable "-meanFreq" from the selectfeat data as frame meanFreq() is Weighted average 
						of the frequency components to obtain a mean frequency	and not the mean of a vector.
					12. convert  variable names to descriptive variable names of selectfeat1 from "feature.txt" after cleaning and removing
						abbreviated characters and kept file as "selectfeat1".

					13. appending subject, activity ,variable measured data of train sub folder.
					14. trimming the traindata by its variables for measurements of mean and std by 
						the variable available in selectfeat1 data frame.
	
					15. appending subject, activity ,variable measured data of test sub folder.
					16.trimming the test data by its variables for measurements of mean and std by 
						the variable available in selectfeat1 data frame.
					17. replacing the variable names with long  descriptive variable names.
					18. merging the two trimmed dataframes as merg.data.
					19. replacing the numerical activity by activity names by matching function and removing the 
						integer column of activity.Hence received my first tidy cleaned longer data set.

					
					20. Calculating the average for activity and subject wise of the  measurement variables of mean & std using ddply()
						from plyr package. Hence received second tidy data set named as "small.merg.data" indicating 180 (6 activity * 30 subjects)
						average readings of each subject for each activity for 66 measurement variables.

					21. saved the small second tidy dataset in txt file and manually submitted to coursera site.

					22. checking the saved file by reading into R.
					

 





	
					

			