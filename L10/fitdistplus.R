#install.packages("fitdistrplus")
library(fitdistrplus)
library(tidyverse)
library(lubridate)

weather <- read_csv("data_raw/weather.csv.bz2")
weather %>%
  separate(id,c("id","year","month","element"),c(11,15,17)) %>%
  gather(day,value,d1:d31) %>%
  mutate(day=str_replace(day,"d","")) %>%
  mutate(date=ymd(paste(year,month,day,sep="-"))) %>%
  filter(!is.na(date)) %>%
  filter(!is.na(value)) ->
  weather.tidy

weather.tidy %>%
  mutate(month=as.numeric(month)) %>%
  spread(element,value) %>%
  filter(TMAX!=0 & TMIN!=0 & month==1) %>%
  mutate(Tratio=TMAX/TMIN) %>%
  select(Tratio) %>%
  pull ->
  Tratio

hist(Tratio, col="blue")

?fitdist # general overview of the function
Tratio_norm.mle <- fitdist(Tratio, "norm")
Tratio_norm.mle
mean(Tratio)
sd(Tratio)
summary(Tratio_norm.mle)
Tratio_norm.mle$estimate[1]
Tratio_norm.mle$loglik
plot(Tratio_norm.mle, col="blue", breaks=30)

Tratio_gamma.mle <- fitdist(Tratio, "gamma")
summary(Tratio_gamma.mle)
plot(Tratio_gamma.mle, col="blue", breaks=30)

Tratio_lnorm.mle <- fitdist(Tratio, "lnorm")
summary(Tratio_lnorm.mle)
plot(Tratio_gamma.mle, col="blue", breaks=30)

Tratio_lnorm.mme <- fitdist(Tratio, "lnorm", method="mme")
summary(Tratio_lnorm.mme)
plot(Tratio_lnorm.mme, col="blue", breaks=30)

Tratio_lnorm.qme <- fitdist(Tratio, "lnorm", method="qme", probs=c(.25,.75))
summary(Tratio_lnorm.qme)
plot(Tratio_lnorm.mme, col="blue", breaks=30)

Tratio_lnorm.KS <- fitdist(Tratio, "lnorm", method="mge", gof="KS")
summary(Tratio_lnorm.KS)
plot(Tratio_lnorm.KS, col="blue", breaks=30)

Tratio_lnorm.CvM <- fitdist(Tratio, "lnorm", method="mge", gof="CvM")
summary(Tratio_lnorm.CvM)
plot(Tratio_lnorm.CvM, col="blue", breaks=30)

Tratio_lnorm.AD <- fitdist(Tratio, "lnorm", method="mge", gof="AD")
summary(Tratio_lnorm.AD)
plot(Tratio_lnorm.AD, col="blue", breaks=30)

tibble(
  distribution=c("norm", "gamma", "lnorm", "lnorm", "lnorm", "lnorm", "lnorm", "lnorm"),
  method=c("mle", "mle", "mle", "mme", "qme", "KS", "CvM", "AD"),
  logLikelihood=c(Tratio_norm.mle$loglik,
                  Tratio_gamma.mle$loglik,
                  Tratio_lnorm.mle$loglik,
                  Tratio_lnorm.mme$loglik,
                  Tratio_lnorm.qme$loglik,
                  Tratio_lnorm.KS$loglik,
                  Tratio_lnorm.CvM$loglik,
                  Tratio_lnorm.AD$loglik))

plot(Tratio_lnorm.mme, col="blue", breaks=30)
denscomp(list(Tratio_norm.mle,
              Tratio_gamma.mle,
              Tratio_lnorm.mle,
              Tratio_lnorm.mme,
              Tratio_lnorm.qme,
              Tratio_lnorm.KS,
              Tratio_lnorm.CvM,
              Tratio_lnorm.AD),
         datacol="blue",
         lwd=3)

cdfcomp(list(Tratio_norm.mle,
             Tratio_gamma.mle,
             Tratio_lnorm.mle,
             Tratio_lnorm.mme,
             Tratio_lnorm.qme,
             Tratio_lnorm.KS,
             Tratio_lnorm.CvM,
             Tratio_lnorm.AD))
