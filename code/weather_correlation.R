## File:        crime_data.R ####
## Author:      anirudh, UMBC
## Description: Stuff goes here
## (c) Anirudh , All Rights Reserved

#Station                 State  ID    Lat    Lon   Elev  WMO
#Baltimore                  MD KBWI  39.18  -76.67   47 72406
#Maryland Science Center    MD KDMH  39.28  -76.61   19 99999
#Weather <- getWeatherForDate("KDMH",start_date = "2015-11-16", end_date = "2015-11-17")

#getting weather details for dates  "2010-01-01" till "2015-09-19"
weather_Full <- getWeatherForDate("KDMH", start_date = "2010-01-01", end_date = "2015-09-19", 
                  opt_detailed = TRUE, opt_all_columns = FALSE )
weather_Full$date <- format(strptime(weather_Full$Time,"%Y-%m-%d %H:%M:%S"),"%Y-%m-%d")
weather_Full$date <- as.Date(weather_Full$date,"%Y-%m-%d")
weather_Full$Hour <- format(strptime(weather_Full$Time,"%Y-%m-%d %H:%M:%S"),"%H")
weather_Full$Hour <- as.numeric(weather_Full$Hour)+1
weather_Full$Hour <- as.numeric(weather_Full$Hour)+1

# crime.data[CrimeDate == weather_Full$date & 
#              as.numeric(substr(crime.data$CrimeTime,1,2)) == weather_Full$Hour , 
#            Temperature := weather_Full$TemperatureF ]
# match(
#   interaction(crime.data$CrimeDate,weather_Full$date),
#   interaction(as.numeric(substr(crime.data$CrimeTime,1,2)), weather_Full$Hour)
# )  
  
crime.data[,Crime.hour:=as.numeric(substr(crime.data$CrimeTime,1,2))]

Weather_Crime_data <- merge(crime.data, weather_Full, 
                            by.x=c("CrimeDate", "Crime.hour"),
                            by.y=c("date", "Hour"), all.x=FALSE )

#277669-254175 -> 23494 ,3736 no time available 

Weather_Crime_data <- as.data.table(Weather_Crime_data)
Weather_Crime_data[,c("Crime.hour","Temperature","Time") := NULL]
summary(Weather_Crime_data$TemperatureF)
Weather_Crime_data$TemperatureF <- gsub("-9999",NA,Weather_Crime_data$TemperatureF)
Weather_Crime_data$TemperatureF <- as.numeric(Weather_Crime_data$TemperatureF)
summary(Weather_Crime_data$TemperatureF)



ggplot(data=Weather_Crime_data, aes(x=TemperatureF, y=`Total Incidents`, 
                                    fill=Description)) + geom_line()

ggplot(data=Weather_Crime_data, aes(x=TemperatureF, y=season, color=Description  )) + geom_bar() + geom_point()

ggplot(data=Weather_Crime_data,
       aes(x=TemperatureF, y=`Total Incidents`, colour=Description)) +
  geom_line()


