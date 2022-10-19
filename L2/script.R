# ------ Base R approach -------
# Base package is sufficient to do data manipulation
# it includes standard R packages: stats, utils and graphics

mtcars
mtcars[mtcars$am == 1,]

# ------- What is R package -------
# R packages are collections of functions
# and data sets developed by the community. They increase the
# power of R by improving existing base R functionalities, or
# by adding new ones. For example, if you are usually working
#with data frames, probably you will have heard about dplyr or
# data.table, two of the most popular R packages.

# ------- Tidyverse -----------
# Tidyverse is a set of packages that are designed to simplify
# the data manipulation.
# Tidyverse approach is based on the concept of "tidy data"
# Tidyverse was proposed in 2014
# Some facts about Tidyverse:
# 1. the core of Tidyverse is developed by RStudio
# 2. it seems like it will have a long term support
# 3. it is developed openly on GitHub
# 4. it cpntaines validated R packages (the result is validated)
# 
# Advantages that Tidyverse provide can be summarized in 3 categories:
# 1. Import of data
# 2. Manipulation with data
# 3. Visualization of data

# ------ Import of data -------
# - 'readr' library is designed to import rectangular tabulated data (.csv, .tsv, etc.)
# - 'readxl' libraryis designed to import Excel .xls and .xlsx files as simple as import .csv.
# - 'haven' library allows to import SAS, SPSS and Stata files

# ------ Data manipulation -------
# - Tidyverse uses %>% (pipe) operator for chaining subsiquent operations during data manipulation
# - 'dplyr' library provides tools for most of the needs (subsetting, filtering, summarizing)

# ------ Data visualization -------
# - 'ggplot2' library uses "grammar of graphics" idea to plot complex static charts easily
# - 'htmlwidget' library allows to create interactive charts for the web
# - 'shiny' library allows to built web interactive web app using R

# ------- Example of ggplot2 ------
library(tidyverse)
library(ggmap)

# Load the college dataset
college <- read_csv("data/college.csv") ## loading a dataset

# Load state information
counties <- map_data("county") # loading a position of counties
CAcounties <- counties %>%
  filter(region=="california") %>%
  mutate(group=as.factor(group)) # filtering only counties of the state of California
rm(counties)

# Ploting a map with data
ggplot() +
  geom_polygon(data=CAcounties, aes(x=long,y=lat, group=group), fill="beige",colour="grey") +
  coord_map() +
  theme_void() +
  geom_point(data=college,mapping=aes(x=lon,y=lat,size=undergrads,colour=control), alpha=.6) +
  ggtitle("Most California colleges located in large cities",
          subtitle="Sourse: U.S. Departament of Education")

# ------ Updating tidyverse ---------
# The package doesn't have a regular update frequency
# Use function tidyverse_update() to check if there are updates available

tidyverse_update()

# -------- %>% operator --------
#
# %>% is called a pipe operator
#
# Example of pipe:

1:9 %>%
  mean()

# Pipe operator is a 'sintactic sugar' for chaining operations together.
# The term 'sintactic sugar' represents a code that is specially designed
# to humans to easier read/write a code.
# 'Sintactic sugar' is designed in order for the programmer to focus more
# on the meaning of the operation rather than the way it should be written

# The real code is:

mean(1:9)

# More complex example:

1:9 %>%
  sqrt() %>%
  cosh() %>%
  diff() %>%
  log(base=2) %>%
  .^2 %>% # WHAT??? Period?
  length() %>%
  rep('Hello, world',.) # WHAT??? Period again?

  
# The pipe operator ALWAYS forces the previously evaluated expressions to be passed
# as FIRST ARGUMENT for the consequetive function.
#
# To use the previously evaluated expressions as the second argument, the . operator
# is used
#
# The .[[1]] notation is used in order to extract data in a form of vector:

midwest %>%
  select(state) %>%
  unique() %>%
  .[[1]]

# Alternative pipe operators are:
# - %T>% - special "tree" pipe,
# - %$% - special "select" pipe, and
# - %<>% - special "assign" pipe.

#------- Long to wide dataset -------
pew <- read_csv("data/pew.csv.bz2")

pew.wide <- pew %>%
  select(religion,income) %>%
  mutate(religion=as.factor(religion),income=factor(income,
                                                    ordered=TRUE,
                                                    levels=c("Less than $10,000",
                                                             "10 to under $20,000",
                                                             "20 to under $30,000",
                                                             "30 to under $40,000",
                                                             "40 to under $50,000",
                                                             "50 to under $75,000",
                                                             "75 to under $100,000",
                                                             "100 to under $150,000",
                                                             "$150,000 or more",
                                                             "Don't know/Refused (VOL.)"))) %>%
  filter(!is.na(income)) %>%
  group_by(religion,income) %>%
  summarise(total=n()) %>%
  arrange(religion,income) %>%
  spread(income,total) %>%
  na.omit

#--------- Wide to long dataset -----------

names(pew.wide)[-1]
pew.long <- pew.wide %>%
  gather(income,total,
         #         contains("$"))
         names(pew.wide)[-1])
# The columns can be also specified by names using backtick character ``

#--------- Splitting variables ------------
tb <- read_csv("data/tb.csv.bz2")
tb %>%
  gather(column,cases,
         contains("new_sp_")) %>%
  select(-new_sp) %>%
  filter(complete.cases(.)) %>%
  mutate(column=str_replace_all(column, "new_sp_", "")) %>%
  separate(column,c("gender","age"),1)

attr(tb,"labels") <- "Country"

#------- Variables are stored in both rows and columns ----------

weather <- read_csv("data/weather.csv.bz2")

library(lubridate)
weather %>%
  separate(id,c("id","year","month","element"),c(11,15,17)) %>%
  gather(day,value,d1:d31) %>%
  mutate(day=str_replace(day,"d","")) %>%
  mutate(date=ymd(paste(year,month,day,sep="-"))) %>%
  filter(complete.cases(.)) %>%
  select(id,date,element,value) %>%
  spread(element,value)

#------ Importing data from Excel ---------

# 'readxl' library provides a tool for easily importing Excel files (.xls and .xlsx) into R.
# 'readxl' library is a part of 'tidyverse' but it doesn't load automatically and need to be
# load manualy

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
weather %>%
  separate(id,c("id","year","month","element"),c(11,15,17)) %>%
  gather(day,value,d1:d31) %>%
  mutate(day=str_replace(day,"d","")) %>%
  mutate(date=ymd(paste(year,month,day,sep="-"))) %>%
  filter(!is.na(date)) %>%
  filter(!is.na(value))

# Slicing data
PRCP <- weather %>%
  separate(id,c("id","year","month","element"),c(11,15,17)) %>%
  gather(day,value,d1:d31) %>%
  mutate(day=str_replace(day,"d","")) %>%
  select(element) %>%
  .[[1]]=="PRCP"
PRCP.index <- which(PRCP)
weather %>%
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
