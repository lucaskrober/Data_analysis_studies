#------ Importing data from Excel ---------

# 'readxl' library provides a tool for easily importing Excel files (.xls and .xlsx) into R.
# 'readxl' library is a part of 'tidyverse' but it doesn't load automatically and need to be
# load manualy

library(tidyverse)
library(lubridate)
library(readxl)

students.xlsx <- read_excel("data/lista_de_Presenca.xlsx",
                            sheet="alunos",
                            range="C4:F20",
                            skip=1)
colnames(students.xlsx) <- make.names(colnames(students.xlsx))

students.xlsx %>%
  select(Programa) %>%
  unique()

# 'readr' library allows faster and easier to import .csv and .tsv files.
# It will not convert strings into factors as read.csv() of base-R

# Check the differences in import functions:

# read.csv() from 'Base' library

deaths.baseR <- read.csv("data/deaths08.csv.bz2")
class(deaths.baseR$yob)
deaths.baseR$yob <- as.character(deaths.baseR$yob)
class(deaths.baseR$yob)
deaths.baseR$yob


# read_csv() from 'readr' library

deaths.readr <- read_csv("data/deaths08.csv.bz2")
deaths.readr
deaths.readr$yob
class(deaths.readr$yob)

class(deaths.baseR)
class(deaths.readr)

deaths.baseR[[1]]
deaths.readr[[1]]

deaths.baseR[1]
deaths.readr[1]

deaths.baseR[,1]
deaths.readr[,1]

# ------- What are Tibbles -------
#
# There are 3 similar objects that can store rectangular data:
# - data.frame from baseR
# - tibble from 'tidyverse'
# - data.table form 'data.table' library that is optimized for very big tables. The processing of data
# in the data.table is different than in both tibble and data.frame
# - matrices only can store data of the same type

# Tibbles stores more information about the data:

deaths.readr %>%
  class()

deaths.readr %>%
  group_by(nation) %>%
  class()

# How to create tibbles:
# - Tibbles are autamatically created by funtions from 'tidyverse' library like read_csv()
# - using tibble() function
# - converting data.frame into tibble using as.tibble() function

# ------ Data manipulation in tibbles ------
#
# 'dplyr' library provides necessary functions (think as verbs) to
# - filter,
# - select,
# - mutate,
# - separate
# data from a tibble

# Select columns from the tibble
deaths.readr %>%
  select(cod) %>%
  unique() %>%
  arrange(cod)

# Filtering data
deaths.readr %>%
  filter(yod == "2008" & mod == '12') %>%
  select(yod:cod) %>%
  select(-minod,-med_help) %>%
  .[[5]]

# Filtering rows with NA
weather <- read_csv("data/weather.csv.bz2")
weather %>%
  separate(id,c("id","year","month","element"),c(11,15,17)) %>%
  gather(day,value,d1:d31) %>%
  mutate(day=str_replace(day,"d","")) %>%
  mutate(date=ymd(paste(year,month,day,sep="-"))) %>%
  filter(!is.na(date)) %>%
  filter(!is.na(value)) ->
  weather.tidy

# Slicing data
PRCP <- weather.tidy %>%
  select(element) %>%
  .[[1]]=="PRCP"

PRCP.index <- which(PRCP)
weather.tidy %>%
  slice(PRCP.index)

# Mutating data
# In this example str_to_upper() function will be used and it is a part of 'stringr' library that is
# a part of 'tidyverse'
deaths.readr %>%
  mutate(yob = as.numeric(yob),cod = str_to_lower(cod), age=as.numeric(age)) %>%
  mutate(young = age) %>%
  slice(1:10) %>%
  mutate(young=ifelse(age<=60,"young","old")) %>%
  select(age,young)

# Separating and joining data
names <- c("Name","Title","Departement","Salary")
lengths <- c(32,50,24,NA)
widths <- fwf_widths(lengths,names)
employees <- read_fwf("data/chicagoemployees.txt.bz2",widths,skip=1)
rm(names,lengths,widths)
employees %>%
  separate(Name,c("Surname","FirstName"),sep=",") # extra="merge"

# Sample from the tibble

deaths.readr %>%
  sample_frac(.3) # returns 30% of all observations

deaths.readr %>%
  sample_n(50) # returns 5 observations randomly selected from all observations

deaths.readr %>%
  group_by(sex) %>%
  sample_n(3) # wants to return 3 observations from each group

deaths.readr %>%
  group_by(cod) %>%
  sample_n(3, replace=TRUE) # returns 3 observations from each group with replacement

# ------ Grouping in tidyverse -------

# Grouping is a special feature of 'tidyverse' data.frame - tibble.
# Operations like:
# - select,
# - filter,
# - sample,
# and othres can be applied within groups created by group_by() function.

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
  group_by(yod) %>%
  filter(yod!=0) %>%
  arrange(yod) %>%
  select(cod) %>%
  mutate(total=n()) %>%
  mutate(cum.sum=cumsum(total)) %>%
  filter(cum.sum==max(cum.sum)) %>%
  filter(yod<1975) %>%
  ggplot() +
  geom_line(aes(x=yod,y=cum.sum))

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
