# In order to make a hypothesis test in r there is a funciton t.test().
# Even though, the hypothesis test of populaiton mean of large sample
# is conducted using the Z-test the z.test() function is not implemented
# in R. The reason for that is that even having a large sample, you can
# use t.test() function because with large number of observations Student's
# t-distribution tends to standard normal Z-distribution.

# The challenge is to implement z.test() funtion that will calculate z-score
# of the sample mean, p-value and confidence interval under the null hypothesis.

z.test <- funciton(x,
                   y=NULL,
                   alternative = c("two.sided", "less", "greater"),
                   mu=0,
                   conf.level=0.95){
  # Write your code here.
  # The function should return a list with the next structure:
  # [[1]] z-score
  # [[2]] p-value
  # [[3]] confidence interval
}