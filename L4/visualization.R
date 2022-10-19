
##------- Visualization of data in R -------


#-------- Plotting with ggplot2 library ------
# ggplot2 library is a part of the tidyverse package. It follows the principles of 'tidy data'
# and applies concept of 'grammar of graphics'.

# As a reminder 'tidyverse' library includes:
# - 'readr' library that allows to easily import data into R;
# - 'tibble' library introduces tibbles as a basic data structures;
# - 'dplyr' library provides a set of functions (verbs) to facilitate data manipulation;
# - 'tidyr' library contains functions to transform between long and wide formats of data.

# 'ggplot2' library is fully integrated with these packages and allows to create complex graphs .

# The idea of 'grammar of graphics' is similar to the grammar of the spoken language where a set
# of rules are applied in order to pass the information in a corret way. The 'grammar of graphics'
# uses 4 components:
# - data - the data that you would like to visualize;
# - geometries - shapes that are used to visualize the data;
# - aesthetics - properties of geometries based on data (color, size, shape, etc.);
# - scales - mapping between geometries and aesthetics.

library(tidyverse)

iris_tibble <- as.tibble(iris)
class(iris_tibble$Species)

# Simpliest ggplot() call:
ggplot(data=iris_tibble) +
  geom_point(mapping=aes(x=Sepal.Length, y=Sepal.Width))

# Each type of a plot has it's own aesthetics.
# Scatter plot has the following aesthetics:
# - x - position on x axis
# - y - position on y axis
# - shape - shape of each point
# - colour - colour of each point
# - size - size of each point
# - alpha - transparency of each point

##----- Scatter plot ------
ggplot(data=iris_tibble) +
  geom_point(mapping=aes(x=Sepal.Length, y=Sepal.Width, color=Species, size=Petal.Width))

random_data <- tibble(x.val=rnorm(100000),
                      y.val=rnorm(100000),
                      species=as.factor(sample(c("A","B"),100000, replace=TRUE))) %>%
  mutate(y.val=ifelse(species=='B',y.val+2,y.val))

random_data %>%
  ggplot() +
  geom_point(mapping=aes(x=x.val, y=y.val,colour=species), # parameters specified inside aes() are based on data
             shape=19,
             alpha=.1 # parameter that is specified outside of aes() applied for all geometry
  )

##----- Lines and smoothers --------

##----- Bars and columns -----------

# geom_bar - creates a bar graph, allows specify x-value, uses count as an y-axis value.
# geom_col - creates a column graph, allows to specify x-value and y-value.

ggplot(data=mtcars) +
  geom_bar(mapping=aes(x=vs, color=am))

ggplot(data=mtcars) +
  geom_bar(mapping=aes(x=vs, fill=am))

mtcars %>%
  group_by(vs) %>%
  summarise(average_mpg=mean(mpg)) %>%
  ggplot() +
  geom_col(aes(x=vs,y=average_mpg))

##----- Histograms -----------------
# Histograms group continious numerical data into bins (binning) in order to plot

set.seed(6)
as.tibble(rpois(1000,5)) %>%
  ggplot(aes(x=value)) +
  geom_histogram(bins=10, origin=0)
  
set.seed(6)
as.tibble(rpois(1000,5)) %>%
  ggplot(aes(x=value)) +
  geom_histogram(binwidth=3, origin=0)

##------ Boxplot ------------------

random_data %>%
  group_by(species) %>%
  sample_frac(.1) %>%
  ggplot() +
  geom_point(mapping=aes(x=species, y=x.val))

random_data %>%
  group_by(species) %>%
  sample_frac(.1) %>%
  ggplot() +
  geom_jitter(mapping=aes(x=species, y=x.val))

random_data %>%
  group_by(species) %>%
  sample_frac(.1) %>%
  ggplot() +
  geom_boxplot(mapping=aes(x=species, y=x.val))

##------ Modifying view of graphs -------------
# Background (cand be a plot, panel, legend, etc.)
?theme
ggplot(data=mtcars) +
  geom_bar(mapping=aes(x=vs, fill=am))+
  theme(
    # plot.background=element_rect(fill="yellow"),
    #     panel.background=element_rect(fill="green"),
        plot.background=element_blank(),
        panel.background=element_blank(),
        panel.grid.major=element_line(color="purple"))

# Axis (labels and limits and also colours and other attributes of title, text, ticks, lines)
ggplot(data=mtcars) +
  geom_bar(mapping=aes(x=vs, fill=am))+
  theme(plot.background=element_blank(),
        panel.background=element_blank(),
        panel.grid.major=element_line(color="purple"))+
  xlab("Type of engine")+
  theme(axis.title=element_text(color="red"))+
  ylab("Counts (un.)")+
  ylim(c(0,20))

# Scales
# x and y axes are examples of more general concept called Scale
# Scales describe how data are mapped from data set to visual representations
# In the plot below there are 3 scales - descrete (categorical), continuous and fill colour
# of each bar.
# Scales can be also related to shape, colour, transparency.
# Scale funcion uses convention: scale_name_datatype
?scale_x_continuous
ggplot(data=mtcars) +
  geom_bar(mapping=aes(x=vs, fill=am))+
  theme(plot.background=element_blank(),
        panel.background=element_blank(),
        panel.grid.major=element_line(color="purple"))+
  scale_x_discrete(name="Type of engine", position="top")+
  scale_y_continuous(name="Counts (un.)", limits=c(0,20))+
  scale_fill_manual(values=c("blue","green"))
  theme(axis.title=element_text(color="red"))
  
# Legends
mtcars %>%
  ggplot() +
    geom_bar(mapping=aes(x=vs, fill=am))+
    theme(plot.background=element_blank(),
          panel.background=element_blank(),
          panel.grid.major=element_line(color="purple"))+
    theme(axis.title=element_text(color="red"))+
    scale_x_discrete(name="Type of engine", position="top")+
    scale_y_continuous(name="Counts (un.)", limits=c(0,20))+
    scale_fill_manual(values=c("blue","green"),
                      guide=guide_legend(title="Transmission",
                                         nrow=1,
                                         label.position="bottom",
                                         keywidth=3))+
  theme(legend.position="top")

