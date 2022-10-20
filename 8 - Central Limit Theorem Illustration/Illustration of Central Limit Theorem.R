##---- Illustration of Central Limit theorem ----##

library("fitdistrplus")

# Modeling of population that has 1 million objects
# that have poisson distribution with parameter lambda=6
lambda <- 6 # defining lambda
population <- rpois(1e6,lambda) # creating population
population.norm.fit <- fitdist(population,"pois",method="mle"); population.norm.fit # fitting the whole population with poisson distribution
# png("pop.hist.png")
plot(population.norm.fit) # fitting plot
# dev.off()

## Creating 1000 samples of length 40 and organizing them into matrix
sample.size <- 40 # each sample size
set.seed(1)
my.samples <- sample(population,size=sample.size*1000,replace=F) # sampling from population
my.samples <- matrix(my.samples,1000) # organizing each sample in a row
my.samples[1:10,1:10]

## Distribution of mean of each sample
sample.means <- rowMeans(my.samples) # Creating mean value for each sample
hist(sample.means)
sample.means.fit <- fitdist(sample.means,"norm",method="mle"); sample.means.fit # fitting Sample Means with normal distribution
plot(sample.means.fit) # plotting fit

## From the Central Limit Theorem the SD of the sample means
## is iqual to the SD of the population divided by the square root of sample size
sqrt(lambda/sample.size)