
##----- Statistical data analysis in R
##----------- Final challenge
##---------------- Part 2
##-------- Lucas Kröhling Bernardi

# File "returns.csv.bz2" contains randomly generated values of stock returns
library(tidyverse)
returns <- read_csv("data/returns.csv.bz2")

# Reconstruct the values of all stocks assuming that the price of all stocks
# on 1990-01-03 was equal to zero. function pivot_longer is a better function than
# gather, because gather can lost information or something
returns <- returns %>%
  gather(Stock,Value, contains("stock_")) %>%
  mutate(Stock=str_replace_all(Stock,"stock_","")) %>%
  group_by(Stock) %>%
  #mutate(Price = Value - lag(Value, default = Value[1])) %>%
  mutate(Price = cumsum(Value))
  
# Find a month with the smallest number of growing or falling stocks (or the
# highest number of stocks oscillating around some constant)
returns <- returns %>%
  mutate(Date=str_replace(Date,"-","")) %>%
  separate(Date,c("Year.Month", "Day"),"-") %>%
  group_by(Year.Month) %>%
  ggplot()+
  geom_point(aes(x=Day,y=Price,color=Stock),alpha=.3,show.legend=F)+
  geom_point(data=returns,mapping=aes(x=Day,y=Price))+
  theme_minimal()
