#This function will rank hospital in a givin state based on the # of deaths for a specific 
#disease. 
rankhospital <- function(state, disease, num = "best") {
     options(warn = -1)
     outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
     outcome[,11] <- as.numeric(outcome[,11])
     outcome[,17] <- as.numeric(outcome[,17])
     outcome[,23] <- as.numeric(outcome[,23])
     outcome_st <- outcome[!outcome[,7] != state,]
     states <- outcome[,7]
     diseases <- c("heart attack", "heart failure", "pneumonia")
     if ((state %in% states) == FALSE & (disease %in% diseases) == FALSE) {
          print("invalid state and disease")
     }     
     else if ((state %in% states) == FALSE) {
          print("invalid state")
     }
     else if ((disease %in% diseases) == FALSE) {
          print("invalid disease")
     }
     else if (is.numeric(num) == TRUE & length(outcome[,2]) < as.numeric(num)) {
          return(NA)
     }
     else if (disease == "heart attack") {
          outcome_na <- outcome_st[!is.na(outcome_st[,11]),]
          disease_names <- names(outcome_na)[11]
          hospital_names <- names(outcome_na)[2]
          index <- with(outcome_na, order(outcome_na[disease_names], outcome_na[hospital_names]))
          best_ordered <- outcome_na[index, ]
          
          if (is.character(num) == TRUE) {
               if (num == "best") {
                    num <- 1
               }
               else if (num == "worst") {
                    num <- length(best_ordered[,11])
               }
               else {
                    num <- as.numeric(num)
               }
          }
          best_ordered[num, 2]         
          }
     
     else if (disease == "heart failure") {
          outcome_na <- outcome_st[!is.na(outcome_st[,17]),]
          disease_names <- names(outcome_na)[17]
          hospital_names <- names(outcome_na)[2]
          index <- with(outcome_na, order(outcome_na[disease_names], outcome_na[hospital_names]))
          best_ordered <- outcome_na[index, ]
          
          if (is.character(num) == TRUE) {
               if (num == "best") {
                    num <- 1
               }
               else if (num == "worst") {
                    num <- length(best_ordered[,17])
               }
               else {
                    num <- as.numeric(num)
               }
          }
          best_ordered[num, 2]
     }     
     else if (disease == "pneumonia"){
          outcome_na <- outcome_st[!is.na(outcome_st[,23]),]
          disease_names <- names(outcome_na)[23]
          hospital_names <- names(outcome_na)[2]
          index <- with(outcome_na, order(outcome_na[disease_names], outcome_na[hospital_names]))
          best_ordered <- outcome_na[index, ]
          
          if (is.character(num) == TRUE) {
               if (num == "best") {
                    num <- 1
               }
               else if (num == "worst") {
                    num <- length(best_ordered[,23])
               }
               else {
                    num <- as.numeric(num)
               }
          }
          best_ordered[num, 2]
     }
     }