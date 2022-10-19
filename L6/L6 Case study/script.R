##-------- Tidy data case study ------------------------------------------

# The case study uses individual-level mortality data from Mexico. The goal is to find
# causes of death with unusual temporal patterns within a day that differ most from this
# pattern.
# 
# The full dataset "data_row/deaths08.csv.bz2" has information on 539,530 deaths in Mexico
# in 2008 and 55 variables, including the location and time of death, the cause of death, and
# the demographics of the deceased.
# 
# The original dataset has been cleaned and the and only two columns "dt" and "cod" are remained
# in the tidy dataset "data/deaths.csv.bz2

library(tidyverse)
library(lubridate)

#------- Making original dataset tidy ---------------
# deathsRow <- read_csv("data_row/deaths08.csv.bz2")
# deaths <- deathsRow %>%
#   select(yod,mod,dod,hod,cod) %>%
#   mutate(hod=ifelse(hod==0 | hod==99,NA,
#                     ifelse(hod==24,0,hod))) %>%
#   mutate(date=ymd(paste(yod,mod,dod,sep="-"))) %>%
#   mutate(dateTime=ymd_h(paste(date,hod,sep=" "))) %>%
#   select(dt=dateTime,cod)
# write_csv(deaths,"data/deaths.csv.bz2")

#------- Import tidy datasets -----------------------
deaths <- read_csv("data/deaths.csv.bz2")
cod <- read_csv("data/codToDesease.csv.bz2")

# Write a code that creates "deaths.hod.pattern" tibble that contains "hod" and "percent.hod"
# columns. This tbble will contain the overall temporal pattern, the number of deaths per hour,
# for all causes of death. The goal is to find the diseases that differ most from this pattern.
death.hod.pattern <-

# Plot the overall temporal pattern.
death.hod.pattern %>%

# Write a code that creates "deaths.filtered" tibble that contains "cod", "hod"
# and "cod.hod.percent" columns and has only "cod" values for the diseases we may consider
# sufficiently representative (more than 50 total deaths (∼2/hour)). The "cod.hod.percent"
# column should contain a percentage of the deaths for corresponding hour for each "cod".
deaths.filtered <-

# Write a code that creates "deaths.discarted" tibble that contains "cod", "cod.hod.total" and 
# "disease" columns and has only "cod" values that are not in the "deaths.filtered" tibble.
deaths.discarted <-

# Create a graph with "hod" values in x-axis and percents of disease in y-axis (one similar to
# the overall pattern graph). Plot all the diseases on this graph (use show.legend=FALSE argument)
# and add an overall plot on top.
deaths.filtered %>%

# Create a "residuals" tibble that contains "cod" and "dist.sq.sum" columns. The "dist.sq.sum" column
# will contain a sum of squared distances between "cod.hod.percent" from "deaths.filtered" tibble and
# "percent.hod" from "death.hod.pattern" tibble for each corresponding "hod" for each "cod".
residuals <-

# Plot all the "residuals" value in accending order.
residuals %>%

# Set a threshold that will cut-off all the diseases with residual with higher value.
threshold <-

# Create "unusual.cod" tibble that has "cod", "dist.sq.sum" and "disease" columns. This tibble will
# contain "cod"s that have behaviour most different from overall deaths pattern ("dist.sq.sum" greater
# than threshold).
unusual.cod <- residuals %>%

# Create a graph with temporal patter of all "cod"s that are not in "unsual.cod" tibble. Plot them as
# lines (use show.legend=FALSE argument). Add to the plot an overall temporal pattern for all the
# diseases as dots. 
deaths.filtered %>%

# Create a graph with temporal patter of all usual "cod"s form "unsual.cod" tibble. Plot them as
# lines (use show.legend=FALSE argument). Add to the plot an overall temporal pattern for all the
# diseases as dots. 
deaths.filtered %>%
