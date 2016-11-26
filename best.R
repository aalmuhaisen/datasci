#This funcion will find the best hospital in a givin state in treating a specific disease
best <- function(state, disease) {
     outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
     outcome[,11] <- suppressWarnings(as.numeric(outcome[,11]))
     outcome[,17] <- suppressWarnings(as.numeric(outcome[,17]))
     outcome[,23] <- suppressWarnings(as.numeric(outcome[,23]))
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
     else if (disease == "heart attack") {
          outcome_na <- outcome_st[!is.na(outcome_st[,11]),]
          best_hospitals <- outcome_na[which(outcome_na[,11] == min(outcome_na[,11])),2]
          if (length(best_hospitals) > 1) {
               ordered <- sort(best_hospitals)
               ordered[1]
          }
          else {
               best_hospitals
          }
     }
     
     else if (disease == "heart failure") {
          outcome_na <- outcome_st[!is.na(outcome_st[,17]),]
          best_hospitals <- outcome_na[which(outcome_na[,17] == min(outcome_na[,17])),2]
          if (length(best_hospitals) > 1) {
               ordered <- sort(best_hospitals)
               ordered[1]
          }
          else {
               best_hospitals
          }
     }     
     else if (disease == "pneumonia"){
          outcome_na <- outcome_st[!is.na(outcome_st[,23]),]
          best_hospitals <- outcome_na[which(outcome_na[,23] == min(outcome_na[,23])),2]
          if (length(best_hospitals) > 1) {
               ordered <- sort(best_hospitals)
               ordered[1]
          }
          else {
               best_hospitals
          }
     }
     else {
          print("Something wrong dude!")
     }
}