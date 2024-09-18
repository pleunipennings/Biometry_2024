
#let's do a poll
#true fraction of people voting Harris is 50%

probHarris = 0.5
samplesize = 50000

listofpolls <-rbinom(n = 100, size = samplesize, prob = probHarris) / samplesize
hist(listofpolls)

