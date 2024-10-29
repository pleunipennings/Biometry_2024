
########### STEP 1
## Set your working directory and read the elephant data
setwd("/Users/pleunipennings/Documents/GitHub/Biometry_2024")
#Read data
Elephants <- read.csv("elephant_poaching-v2-noid.csv")
View(Elephants) #check that it looks OK

########### STEP 2
# Create 1-variable plot for sex - how many males and females in the dataset? 
ggplot(data = Elephants, aes(Sex))+
  geom_bar(aes(fill = Sex))

########### STEP 3 YOUR TASK 
# Create 1-variable plot for Years.of.sample.collection - how many datapoints from each time? 

########### STEP 4 plot histograms of tusklength 
#Plot distribution of tusk lengths
ggplot(data = Elephants, aes(x = Tusk.length..cm.)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Tusk Lengths", x = "Tusk Length (cm)", y = "Frequency") 

########### STEP 5 cool trick!  facet_wrap() 
#Plot distribution of tusk lengths
ggplot(data = Elephants, aes(x = Tusk.length..cm.)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Tusk Lengths", x = "Tusk Length (cm)", y = "Frequency") +
  facet_wrap(~Years.of.sample.collection, ncol = 1)

##Do you think the mean tusklength is different betwene 1966 and 2005? 

########### STEP 6 YOUR TASK change the color of the histogram fill 


########## STEP 7 Prep for T test 
###The first group
AllEle1966TL <- Elephants$Tusk.length..cm.[Elephants$Years.of.sample.collection=="1966-68"]

###The second group
AllEle2005TL <- Elephants$Tusk.length..cm.[Elephants$Years.of.sample.collection=="2005-13"]

########## STEP 7 Run T test 
t.test(AllEle1966TL, AllEle2005TL)

########## Is the mean different between 1966 and 2005? 

########## STEP 8 YOUR TASK: REPEAT STEPS 4, 5, 6, 7 but comparing Males vs Females


