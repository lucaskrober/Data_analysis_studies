##---- Generating random numbers ----##
##---- Normal distribution ----##
# dnorm(x, mean = 0, sd = 1, log = FALSE) ## density
# pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE) ## distribution function
# qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE) ## quntile function
# rnorm(5, mean = 0, sd = 1) ## generates random deviates
# set.seed(1)

##---- Other distributions ----##

##---- Bayesian data analysis ----##
# Number of random draws from the prior
rand.draws <- 10000

prior <- runif(rand.draws, min=0, max=1) # Here you sample rand.drows from the prior  
hist(prior,col="blue") # This is how prior looks

# Here you define the model
model <- function(given.prob) {
  rbinom(1, size=12, given.prob)
  ## generative model
}

sim.data <- prior %>%
map_int(rbinom,n=1,size=12)

# Here you simulate data using the parameters from the prior and the generative model
sim.data <- rep(NA,rand.draws)
for(i in 1:rand.draws) {
  sim.data[i] <- model(prior[i])
}
head(sim.data)
hist(sim.data,breaks=18,col="blue") # This is how sumulated data look like

# Here you filter off all draws that do not match the data.
posterior <- prior[sim.data==5] 

hist(posterior,probability = T,xlim=c(0,1)) # This is how the posterior looks like
length(posterior) # How many draw left after filtering (better more than 1000)
# Summarize the posterior: where a common summary is to take the mean or the median posterior, and perhaps a 95% quantile interval.
median(posterior)
sd(posterior)
sd(prior)
quantile(posterior, c(0.025, 0.975))


#5 successes out of 12 trials
#8 successes out of 20 trials




