
#Set your working directory
setwd("/Users/pleunipennings/Documents/GitHub/Biometry_2024")

#Load the libraries. 
#If you don't have them, use install.packages("library name in quotation marks") to get the library
library(ggplot2)
library(ggrepel)

#Read the two dataframes 
Use <- read.csv("ECDC2015CiproUse.csv")
Res <- read.csv("ECDC2015CiproResistanceEcoli.csv")

# Merge the two dataframes by the shared column "Country"
merged_df <- merge(Use, Res, by = "Country")

#This shortens the data frame to only the first 4 points. 
#Remove this line (with #) to get the entire dataset - makes a cooler plot
merged_df <- merged_df[1:4,]

#run a correlation test 
cor.test(merged_df$CiproUse2015, merged_df$ResistancePercentage)

### Make sure you read the value of the correlation coefficient ("cor" or "r")
### Make sure you read the value of p-value

#store the r value using the $estimate component of the test
r = cor.test(merged_df$CiproUse2015, merged_df$ResistancePercentage)$estimate
pvalue = cor.test(merged_df$CiproUse2015, merged_df$ResistancePercentage)$p.value

#calculate the Rsquared value by squaring the r value: 
Rsqvalue = r^2

#round to just two decimals because it looks nicer on your plot
RsqvalueTwoDec <- round(Rsqvalue,2)
# This is to make the p value in the plot look a little better
pvaluePlot = round(pvalue,4)
if (pvalue < 0.001) pvaluePlot  <- "< 0.001" 

##Here is code for a plot. 
# Make 10 changes (e.g. remove a line, put it back. Try "TRUE" where I used "FALSE")
# For each change you try, determine what it does and write a comment between the code lines to explain to your future self

ggplot(data = merged_df, mapping = aes(x = CiproUse2015, y = ResistancePercentage, label=Country))+
  geom_smooth(method = "lm", color = "grey", linewidth = 2, alpha = 0.5, se = FALSE)+  
  geom_point(aes(color = Country),  size = 3, show.legend = FALSE)+
  #scale_y_continuous(limits = c(0,50))+
  scale_x_continuous(limits = c(0,5))+
  theme_bw()+
  labs(y= "Percentage resistant isolates 2015", x = "Cipro Use DDD / 1000")+
  annotate(geom="text", x=1, y=45, label=paste("Num Data Points =", nrow(merged_df)), size = 5)+
  annotate(geom="text", x=1, y=40, label=paste("R^2 =", RsqvalueTwoDec), size = 5)+
  annotate(geom="text", x=1, y=35, label=paste("p value =", pvaluePlot), size = 5)+
  geom_text_repel(nudge_x = .3, col = "grey")


