
##Here we'll look at sampling error. 

#Data you collected in class by throwing a die 12 times. How often did you get a 6? 
Data <- c(2/11, 2/10, 2/7, 0/12, 2/4, 1/12, 2/6, 1/12, 2/12, 2/6, 2/4, 2/3) 

# Plotting the values
plot(Data, type = "p", col = "blue", pch = 16, 
     xlab = "Index", ylab = "Value", 
     main = "Sampling Bias")
# Calculate the mean of the data
mean_value <- mean(Data)
expected_value = 1/6
# Add a horizontal line at the mean value
abline(h = expected_value, col = "red", lty = 2, lwd = 2)

abline(h = mean_value, col = "blue", lty = 2, lwd = 2)



