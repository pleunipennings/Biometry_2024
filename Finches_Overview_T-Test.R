#Step 1 is to to read the finch data from HHMI data explorer

#Set the working directory to the right folder
setwd("/Users/pleunipennings/Documents/GitHub/Biometry_2024")
#Load important libraries 
###(make sure they are installed using install.packages())
library(ggplot2)
library(tidyverse)

##Reading the data into a data frame
Finches <- read.csv("finches_in_galapagos-v2-noid.csv")
##Check that data look good
View(Finches)

##Creating a summary of the data we are interested in
FinchSummary <- Finches %>%
  group_by(Drought.survival) %>%
  summarize(mean_mass = mean(Body.mass..g., na.rm = TRUE), 
            median_mass = median(Body.mass..g., na.rm = TRUE),
            samplesize = n())


#Make a box plot with points
ggplot(Finches, aes(x = Drought.survival, 
                    y = Body.mass..g., 
                    fill = Drought.survival)) +
  geom_boxplot() +
  geom_point()+
  labs(title = "Boxplot of Body mass by Survival",
       x = "Drought.survival",
       y = "Body.mass") +
  theme_minimal()

# Create two lists of numbers to be used in the t test 
SurvivorsMass <- Finches$Body.mass..g.[Finches$Drought.survival=="survivor"]
NonSurvivorsMass <- Finches$Body.mass..g.[Finches$Drought.survival=="nonsurvivor"]

#Compare variances
var(SurvivorsMass)
var(NonSurvivorsMass)

#T test with setting variance equal
t.test(x = SurvivorsMass, y = NonSurvivorsMass, var.equal = TRUE)

#T test with setting variance not equal
t.test(x = SurvivorsMass, y = NonSurvivorsMass, var.equal = FALSE)

#Are the data normally distributed? 

#1. Make histogram to see if it looks normal
par(mfrow = c(2, 1))
hist(SurvivorsMass, xlim = c(12, 24), breaks = 1:24)
hist(NonSurvivorsMass, xlim = c(12, 24),  breaks = 1:24)


#2. Create Q-Q plot to see if the data look normal
par(mfrow = c(1, 1))
qqnorm(c(SurvivorsMass, NonSurvivorsMass), main = "Q-Q Plot")
qqline(c(SurvivorsMass, NonSurvivorsMass), col = "red")  # Add reference line


#3. Use a test for normality 
shapiro.test(c(SurvivorsMass, NonSurvivorsMass))

# If data not normally distributed, better use a non-parametric test
#Use non-parametric test 
#This performs a Mann Whitney U test aka Wilcoxon rank sum test
wilcox.test(SurvivorsMass, NonSurvivorsMass)

# Alternative: use bootstrap 
#Get real difference
realdifference = mean(Finches$Body.mass..g.[Finches$Drought.survival=="survivor"])-
  mean(Finches$Body.mass..g.[Finches$Drought.survival=="nonsurvivor"])

#Repeat 1000 times
#Randomize data and calculate difference
RandomDifferences <- c()
for (i in 1:1000){
  #randomize who survived
  Finches$RANDrought.survival <- sample(Finches$Drought.survival) 
  #calculate difference in mass between survivors and non survivors
  BootStrapDifference = mean(Finches$Body.mass..g.[Finches$RANDrought.survival=="survivor"])-
    mean(Finches$Body.mass..g.[Finches$RANDrought.survival=="nonsurvivor"])
  #add difference to list
  RandomDifferences <- c(RandomDifferences, BootStrapDifference)
}

#Plot hist of random differences and add line for real difference
hist(RandomDifferences)
abline (v = realdifference, col = "red", lwd = 2)

#calculate p value 
length(which(RandomDifferences>=realdifference))/length(RandomDifferences)

#if the p value is 0, we report p<0.001 (less then one in a thousand because we did 1000 bootstraps)
#Feel free to try out more than 1000 randomizations