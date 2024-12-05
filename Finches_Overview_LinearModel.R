#

#Step 1 is to to read the finch data from HHMI data explorer

setwd("/Users/pleunipennings/Documents/GitHub/Biometry_2024")

library(ggplot2)

library(tidyverse)

Finches <- read.csv("finches_in_galapagos-v2-noid.csv")

# Plot the fraction of survival by sex
ggplot(Finches, aes(x = Body.mass..g., y = Wing.length..mm.)) +
  geom_point() +
  geom_smooth(method = "lm")+
  labs(x = "Body.mass", y = "Wing.length") +
  theme_minimal()


# fit a linear model to see the intercept and the slope for the model 
lm(Wing.length..mm.~Body.mass..g., data = Finches)

# look at the summary of the model including the R^2 value
summary(lm(Wing.length..mm.~Body.mass..g., data = Finches))
