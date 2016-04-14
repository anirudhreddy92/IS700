
# leaflet(crime.data[Description == "LARCENY"]) %>%
#   addProviderTiles("CartoDB.Positron") %>%
#   addCircleMarkers(lng = ~longitude, lat = ~latitude, radius = 5, fillColor = "darkred", 
#                    popup = ~Weapon, fillOpacity = 0.5, stroke = F)

ggplot(crime.data,aes(longitude, latitude,color=Weapon))+geom_jitter()

ggplot(crime.data, aes(x=longitude, y=latitude, group=Weapon)) +
  geom_polygon(fill="white", colour="black")

ggplot(crime.data, aes(x=longitude, y=latitude)) +
geom_path() + coord_map("mercator")


qmplot(longitude, latitude, data = crime.data, maptype = "toner-lite",
       geom = "density2d", color = I("red"))

#manuel-http://amunategui.github.io/ggmap-example/
map<-get_map(location='baltimore', zoom=12, maptype = c("terrain","satellite"),
             source='google',color='color')
ggmap(map) + geom_point(
  aes(x=longitude, y=latitude, show_guide = TRUE, colour=as.numeric(TimeBin)), 
  data=crime.data[(format(crime.data$CrimeDate,"%Y"))==2015], alpha=.2, na.rm = T)  + 
  scale_color_gradient(low="beige", high="Red")

# density plots -----------------------------------------------------------

qplot(longitude,latitude, data = crime.data[Weapon == "FIREARM" & (format(crime.data$CrimeDate,"%Y"))==2015 
                                            ,.(longitude,latitude)], geom = 'density2d')

Map <- qmap('baltimore', zoom = 14)
Map

#Evening Morning Night Noon
Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[TimeBin == "Evening" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                                                     !is.na(longitude),.(longitude,latitude)],
                     geom='polygon')

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[TimeBin == "Night" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                                                     !is.na(longitude),.(longitude,latitude)],
                     geom='polygon')

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[TimeBin == "Morning" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                                                     !is.na(longitude),.(longitude,latitude)],
                     geom='polygon')

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[TimeBin == "Noon" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                                                     !is.na(longitude),.(longitude,latitude)],
                     geom='polygon')



#Fall Spring Summer Winter
Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Fall" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                                                     !is.na(longitude),.(longitude,latitude)],
                     geom='polygon')

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Spring" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                                                     !is.na(longitude),.(longitude,latitude)],
                     geom='polygon')

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Summer" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                                                     !is.na(longitude),.(longitude,latitude)],
                     geom='polygon')

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Fall" & (format(crime.data$CrimeDate,"%Y"))==2014 &
                                                     !is.na(longitude),.(longitude,latitude,Weapon == c("SHOOTING","HOMICIDE"))],
                     geom='polygon')+facet_wrap(~Weapon)


Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Summer"  & !is.na(longitude),
                                                   .(longitude,latitude,TimeBin,Year= format(crime.data$CrimeDate,"%Y"))],
                     geom='polygon')+facet_wrap(~Year)

Map + stat_density2d(aes(x=longitude,y=latitude,fill = ..level.., alpha = ..level..),
                     size=2,bins=5,data=crime.data[season == "Winter"  &
                                                     !is.na(longitude),.(longitude,latitude,Description)],
                     geom='polygon')+facet_wrap(~Description)
