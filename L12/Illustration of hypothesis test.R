
#--------- Hypothesis tests in R -------

set.seed(11)
lambda <- 5
curve(dexp(x, rate=1/lambda), from=0, to=20)
sample1 <- rexp(15, rate=1/lambda); sample1
mean(sample1)

t.test(sample1, mu=5)
?t.test
t.test(sample1, mu=5, alternative="greater")

curve(dnorm(x, mean=10, sd=3), from=0, to=20, add=TRUE)
sample2 <- rnorm(10, mean=10, sd=3)
mean(sample2)

t.test(sample1, sample2, alternative="greater", paired=FALSE)

sample3 <- rnorm(10, mean=20, sd=3)

t.test(sample1, sample3, paired=FALSE)