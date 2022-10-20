# Data Visualization with ggplot
# Reading Datasets with read_csv
# Video 1.3

# This course assumes that you already have the Tidyverse and ggmap libraries installed
# on your system.  If you do not, uncomment and execute the lines below.

#install.packages("tidyverse")
#install.packages("ggmap")

# Load the Tidyverse
library(tidyverse)

# Read the college dataset
college <- read_csv('http://672258.youcanlearnit.net/college.csv')

# Take a look at the data
summary(college)

# Convert state, region, highest_degree, control, and gender to factors
college <- college %>%
  mutate(state=as.factor(state), region=as.factor(region),
         highest_degree=as.factor(highest_degree),
         control=as.factor(control), gender=as.factor(gender))

# Take a look at the data
summary(college)

# What's going on with loan_default_rate?
unique(college$loan_default_rate)

# Let's just force that to numeric and the "NULL" will convert to N/A
college <- college %>%
  mutate(loan_default_rate=as.numeric(loan_default_rate))

# Take a look at the data
summary(college)

