# Getting-and-Cleaning-Data-Course-Project

There are 4 variables at begining of run_analysis.R script.   
* dataDir - directory in r working dir where files would be downloaded  
* fileName - name of file that you would download
* outputFileName - name of final output file
* url - url to file that would be downloaded

If you are not pleased with default settings for these variables change them before running script.

Script would download file and:  
1. Merge the training and the test sets to create one data set.  
2. Extract only the measurements on the mean and standard deviation for each measurement.  
3. Output tidy data set with the average of each variable for each activity and each subject.  
