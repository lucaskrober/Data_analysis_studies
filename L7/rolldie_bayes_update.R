library(tidyverse)

bayes_update <- tibble(
  hypothesis=c("H04","H06","H08","H10","H12","H20"),
  prior=rep(1/6,6),
  likelyhood=1/c(4,6,8,10,12,20)
)

bayes_update

# If I draw 1-4
bayes_update %>%
  mutate(unNormPosterior=likelyhood*prior) %>%
  mutate(posterior=unNormPosterior/sum(unNormPosterior)) %>%
  ggplot()+
  geom_col(aes(x=hypothesis,y=posterior))

# If I draw 5-6
bayes_update %>%
  mutate(likelyhood=ifelse(hypothesis=="H04",0,likelyhood)) %>%
  mutate(unNormPosterior=likelyhood*prior) %>%
  mutate(posterior=unNormPosterior/sum(unNormPosterior)) %>%
  ggplot()+
  geom_col(aes(x=hypothesis,y=posterior))

# If I draw 7-8
bayes_update %>%
  mutate(likelyhood=ifelse(hypothesis=="H04" | hypothesis=="H06",0,likelyhood)) %>%
  mutate(unNormPosterior=likelyhood*prior) %>%
  mutate(posterior=unNormPosterior/sum(unNormPosterior)) %>%
  ggplot()+
  geom_col(aes(x=hypothesis,y=posterior))

# If I draw 9-10
bayes_update %>%
  mutate(likelyhood=ifelse(hypothesis=="H04" | hypothesis=="H06" | hypothesis=="H08",0,likelyhood)) %>%
  mutate(unNormPosterior=likelyhood*prior) %>%
  mutate(posterior=unNormPosterior/sum(unNormPosterior)) %>%
  ggplot()+
  geom_col(aes(x=hypothesis,y=posterior))

# If I draw 11-12
bayes_update %>%
  mutate(likelyhood=ifelse(hypothesis=="H04" | hypothesis=="H06" | hypothesis=="H08" | hypothesis=="H10",0,likelyhood)) %>%
  mutate(unNormPosterior=likelyhood*prior) %>%
  mutate(posterior=unNormPosterior/sum(unNormPosterior)) %>%
  ggplot()+
  geom_col(aes(x=hypothesis,y=posterior))

# If I draw >12
bayes_update %>%
  mutate(likelyhood=ifelse(hypothesis!="H20",0,likelyhood)) %>%
  mutate(unNormPosterior=likelyhood*prior) %>%
  mutate(posterior=unNormPosterior/sum(unNormPosterior)) %>%
  ggplot()+
  geom_col(aes(x=hypothesis,y=posterior))
