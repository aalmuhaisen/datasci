# Getting Data Ready
# Lec 2
ucscDb <- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
results <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)
hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu") 
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
dbListFields(hg19, "affyU133Plus2") #list all the tables that contain this variable.
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10)
dbClearResult(query)
dim(affyMisSmall)

#Q1
library(httr)
oauth_endpoints("github")
myapp <- oauth_app("github",
                   key = "7af28a464e4e2a517d70",
                   secret = "e6fb2fb1e7244190c615289b6981b2ee89cd6a74")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)[[11]]$created_at

#Q2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv","~/Documents/R/datasci/acs.csv")
acs <- read.csv.sql("~/Documents/R/datasci/acs.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")

#Q3
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")

#Q4
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
html <- htmlTreeParse(url, useInternalNodes=T)
# 45 31 7 25

#Q5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for","~/Documents/R/datasci/wksst8110.for")
wksst8110 <- read.fwf("~/Documents/R/datasci/wksst8110.for",widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4),skip = 4, header = F)
sum(wksst8110[4])

# lec 3

#restdata %in% c(x,y)
#xtabs for frequency tables
s1 <- seq(1, 10, by = 2); s1
s2 <- seq(1, 10, length = 3); s2
x <- c(1, 3, 8, 25, 100); seq(along = x)

#resrData$nearMe = restData$neighborhood %in% c(x,y)
#table(restData$nearMe)

#restData$ZipGroups = cut(restData$ZipCode, break = quantile(restData$ZipCode))
#table(restData$ZipGroups)
#table(restData$ZipGroups, restData$ZipCode)

#easier ethod is using the cut2 function in Hmisc package 
#library(Hmisc)
#restData$ZipGroups = cut2(restData$ZipCode, g=4)
#table(restData$ZipGroups)

#grep grepl sub gsub are useful functions to deal with missed up data
#use foremat for date foremat(d2, "%a, %b, %d")
#x=c("1jan1960","31mar1970"); z=as.Date(x,"%d%b%Y")

# Quiz 3
library("dplyr")

#Q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv","~/Documents/R/datasci/uscomm.csv")
uscomm <- read.csv("uscomm.csv")
agricultureLogical <- uscomm$ACR==3 & uscomm$AGS==6
which(agricultureLogical)

#Q2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg","~/Documents/R/datasci/jeff.jpg")
library("jpeg")
quantile(readJPEG("jeff.jpg", native = TRUE),probs = c(.30, .80))

#Q3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv","~/Documents/R/datasci/gdp.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv","~/Documents/R/datasci/fedstat.csv")
gdp <- read.csv("gdp.csv")
colnames(gdp)[1] <- "CountryCode"
fedstats <- read.csv("fedstat.csv")
gdpfedstat <- merge(gdp, fedstats)
gdpfedstat$Gross.domestic.product.2012 = as.numeric(as.character(gdpfedstat$Gross.domestic.product.2012))
gdpfedstat$X.3 = as.numeric((gdpfedstat$X.3))
gdpfedstat <- gdpfedstat[!is.na(gdpfedstat$Gross.domestic.product.2012),]
NROW(gdpfedstat)
gdpfedstat <- gdpfedstat[order(as.integer(gdpfedstat$Gross.domestic.product.2012), decreasing = TRUE),]
gdpfedstat[13,4]

#Q4
mean(gdpfedstat[which(gdpfedstat$Income.Group=="High income: OECD"),2])
mean(gdpfedstat[which(gdpfedstat$Income.Group=="High income: nonOECD"),2])

#Q5
sum(tail(gdpfedstat$Income.Group,38)=="Lower middle income")


# Lec 4
#"stringr" is a good library to deal with strings
#tolowe(names(x)) & toupper
#strsplit(names(x),"\\.") space for dots
#[[1]][1] take out first element of the first row
#sub("_","",names(X),) drop _ out of names(x) use gsub for multiple _
#grep("ddd",x$X) look for ddd. value=T to get the value instead of row#
#table(grepl("ddd",x$X)) look for ddd and return a summary table of F/T
#x2 < - x[!grepl("ddd",x$X),] subset where ddd doesn't appear
#paste0 to concatinate
# to search for strings, ^ for the beginig of the line, $ for the end. 
#[Xx] size nuteral, - for sequence (0-9, a-z)
#[^?.]$ look for lines that doesn't end with ?.
#"." to look for any char (i.e ? ; , . \)
# | for or
#+([a-zA-Z]+) +\1 + to finds repetitve words
#lubridate package has some cool functions to deal with dates

#Quiz 4

#Q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "~/Documents/R/datasci/USsur.csv")
USsur <- read.csv("USsur.csv")
USsurSplit <- strsplit(names(USsur),"wgtp")
USsurSplit[123]

#Q2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "~/Documents/R/datasci/GDPdata.csv")
GDPdata <- read.csv("GDPdata.csv")
GDPdata$X.3 <- gsub(",","",GDPdata$X.3)
mean(as.numeric(GDPdata[5:194,5]))

#Q3
grep("^United",GDPdata$X.2, value = T)

#Q4
NROW(grep("Fiscal year end: June 30",gdpfedstat$Special.Notes))

#Q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
NROW(which(format(sampleTimes,'%Y')=="2012"))
NROW(which(format(sampleTimes,'%a%Y')=="Mon2012"))


