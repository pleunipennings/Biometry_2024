
##Here we'll look at sampling error. 

#Data you collected in class by throwing a die 12 times. How often did you get a 6? 
Data <- c(3, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 3)/12

# Plotting the values
plot(Data, type = "p", col = "blue", pch = 16, 
     xlab = "Index", ylab = "Value", 
     main = "Sampling Error")
# Calculate the mean of the data
mean_value <- mean(Data)
# Add a horizontal line at the mean value
abline(h = mean_value, col = "red", lty = 2)

# Add vertical lines from each point to the mean
for(i in 1:length(Data)) {
  segments(x0 = i, y0 = Data[i], 
           x1 = i, y1 = mean_value, col = "green", lty = 1,
           lwd = 3)
}


