#In this class we will use a bootstrapping technique to 
# detemine if there is a significant difference in WiLe / beak length 
# between birds that survived the drought and those that didn't. 

#Step 1 is to to read the finch data from HHMI data explorer
setwd("/Users/pleunipennings/Documents/GitHub/Biometry_2024")
Finches <- read.csv("finches_in_galapagos-v2-noid.csv")

#Step 2
#We calculate the difference between the average WiLe of birds that survived
# and the birds that didn't survive the drought. 
# Save this number in a variable called RealWiLeDifference

AveWiLeSurvivors = mean(Finches$Wing.length..mm.[Finches$Drought.survival=="survivor"])
AveWiLeNonSurvivors = mean(Finches$Wing.length..mm.[Finches$Drought.survival=="nonsurvivor"])
RealWiLeDifference = AveWiLeSurvivors - AveWiLeNonSurvivors

#After this step you can fill in the blank here: 
#"Birds that survived the drought were on average XXX grams heavier than birds
# that didn't survive the drought"

#Step 3
#Next, we want to use bootstrapping to determine if this difference is significant. 
#To do that, we have to *imagine* a world where WiLe doesn't matter. 
#In that world, heavy and light birds are equally likely to survive. 
#What would that data look like if they came from that imagined world? 
#By the way, that imagined world is our null-hypothesis. 
#To create that world, we are going to create a new column called "randomized survival"
#In that column, we are going to use the labels from the survival colum, but 
# shuffled. We use the sample() function for that. 

Finches$RandomSurvival = sample(Finches$Drought.survival) 

#Step 4
#Now we want to re-calculate the average difference in WiLe 
# But using the randomized survival labels. 
# Share with the class what you found. 
# Did you find that your randomized difference in WiLe was bigger or smaller
# than the real difference in WiLe? 

#After this step you can fill in the blank here: 
#"After I randomized the survival labels, 
# I found that birds that "survived" the drought were on average XXX grams heavier/lighter than birds
# that "didn't survive" the drought. 
# The difference in the randomized dataset was (smaller / larger) than the real WiLe difference."  

AveWiLeSurvivorsRan = mean(Finches$Wing.length..mm.[Finches$RandomSurvival=="survivor"])
AveWiLeNonSurvivorsRan = mean(Finches$Wing.length..mm.[Finches$RandomSurvival=="nonsurvivor"])
RanWiLeDifference = AveWiLeSurvivorsRan - AveWiLeNonSurvivorsRan


#Step 5
#Next we randomize and re-calclate the same test statistic 1000 times. 
#We create a vector that will hold our 1000 results
#ListOfRandomDiffWiLe <- c() starts an empty vector
#For this we use a for loop 
# for (i in 1:1000){code for reshuffle (step 3) and recalculate (step 4) and to save the result}
# inside the for loop, add the randomized WiLe difference to the vector using 
# ListOfRandomDiffWiLe <- c(ListOfRandomDiffWiLe, RandomizedWiLeDifference)

ListOfRandomDiffWiLe <- c()
for (i in 1:1000){
  Finches$RandomSurvival = sample(Finches$Drought.survival) 
  AveWiLeSurvivorsRan = mean(Finches$Wing.length..mm.[Finches$RandomSurvival=="survivor"])
  AveWiLeNonSurvivorsRan = mean(Finches$Wing.length..mm.[Finches$RandomSurvival=="nonsurvivor"])
  RanWiLeDifference = AveWiLeSurvivorsRan - AveWiLeNonSurvivorsRan
  ListOfRandomDiffWiLe <- c(ListOfRandomDiffWiLe, RanWiLeDifference)
}

#Step 6
#Next we take our 1000 difference and see how often the WiLe difference is
# equal to or higher than the RealWiLeDifference we observed in the real data
# save this number as NumTimesRanDiffEqHighReal 
# NumTimesRanDiffEqHighReal = length(which(ListOfRandomDiffWiLe>=RealWiLeDifference))
# NumTimesRanDiffEqHighReal divided by 1000 is your p-value! 
# It shows you the probability that your observed result is seen under the null 
# hypothesis. 

NumTimesRanDiffEqHighReal = length(which(ListOfRandomDiffWiLe>=RealWiLeDifference))

# If NumTimesRanDiffEqHighReal is 0, the p-value can be written as p < 0.001 (p smaller than 1 in a thousand)
#By the way, in this exercise the difference in average WiLe is our "test statistic."


#Step 7
# Make a histogram of the 1000 values in ListOfRandomDiffWiLe
#Add a vertical line to add the RealWiLeDifference
# Is RealWiLeDifference in the middle of the histogram? Or far to the right? 

hist(ListOfRandomDiffWiLe, xlim = c(-2, 2))
abline (v = RealWiLeDifference, col = 2, lwd = 2)
