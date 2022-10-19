
##----- Statistical data analysis in R
##----------- Final challenge
##---------------- Part 1
##-------- Lucas Kröhling Bernardi

# File "credit_card_spendings.csv" contains credit card 
# transactions of OK state of the USA

library(tidyverse)
spendings <- as_tibble(read.csv("data/credit_card_spendings.csv.bz2"))

# Write code to answer the following questions:

# 1. What is the total amount of transactions?
# Changing Amount column to numeric  
#temp <- spendings$Amount
#temp2 <- as.numeric(temp)
#na=which(is.na(temp2));na
#spendings$Amount[na]

#temp <- gsub("[^-0123456789.]","", temp, perl=T)
#temp <- str_replace_all(temp, "[^-0123456789.]","")
#spendings$Amount[na] <- temp[na] 

#spendings$Amount <- as.numeric(spendings$Amount)

tamount <- spendings %>%
  select(Amount) %>%
  mutate(Amount=str_replace_all(Amount, "[^-0123456789.]","")) %>%
  mutate(Amount=as.numeric(Amount)) %>%
  sum();



View(tamount)
# Answer: Total Amount is 36525002.88

# 2. Who is the biggest vendor?
bvendor <- spendings %>% 
  select(Vendor,Amount) %>%
  mutate(Amount=str_replace_all(Amount, "[^-0123456789.]","")) %>%
  mutate(Amount=as.numeric(Amount)) %>%
  group_by(Vendor) %>% 
  summarise(Vendor.Amount=sum(Amount)) %>%
  filter(Vendor.Amount==max(Vendor.Amount))  

View(bvendor)
# Answer: The biggest vendor is WW GRAINGER, with total Amount of 990111.7

# 3. How much in total was spent in GEXPRO?
#There is any line with misspelled Vendor name?
gexpro=which(str_detect(spendings$Vendor, "GEXPRO")==TRUE)
spendings$Vendor[gexpro]

tspentgxpro <- spendings %>%
  mutate(Vendor=str_replace(Vendor," CSF","")) %>%
  filter(Vendor=="GEXPRO") %>%
  select(Vendor,Amount) %>%
  mutate(Amount=str_replace_all(Amount, "[^-0123456789.]","")) %>%
  mutate(Amount=as.numeric(Amount)) %>%
  summarize(Amount=sum(Amount))

View(tspentgxpro)
# Answer: there was a total of 52558.55 spent in GEXPRO

# 4. How much was spent in GEXPRO in June 2014?
tspentgxpro201406 <- spendings %>%
  mutate(Vendor=str_replace(Vendor," CSF","")) %>%
  filter(Vendor=="GEXPRO") %>%
  filter(Year.Month=="201406") %>%
  select(Vendor,Amount) %>%
  mutate(Amount=str_replace_all(Amount, "[^-0123456789.]","")) %>%
  mutate(Amount=as.numeric(Amount)) %>%
  summarize(Amount=sum(Amount))

View(tspentgxpro201406)
# Answer: there was a total of 8573.41 spent in GEXPRO in June 2014

