#setting my working directory
setwd("/Users/pleunipennings/Documents/GitHub/Biometry_2024")

#reading in the pets file
read.csv("Pets.csv") -> pets
#looking to see if data look good
View(pets)
#making a histogram 
hist(pets$How.many.pets.do.you.have.)

hist(pets$How.many.pets.do.you.have., breaks = seq(-0.5,10.5, by = 1))

#calculating the mean
mean(pets$How.many.pets.do.you.have.)
  
median(pets$How.many.pets.do.you.have.)

table(pets$How.many.pets.do.you.have)
