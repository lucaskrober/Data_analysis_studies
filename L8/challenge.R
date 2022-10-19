set.seed(100)
students.gender <- sample(factor(c(rep("male",15),rep("female",7))))

# Write a simulation of picking 5 students from the list of students (students.gender) withour replacement.
# The list has 15 males and 7 females.
# Find a simulated frequency of having 3 female out of 5 students based on 10000 experiments.

trials <- 1e4
result <- vector("integer",length=trials)



# Write a simulation of picking 1-st male student after 3 female students from the list of students withour replacement.
# Find a simulated frequency of this event based on 10000 experiments.
trials <- 1e5
result <- vector("integer",length=trials)

