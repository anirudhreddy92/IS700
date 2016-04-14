## File:        crime_data.R ####
## Author:      anirudh, UMBC
## Description: Stuff goes here
## (c) Anirudh , All Rights Reserved

#bining 1-100,100-1k,1k-10k,10k-..

d.agr <- daisy(crime.data[,.(Description,Weapon,District,season,TimeBin)],
               metric = "euclidean", stand = FALSE)
temp <- hclust(crime.data[,.(Description,Weapon,District,season,TimeBin)])




pairs(crime.data[,.(Description,Weapon,District,season,TimeBin)])
















#isolate paid channels for Walden Intl

ld.int.10.paidChannel <- ld.int.10[Channel_map_1 %in% c("Web - CPL Eduportals",
                                                        "Web - Search","Web - Display")]
#level and channel naive bayes for walden Intl

model <- naiveBayes(Create_Month  ~ Start_Month,
                    data = ld.int.10.paidChannel[Level_Desc == "BS" &
                                                   Channel_map_1 == "Web - CPL Eduportals" ])
round(model$tables$Start_Month,3)
write.csv(round(model$tables$Start_Month,3),"Web - CPL Eduportals.csv")


#level and channel naive bayes for walden US after 2013

model <- naiveBayes(Create_Month  ~ Start_Month,
                    data = ld.sample10[Level_Desc == "PhD" & 
                                       International_Flag == "N" &
                                       Channel_map_1 == "Web - Display" ])
round(model$tables$Start_Month,3)
write.csv(round(model$tables$Start_Month,3),"US.PhD.Web - Display.csv")

data<-data[,.(International_Flag,Channel_map_1,Level_Desc,Create_Month,Start_Month)]
## save a single object to file
saveRDS(data, "walden.rds")
## restore it under a different name
walden <- readRDS("walden.rds")
