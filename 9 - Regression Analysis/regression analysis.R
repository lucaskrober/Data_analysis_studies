
##------- Regression analysis ---------##

#---- Loading libraries
library(tidyverse)
library(lubridate)
library(magrittr)

#---- Loading dataset
airquality <- as_tibble(airquality)

#---- Making dataset tidy
airquality %>%
  mutate(Date=dmy(paste(Day,Month,1973,sep="."))) %>%
  select(Date,Ozone,Solar.R,Wind,Temp) %>%
  filter(complete.cases(.)) ->
  tidy.airquality

#---- Creating test dataset
tidy.airquality %>%
  slice(1:70) ->
  test.airquality

#---- Visualizing test dateset
test.airquality %>%
  ggplot()+
  geom_point(aes(x=Wind,y=Temp))

#---- Creating "Temp ~ Wind" linear regression model
test.airquality %>%
  lm(Temp ~ Wind,.) ->
  TempFromWind.model
# TempFromWind.model <- lm(formula = Temp ~ Wind, data = test.airquality)

#---- Characterizing "Temp ~ Wind" model
TempFromWind.model
summary(TempFromWind.model)
coef(TempFromWind.model)
TempFromWind.model$coefficients
confint(TempFromWind.model,level=.99)

#---- Visualizing data and "Temp ~ Wind" model
plot(Temp ~ Wind, data=test.airquality)
abline(TempFromWind.model)

test.airquality %>%
  ggplot(aes(x=Wind,y=Temp))+
  geom_point()+
  geom_smooth(method="lm")

#---- Creating a dataset for prediction
tidy.airquality %>%
  slice(71:111) ->
  futurePredict.airquality

#---- Predicting Temp using "Temp ~ Wind" model
futurePredict.airquality %<>%
  mutate(TempFromWind=predict(TempFromWind.model,.))
# futurePredict.airquality$TempFromWind <- predict(TempFromWind.model, data=futurePredict.airquality)

#---- Visualizing prediction using "Temp ~ Wind" model
futurePredict.airquality %>%
  ggplot(aes(x=Date))+
  geom_point(aes(y=Temp))+
  geom_line(aes(y=TempFromWind))

#---- Creating "Temp ~ Ozone + Solar.R + Wind" linear regression model
test.airquality %>%
  lm(Temp ~ Ozone + Solar.R + Wind,.) ->
  TempFromAll.model

#---- Characterizing "Temp ~ Wind" and "Temp ~ Ozone + Solar.R + Wind" models
summary(TempFromWind.model)
summary(TempFromAll.model)

#---- Predicting Temp using "Temp ~ Ozone + Solar.R + Wind" model
futurePredict.airquality %<>%
  mutate(TempFromAll=predict(TempFromAll.model,.))

#---- Visualizing predition using "Temp ~ Wind" and "Temp ~ Ozone + Solar.R + Wind" models
futurePredict.airquality %>%
  ggplot(aes(x=Date))+
  geom_point(aes(y=Temp))+
  geom_line(aes(y=TempFromWind),color="red")+
  geom_line(aes(y=TempFromAll),color="green")

#---- Calculating Residuals for prediction for both "Temp ~ Wind" and "Temp ~ Ozone + Solar.R + Wind" models
futurePredict.airquality %<>%
  mutate(ResFromWind=Temp-TempFromWind,
         ResFromAll=Temp-TempFromAll)

#---- Calculating Sum of Square of Residuals for "Temp ~ Wind" and "Temp ~ Ozone + Solar.R + Wind" models
SSW <- sum(futurePredict.airquality$ResFromWind^2)
SSA <- sum(futurePredict.airquality$ResFromAll^2)

#---- Visualizing Residuals of prediction using "Temp ~ Wind" and "Temp ~ Ozone + Solar.R + Wind" models
futurePredict.airquality %>%
  ggplot(aes(x=Date))+
  geom_col(aes(y=ResFromWind),fill="red")+
  geom_col(aes(y=ResFromAll),fill="green",width=.3)+
  ylab("Residuals")+
  annotate("text", label=paste("RSS=",round(SSW)), x=dmy("20.08.1973"), y=21, color="red")+
  annotate("text", label=paste("RSS=",round(SSA)), x=dmy("20.08.1973"), y=19, color="green")








