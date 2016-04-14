crime.data[Description %in% c("ASSAULT BY THREAT","COMMON ASSAULT","AGG. ASSAULT"),TOC := "ASSAULT"]
crime.data[Description %in% c("BURGLARY","AUTO THEFT","LARCENY","LARCENY FROM AUTO"),TOC := "THEFT"]
crime.data[Description %in% c("ROBBERY - STREET","ROBBERY - COMMERCIAL","ROBBERY - RESIDENCE","ROBBERY - CARJACKING"),TOC := "ROBBERY"]
crime.data[Description %in% c("SHOOTING"),TOC := "SHOOTING"]
crime.data[Description %in% c("HOMICIDE"),TOC := "HOMICIDE"]
crime.data[Description %in% c("RAPE"),TOC := "RAPE"]
crime.data[Description %in% c("ARSON"),TOC := "ARSON"]
crime.data$TOC <- as.factor(crime.data$TOC)


str(crime.data)

# Q1 ----------------------------------------------------------------------
#relation between season and type of crime(Description)
#performing chi-square test
chisq.test(table(crime.data$Description,crime.data$season),na.trim())
ggplot(crime.data, aes(Description)) + geom_bar(aes(fill=season), 
                                                position = "dodge") + 
  theme(axis.text.x =element_text(angle=90)) 


# Q2 ----------------------------------------------------------------------
#relation between District and type of crime(Description)
-----#combine types of crime to answer this
  ggplot(crime.data[ ,], aes(District)) + 
  geom_bar(aes(fill=TOC),position = "dodge") + 
  theme(axis.text.x =element_text(angle=90))
Map <- qmap('baltimore', zoom = 14)
options(na.action = 'na.pass')
Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level..,alpha = ..level..),
                     size=2,bins=5,data=crime.data[!is.na(longitude),.(longitude,latitude,TOC)],
                     geom='polygon')+facet_wrap(~TOC)



# Q3 ----------------------------------------------------------------------
#relation between TimeBin and type of crime(Description)
fisher.test(table(crime.data$Description,crime.data$TimeBin),simulate.p.value = TRUE,na.trim())
ggplot(crime.data[], aes(TOC)) + geom_bar(aes(fill=TimeBin), 
                                                                  position = "dodge") + 
  theme(axis.text.x =element_text(angle=90))
-----#combine types of crime to answer this
  
  
  
  

# Q4 ----------------------------------------------------------------------
#season and subset into TimeBin (map intensity)
Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Winter"  & !is.na(TimeBin) &
                                                     !is.na(longitude),.(longitude,latitude,TimeBin)],
                     geom='polygon')+facet_wrap(~TimeBin)

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Fall"  & !is.na(TimeBin) &
                                                     !is.na(longitude),.(longitude,latitude,TimeBin)],
                     geom='polygon')+facet_wrap(~TimeBin)

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Spring"  & !is.na(TimeBin) &
                                                     !is.na(longitude),.(longitude,latitude,TimeBin)],
                     geom='polygon')+facet_wrap(~TimeBin)

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Summer"  & !is.na(TimeBin) &
                                                     !is.na(longitude),.(longitude,latitude,TimeBin)],
                     geom='polygon')+facet_wrap(~TimeBin)
#-------------------------------PPT PLOTS------========------------------------
# theme(axis.title.y = element_text(colour="grey20",size=20,face="bold"),
#       axis.text.x = element_text(colour="grey20",size=20,face="bold"),
#       axis.text.y = element_text(colour="grey20",size=20,face="bold"),  
#       axis.title.x = element_text(colour="grey20",size=20,face="bold"))



ggplot(crime.data,aes(Description)) + geom_bar( ) + theme(axis.text.x =element_text(angle=90)) + ggtitle("Type of Crime") +
  theme(axis.text.x = element_text(colour="grey20",size=15,face="bold"))

ggplot(crime.data,aes(District)) + geom_bar(width=.5) + theme(axis.text.x =element_text(angle=90)) + ggtitle("Crimes on Districts") +
  theme(axis.text.x = element_text(colour="grey20",size=15,face="bold"))

ggplot(crime.data,aes(Weapon)) + geom_bar(width=.5) + theme(axis.text.x =element_text(angle=90)) + ggtitle("Weapon Used") +
  theme(axis.text.x = element_text(colour="grey20",size=15,face="bold"))

ggplot(crime.data,aes(season)) + geom_bar(width=.5) + theme(axis.text.x =element_text(angle=90)) + ggtitle("Season") +
  theme(axis.text.x = element_text(colour="grey20",size=15,face="bold"))

ggplot(crime.data,aes(TimeBin)) + geom_bar(width=.5) + theme(axis.text.x =element_text(angle=90)) + ggtitle("Time") +
  theme(axis.text.x = element_text(colour="grey20",size=15,face="bold"))

# 2D

ggplot(crime.data, aes(Description)) + geom_bar(aes(fill=season), 
                                                position = "dodge") + 
  theme(axis.text.x =element_text(angle=90)) + ggtitle("Type of Crime and Season") +
  theme(axis.text.x = element_text(colour="grey20",size=15,face="bold"))

ggplot(crime.data, aes(Description)) + geom_bar(aes(fill=TimeBin), 
                                                position = "dodge") + 
  theme(axis.text.x =element_text(angle=90)) + ggtitle("Type of Crime and Time") +
  theme(axis.text.x = element_text(colour="grey20",size=15,face="bold"))


ggplot(crime.data, aes(District)) + geom_bar(aes(fill=TOC), 
                                                position = "dodge") + 
  theme(axis.text.x =element_text(angle=90)) + ggtitle("Type of Crime and District") +
  theme(axis.text.x = element_text(colour="grey20",size=15,face="bold"))


Map <- qmap('baltimore', zoom = 14)

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[!is.na(longitude),.(longitude,latitude,TOC)],
                     geom='polygon') + facet_wrap(~TOC)

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[!is.na(longitude),.(longitude,latitude,season)],
                     geom='polygon') + facet_wrap(~season)

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[!is.na(longitude),.(longitude,latitude,TimeBin)],
                     geom='polygon') + facet_wrap(~TimeBin)


Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[TimeBin == "Noon" & !is.na(longitude),.(longitude,latitude,TimeBin)],
                     geom='polygon') + facet_wrap(~TimeBin)



Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Winter"  & !is.na(TimeBin) &
                                                     !is.na(longitude),.(longitude,latitude,TimeBin)],
                     geom='polygon')+facet_wrap(~TimeBin)

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Fall"  & !is.na(TimeBin) &
                                                     !is.na(longitude),.(longitude,latitude,TimeBin)],
                     geom='polygon')+facet_wrap(~TimeBin)

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Spring"  & !is.na(TimeBin) &
                                                     !is.na(longitude),.(longitude,latitude,TimeBin)],
                     geom='polygon')+facet_wrap(~TimeBin)

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Summer"  & !is.na(TimeBin) &
                                                     !is.na(longitude),.(longitude,latitude,TimeBin)],
                     geom='polygon')+facet_wrap(~TimeBin)




















 
  