# ------ Grouping in tidyverse -------

# Grouping is a special feature of 'tidyverse' data.frame - tibble.
# Operations like:
# - select,
# - filter,
# - sample,
# and othres can be applied within groups created by group_by() function.

library(tidyverse)

deaths.readr <- read_csv("data/deaths08.csv.bz2")

# The grouped columns never get dropped off
deaths.readr %>%
  group_by(cod) %>%
  select(yod,mod,dod)

# Sampling from each group
college <- read_csv("data/college.csv")
college %>%
  group_by(control) %>%
  sample_n(5)

college %>%
  group_by(control) %>%
  sample_frac(.1)

# Ungrouping
college %>%
  group_by(control) %>%
  sample_n(5) %>%
  ungroup()

# Calclulating number of items in each group
# n() is a spectial function of 'dplyr' library that calculates number of rows (items) within
# each group of a grouped tibble
college %>%
  group_by(control) %>%
  mutate(numberOfStudents=n()) %>%
  select(numberOfStudents) %>%
  unique()

# The shortcut for the above code is using summarize() function
college %>%
  group_by(control) %>%
  summarize(numberOfStudents=n())

# Calculating cumulative sums
deaths.readr %>%
  group_by(cod) %>%
  filter(yod!=0) %>%
  arrange(yod) %>%
  select(yod) %>%
  mutate(total=n()) %>%
  ungroup() %>%
  filter(total>=.5*max(total)) %>%
  group_by(cod) %>%
  arrange(cod,yod) %>%
  select(-total) %>%
  mutate(iod=1) %>%
  mutate(cum.sum=cumsum(iod)) %>%
  select(-iod) %>%
  filter(yod<2005) %>%
  ggplot(aes(x=yod,y=cum.sum,color=cod)) +
  geom_line()

names <- c("Name","Title","Departement","Salary")
lengths <- c(32,50,24,NA)
widths <- fwf_widths(lengths,names)
employees <- read_fwf("data/chicagoemployees.txt.bz2",widths,skip=1)
rm(names,lengths,widths)
employees %>%
  group_by(Departement) %>%
  mutate(Salary=str_replace(Salary,"\\$","")) %>%
  mutate(Salary=str_replace(Salary,",","")) %>%
  mutate(Salary=as.numeric(Salary)) %>%
  arrange(Departement) %>%
  mutate(cum.sum=cumsum(Salary)) %>%
  select(cum.sum) %>%
  filter(cum.sum==max(cum.sum)) %>%
  arrange(cum.sum)


##---- Control structures and functions ----##


##---- if-else ----##
if(<condition>) {
  ## do something
} else {
  ## do something else
}
if(<condition1>) {
  ## do something
} else if(<condition2>) {
  ## do something different
} else {
  ## do something different
}
x <- rnorm(1,mean=3)
if(x > 3) {
  y <- 10
} else {
  y <- 0
}

z <- if(x > 3) { ## assinging the result to a variable
  10
} else {
  0
}
##---- for loops ----##
# for loops take an interator variable and assign it
# successive values from a sequence or vector. For
# loops are most commonly used for iterating over the
# elements of an object (list, vector, etc.)
for(i in letters) {
  print(i)
}
# This loop takes the i variable and in each iteration of
# the loop gives it values 1, 2, 3, ..., 10, and then
# exits.

# These three loops have the same behavior
x <- c("a", "b", "c", "d")
for(i in 1:4) {
  print(x[i])
}
for(i in seq_along(x)) {
  print(x[i])
}
for(letter in x) {
  print(letter)
}
for(i in 1:4) print(x[i])

# for loops can be nested.
x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }
}
# Be careful with nesting though. Nesting beyond 2–3 levels
# is often very difficult to read/understand.


##---- While loops ----##
# While loops begin by testing a condition. If it is true,
# then they execute the loop body. Once the loop
# body is executed, the condition is tested again, and so forth.
count <- 0
while(count < 10) {
  print(count)
  count <- count + 1
}
# While loops can potentially result in infinite loops
# if not written properly. Use with care!

# Sometimes there will be more than one condition in the test.
z <- 5
while(z >= 3 && z <= 10) {
  print(z)
  coin <- rbinom(1, 1, 0.5)
  if(coin == 1) { ## random walk
    z <- z + 1
  } else {
    z <- z - 1
  }
}
# Conditions are always evaluated from left to right.


##---- Repeat, Next, Break ----##
# Repeat initiates an infinite loop; these are not commonly
# used in statistical applications but they do
# have their uses. The only way to exit a repeat loop is to call break.
x0 <- 1
tol <- 1e-8
repeat {
  x1 <- computeEstimate()
  if(abs(x1 - x0) < tol) {
    break
  } else {
    x0 <- x1
  }
}
# The loop above is a bit dangerous because there’s no guarantee it
# will stop. Better to set a hard limit on the number of iterations
# (e.g. using a for loop) and then report whether convergence was achieved or not.

# next is used to skip an iteration of a loop
for(i in 1:100) {
  if(i <= 20) {
    ## Skip the first 20 iterations
    next
  }
  ## Do something here
}
# return signals that a function should exit and return a given value

##---- Functions ----##
# Functions are created using the function() directive and are
# stored as R objects just like anything
# else. In particular, they are R objects of class “function”.
# Functions in R are “first class objects”, which means that
# they can be treated much like any other R object.

args(lm) ## argument matching

f <- function(a, b = 1, c = 2, d = NULL) { } ## definition of a function
f <- function(a,b) {
  a^2
}
f(2) ## lazy evaluation

f <- function(a, b) {
  print(a)
  print(b)
}
f(45) ## Once the function tried to evaluate print(b) it had to throw an error.

myplot <- function(x, y, type = "l", ...) {
  plot(x, y, type = type, ...)
} ## "..." - can be an argument also


class(colMeans(mtcars))

# install.packages("prob")
library("prob")
tosscoin(1)
rolldie(2)
cards()
roulette()