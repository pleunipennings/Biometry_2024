
setwd("/Users/pleunipennings/Documents/GitHub/Biometry_2024")

Data = read.csv("oct22_survey.csv")

View(Data)

##Make table
table(Data$Are.you.vegetarian., Data$Do.you.like.broccoli.)

###FIND THE STRANGE ENTRIES
unique(Data$Are.you.vegetarian.)

Data$Are.you.vegetarian.[Data$Are.you.vegetarian.=="No "]<-"No"
#check the table again: 
table(Data$Are.you.vegetarian., Data$Do.you.like.broccoli.)

###FIND MISSING DATA
which(Data$Are.you.vegetarian.=="")
#Remove line with missing data
Data<- Data[which(Data$Are.you.vegetarian.!=""),]
#check the table again: 
table(Data$Are.you.vegetarian., Data$Do.you.like.broccoli.)

#Perform chi square test 
chisq.test(Data$Are.you.vegetarian., Data$Do.you.like.broccoli.)

