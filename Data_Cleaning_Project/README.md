## The Process:
The script used to clean up the data is run_analysis.R. If you would like to run the script on your computer, copy it to the main folder where the data sets are located and make sure to modify all the directories properly. The script starts by loading the required data into r, then rename the variables in the test and training data sets using the names in `features’ file. Before appending the data into a single data set, subject id and test label will be merged with the proper data set (test & training). After appending test and training data together, variables other than the ones that contain the mean and standard deviation will be removed. Then the remaining variables will be renamed and reordered properly to end up with a clean tidy data set. To create the second data set that contains the averages of all the variables (grouped by subject id and activity), we simply used aggregate function. Same with the first data set, the generated data set will be reordered properly as desired. Finally, apart from the two final data sets, all the other data sets created during the process will be removed from the memory and the two final data sets will be saved on the local drive as .csv or .txt files.


## Original Data Provided By:  

*Human Activity Recognition Using Smartphones Dataset, version 1.0*

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
Smartlab - Non Linear Complex Systems Laboratory. 
DITEN - Universit‡ degli Studi di Genova.  
Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  
www.smartlab.ws  
