## File:        crime_data.R ####
## Author:      anirudh, UMBC
## Description: Stuff goes here
## (c) Anirudh , All Rights Reserved

# from[ where, select|update, group by ][...] --data.table format--


# data loading  ------------------------------------------------------------
system.time(crime.data <- fread("D:/IS733/R/data/BPD_Part_1_Victim_Based_Crime_Data.csv"))
head(crime.data)    #first 6 rows
names(crime.data)   #column names
lapply(crime.data,class)  #check class of each column #sapply(crime.data,class) also works
str(crime.data) #structure of data-colname,class,starting elements
#order CrimeCode table 
as.data.frame(sort(table(crime.data$CrimeCode))) 
crime.data[as.character(Weapon) == "",Weapon := "NA"] 
crime.data$Weapon <- as.factor(crime.data$Weapon)
crime.data[Weapon == "NA",Weapon := NA] 




# data preprocessing ------------------------------------------------------
#data transformation-crimedate,crimetime,location->lat+long,crimecode->decode
crime.data$CrimeDate <- as.Date(crime.data$CrimeDate, "%m/%d/%Y") 
crime.data$CrimeTime <- format(strptime(crime.data$CrimeTime,"%H:%M"),"%H:%M")

#data cleaning-imputation,smoothing,outliers,inconsistencies


#data integration-location+district+neighbornood
crime.data$latitude  <- substring(backup$`Location 1`,2,13)
crime.data$longitude <- substring(backup$`Location 1`,17,30)
crime.data[, `Location 1`:= NULL]

#data reduction

#data summarization


# data modification -------------------------------------------------------

#split CrimeDate into Seasons and add Season column
hist(as.numeric(format(crime.data$CrimeDate,"%m"))) #also cross refer Tableau 
  #split is done according to astronomical changes
  #http://www.timeanddate.com/calendar/aboutseasons.html
getSeason <- function(DATES) {
  WS <- as.Date("2012-12-15", format = "%Y-%m-%d") # Winter Solstice
  SE <- as.Date("2012-3-15",  format = "%Y-%m-%d") # Spring Equinox
  SS <- as.Date("2012-6-15",  format = "%Y-%m-%d") # Summer Solstice
  FE <- as.Date("2012-9-15",  format = "%Y-%m-%d") # Fall Equinox
  
  # Convert dates from any year to 2012 dates
  d <- as.Date(strftime(DATES, format="2012-%m-%d"))
  
  ifelse (d >= WS | d < SE, "Winter",
          ifelse (d >= SE & d < SS, "Spring",
                  ifelse (d >= SS & d < FE, "Summer", "Fall")))
}

crime.data$season <- getSeason(crime.data$CrimeDate)

#split CrimeTime into Period in day and add Period column
#head(format(as.POSIXlt(crime.data$CrimeTime,format="%H:%M"),"%H:%M"))
# cat(sum(is.na(crime.data$CrimeTime))*100/nrow(crime.data),"%")
# 1.345 %
crime.data[as.numeric(substr(crime.data$CrimeTime,1,2))>= 02 & as.numeric(substr(crime.data$CrimeTime,1,2)) <= 07,TimeBin := "Morning"]
crime.data[as.numeric(substr(crime.data$CrimeTime,1,2))>= 08 & as.numeric(substr(crime.data$CrimeTime,1,2)) <= 14,TimeBin := "Noon"]
crime.data[as.numeric(substr(crime.data$CrimeTime,1,2))>= 15 & as.numeric(substr(crime.data$CrimeTime,1,2)) <= 18,TimeBin := "Evening"]
crime.data[as.numeric(substr(crime.data$CrimeTime,1,2))>= 19 & as.numeric(substr(crime.data$CrimeTime,1,2)) <= 23,TimeBin := "Night"]
crime.data[as.numeric(substr(crime.data$CrimeTime,1,2))>= 00 & as.numeric(substr(crime.data$CrimeTime,1,2)) <= 01,TimeBin := "Night"]
crime.data[is.na(CrimeTime) ,TimeBin := NA]

crime.data$Description <- as.factor(crime.data$Description)
crime.data$District    <- as.factor(crime.data$District)
crime.data$season      <- as.factor(crime.data$season)
crime.data$TimeBin     <- as.factor(crime.data$TimeBin)
crime.data$latitude    <- as.numeric(crime.data$latitude,options("digits"=8))
crime.data$longitude   <- as.numeric(crime.data$longitude,options("digits"=8))


#split CrimeCode(cross check with Description) into Crime and add Crime column




