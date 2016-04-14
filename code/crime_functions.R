## File:        crime_data.R ####
## Author:      anirudh, UMBC
## Description: Stuff goes here
## (c) Anirudh , All Rights Reserved

options("scipen"=100, "digits"=4)
# Libraries -------------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(arules, arulesViz, cluster, caret, cluster, data.table, 
               e1071, ggplot2,ggmap,maps, mclust, party,
               randomForest, rattle, 
               RDSTK, reshape, RGtk2, 
               shiny, stringi, 
               weatherData, tree, xlsx)



if (!require("pacman")) install.packages("pacman")
pacman::p_load(arules, arulesViz, cluster, caret, cluster, colorspace, 
               compareGroups, data.table, devtools, 
               e1071, flexclust,
               FactoMineR, fpc, geonames, ggplot2, graph, ggmap, gmodels, googleVis,
               Hmisc, igraph,
               inTrees, knitr, lubridate, mclust, odfWeave, party, pls, pmml,
               randomForest, rattle, 
               RDSTK, reshape, RGtk2,rgl, ROCR,RODBC, RRF, scatterplot3d, 
               shiny, sqldf, SnowballC, stringi, TH.data, topicmodels, tm, twitteR, 
               weatherData, wordcloud, tree, xlsx)



 
