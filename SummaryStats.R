#
data <- c(0,0,0,0,1,1,1,2,2,3,3,4,4,5,5,1,1,2,2,3,3,4,4,10,100,2,3,6,7,8,0,0,0,0)
# calculae the mean and save to mean_x   
mean_x <- mean(data)
#
median_x = median(data)
#
table_x <- table(data)

#i want to calculate the sum of squares
# so i need to get the difference from the mean 
# square that 
# sum it 
# assign to sum_of_squares
sum_of_squares <- sum((data-mean_x)^2)

sample_variance <- sum_of_squares / (length(data)-1)
standard_deviation <- sqrt(sample_variance)

