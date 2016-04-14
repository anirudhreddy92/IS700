# Kmeans FIREARM------------------------------------------------------------------

km <- kmeans(crime.data[Weapon == "FIREARM" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                          !is.na(longitude),.(longitude,latitude)], centers=4, nstart=10)
km

plot(crime.data[Weapon == "FIREARM" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                  !is.na(longitude),.(longitude,latitude)], col=km$cluster+1,pch=16)
points(km$centers, pch=3, cex=3) # this adds the centroids
text(km$centers, labels=1:4, pos=2)


# Kmeans TimeBin -------------------------------------------------------------

km <- kmeans(crime.data[TimeBin == "Evening" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                          !is.na(longitude),.(longitude,latitude)], centers=8, nstart=10)
km

plot(crime.data[TimeBin == "Evening" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                  !is.na(longitude),.(longitude,latitude)], col=km$cluster+1,pch=16)
points(km$centers, pch=3, cex=3) # this adds the centroids
text(km$centers, labels=1:4, pos=2)

# Kmeans TimeBin noon (Evening Morning Night Noon) -----------------------------------------------------

km <- kmeans(crime.data[TimeBin == "Night" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                          !is.na(longitude),.(longitude,latitude)], centers=8, nstart=10)
km

plot(crime.data[TimeBin == "Night" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                  !is.na(longitude),.(longitude,latitude)], col=km$cluster+1,pch=16)
points(km$centers, pch=3, cex=3) # this adds the centroids
text(km$centers, labels=1:4, pos=2)

# Kmeans TimeBin Fall ( Fall Spring Summer Winter) -----------------------------------------------------

km <- kmeans(crime.data[season == "Fall" & (format(crime.data$CrimeDate,"%Y"))==2015 &
                          !is.na(longitude),.(longitude,latitude)], centers=4, nstart=10)
km

plot(crime.data[season == "Fall" & (format(crime.data$CrimeDate,"%Y"))==2014 &
                  !is.na(longitude),.(longitude,latitude)], col=km$cluster+1,pch=16)
points(km$centers, pch=3, cex=3) # this adds the centroids
text(km$centers, labels=1:4, pos=2)


# dbscan ------------------------------------------------------------------
p_load(dbscan)
db <- dbscan(crime.data[ (format(crime.data$CrimeDate,"%Y"))==2015,
                        .(longitude,latitude)], eps=0.005, minPts= 100 )
db

plot(crime.data[ (format(crime.data$CrimeDate,"%Y"))==2015,
                .(longitude,latitude)], col=db$cluster+2,pch=16)
points(km$centers, pch=3, cex=3) # this adds the centroids
#text(km$centers, labels=1:4, pos=2)

kNNdistplot(crime.data[(format(crime.data$CrimeDate,"%Y"))==2014,
                       .(longitude,latitude)], k = 3)



res <- optics(crime.data[ (format(crime.data$CrimeDate,"%Y"))==2015,
                         .(longitude,latitude)], eps=0.005, minPts= 100)

res

res$order

plot(res)

res <- optics_cut(res, eps = .07)
res


db <- dbscan(crime.data[TOC == "ARSON" ,
                         .(longitude,latitude)], eps=0.01, minPts= 50 )
db

plot(crime.data[TOC == "ARSON" ,
                .(longitude,latitude)], col=db$cluster+2,pch=16)