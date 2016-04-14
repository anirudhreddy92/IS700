#http://www.saedsayad.com/data_mining_map.htm

ggplot(crime.data[Weapon != "NA" ,], aes(Weapon)) + geom_bar(aes(fill=TimeBin))
ggplot(crime.data[Weapon != "NA" ,], aes(TimeBin)) + geom_bar(aes(fill=Weapon))
ggplot(crime.data[Weapon %in% c("FIREARM","KNIFE","OTHER") ,], aes(TimeBin)) + geom_bar(aes(fill=Weapon))


ggplot(crime.data[Weapon != "NA" ,], aes(Weapon)) + geom_bar(aes(fill=season))
ggplot(crime.data[Weapon != "NA" ,], aes(season)) + geom_bar(aes(fill=Weapon))
ggplot(crime.data[Weapon %in% c("FIREARM","KNIFE","OTHER") ,], aes(season)) + geom_bar(aes(fill=Weapon))

ggplot(crime.data[Weapon != "NA" ,], aes(Weapon)) + geom_bar(aes(fill=District))
ggplot(crime.data[Weapon != "NA" ,], aes(District)) + geom_bar(aes(fill=Weapon)) +
  theme(axis.text.x =element_text(angle=90))
ggplot(crime.data[Weapon %in% c("FIREARM","KNIFE","OTHER") ,], aes(District)) +
  geom_bar(aes(fill=Weapon),position = "dodge") + 
  theme(axis.text.x =element_text(angle=90)) 

ggplot(crime.data, aes(Description)) + geom_bar(aes(fill=season), 
                                                                  position = "dodge") + 
  theme(axis.text.x =element_text(angle=90)) 

ggplot(crime.data, aes(Description)) + geom_bar(aes(fill=Weapon), 
                                                                  position = "dodge") + 
  theme(axis.text.x =element_text(angle=90)) 







ggplot(crime.data[Weapon != "NA" ,], aes(Description)) + geom_bar(aes(fill=TimeBin), 
                                                                  position = "dodge") + 
  theme(axis.text.x =element_text(angle=90))
ggplot(crime.data[Weapon %in% c("FIREARM","KNIFE","OTHER") ,], aes(Description)) + geom_bar(aes(fill=Weapon))


ggplot(crime.data[ ,], aes(Description)) +
  geom_bar(aes(fill=District),position = "dodge") + 
  theme(axis.text.x =element_text(angle=90)) 
ggplot(crime.data[ ,], aes(District)) + 
  geom_bar(aes(fill=Description),position = "dodge") + 
  theme(axis.text.x =element_text(angle=90)) 








