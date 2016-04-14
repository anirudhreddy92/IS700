processedbkup <- crime.data
crime.data$Weapon <- gsub("NA",NA,crime.data$Weapon)



library(arules)
rules <- apriori(crime.data[,.(Description,Weapon,District,season,TimeBin)])
detach(package:tm, unload=TRUE)
inspect(rules)
plot(rules, method="graph", control=list(type="items"))

##

rules2 <- apriori(crime.data[Weapon != "NA" & Description != "COMMON ASSAULT" , 
                             .(Description,Weapon,District,season,TimeBin)])
rules2 <- apriori(crime.data[ Description != "COMMON ASSAULT" , 
                             .(Description,Weapon,District,season,TimeBin)], 
                  parameter = list(supp = 0.2, conf = 0.5, target = "rules"))

#detach(package:tm, unload=TRUE)
inspect(rules2)
plot(rules2, method="graph", control=list(type="items"))




# new rules ---------------------------------------------------------------

BPD_Part_1_Victim_Based_Crime_Data <- read.csv("D:/IS733/R/data/BPD_Part_1_Victim_Based_Crime_Data.csv",na.strings = c(""," "))
rulesdata <- data.table(BPD_Part_1_Victim_Based_Crime_Data)
library(arules)
rules <- apriori( rulesdata[Description == "COMMON ASSAULT",.(Description,as.factor(Post),Weapon,District,Neighborhood)],
                 parameter = list(conf = 0.5, target = "rules"))
#detach(package:tm, unload=TRUE)
inspect(rules)
plot(rules, method="graph", control=list(type="items"))



# ECLAT -------------------------------------------------------------------

itemsets <- eclat(crime.data[,.(Description,Weapon,District,season,TimeBin)],
                  parameter = list(supp = 0.1, maxlen = 15))
inspect(itemsets)



