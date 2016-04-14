## File:        month_data_data.R ####
## Author:      RPI, Grad Intern
## Description: Stuff goes here
## (c) 2015 Laureate International Universities, All Rights Reserved

# from[ where, select|update, group by ][...] --data.table format--


# data loading and sampling ------------------------------------------------------------
system.time(lead.data <- fread("M:/RPI - Marketing/Team/Anirudh/lead Data2_Fixed.txt"))
#(5/100)% of main set
system.time(ld.sample10 <- lead.data[sample(nrow(lead.data), nrow(lead.data)*10/100,
                                            replace = F), ])
rm(lead.data)


# Pre processing Data -----------------------------------------------------

# Re-naming Columns
ld.sample <- rename(ld.sample, c(V1="Create_Date_Timestamp"  ,
                                 V2="State"     ,
                                 V3="International_Flag"       ,        
                                 V4="Country_Desc"   ,
                                 V5="Current_Onyx_Status"  ,  
                                 V6="Resolution_1_Desc",         
                                 V7="Activity_Cd"   ,              
                                 V8="Activity_Name"  ,         
                                 V9="Vendor_desc"   ,  
                                 V10="Channel_map_1"    ,           
                                 V11="College_name"  , 
                                 V12="Program_Name"  ,              
                                 V13="Level_Desc" ,                 
                                 V14='EA_Name'  ,          
                                 V15="Location",               
                                 V16="Start_date" ,
                                 V17="Last_Update_Date" ,         
                                 V18="Dormant_Date "   ,   
                                 V19="Qualified_Date "   ,         
                                 V20="Profile_Create_Date",
                                 V21="Inc_App_Date"          ,
                                 V22="Contact_Date",            
                                 V23="Comp_App_Date"  ,        
                                 V24="Reserved_Date")
)

#2012-11-15 09:07:07.190->2012-11-15
ld.sample$Create_Date_Timestamp <- substr(ld.sample$Create_Date_Timestamp, 1, 10)
ld.sample$Start_date            <- substr(ld.sample$Start_date, 1, 10)
ld.sample$`Qualified_Date `     <- substr(ld.sample$`Qualified_Date `, 1, 10)

#remove rows starting with Cante
grep("^Cante", ld.sample$Current_Onyx_Status) #check
ld.sample <- ld.sample[!grep("^Cante", ld.sample$Current_Onyx_Stat7us), ] #remove
unique(ld.sample$Current_Onyx_Status)

#date converting
ld.sample$Create_Date_Timestamp <- as.Date(ld.sample$Create_Date_Timestamp) #2011-12-08
ld.sample$Reserved_Date <- as.Date(ld.sample$Reserved_Date, "%Y%m%d") #20120107
ld.sample$Comp_App_Date <- as.Date(ld.sample$Comp_App_Date, "%Y%m%d") #20120107

ld.sample$Start_date <- gsub("-99999999", NA, ld.sample$Start_date)
ld.sample$Start_date <- gsub("NULL", NA, ld.sample$Start_date)
ld.sample$Start_date <- substr(ld.sample$Start_date, 1, 10)
ld.sample$Start_date <- as.Date(ld.sample$Start_date, "%Y-%m-%d") #20120107

#adding columns
ld.analyis[, c("Reserved_Date") := list(ld.sample$Reserved_Date)]

ld.sample[,Create_Month        := as.factor(format(ld.sample$Create_Date_Timestamp,
                                                   "%b"))]
ld.sample[,Reserve_Month       := as.factor(format(ld.sample$Reserved_Date,
                                                   "%b"))]
ld.sample[,Reserve_Year        := as.factor(format(ld.sample$Reserved_Date,
                                                   "%Y"))]
ld.sample[,Create_Year         := as.factor(format(ld.sample$Create_Date_Timestamp,
                                                   "%Y"))]
ld.sample[,Reserve_Month_Year  := as.factor(format(ld.sample$Create_Date_Timestamp,
                                                   "%b-%Y"))]
ld.sample[,Diff_Time           := round(difftime(ld.sample$Reserved_Date,
                                                 ld.sample$Create_Date_Timestamp,
                                                 units="weeks"),3)]

#subsetting based on Intl Flag
ld.int <- ld.sample[International_Flag=="Y"]

ld.us  <- ld.sample[International_Flag=="N", .(Create_Date_Timestamp,
                                               State,
                                               Current_Onyx_Status,
                                               Vendor_desc,
                                               Channel_map_1,
                                               College_name,
                                               Program_Name,
                                               Level_Desc,
                                               Start_date,
                                               Reserved_Date )
                    ]




