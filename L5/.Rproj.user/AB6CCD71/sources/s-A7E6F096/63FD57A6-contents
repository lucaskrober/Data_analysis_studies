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

college <- read_csv("data/college.csv.bz2")

# ggplot() along just creates a blank plot
ggplot()

# I need to tell ggplot what data to use
ggplot(data=college)

# And then give it some instructions using the grammar of graphics.
# Let's build a simple scatterplot with tuition on the x-axis and average SAT score on the y axis
ggplot(data=college) +
  geom_point(mapping=aes(x=tuition, y=sat_avg))

# Each type of a plot has it's own aesthetics.
# Scatter plot has the following aesthetics:
# - x - position on x axis
# - y - position on y axis
# - shape - shape of each point
# - colour - colour of each point
# - size - size of each point
# - alpha - transparency of each point

##----- Scatter plot ------
# Let's try representing a different dimension.  
# What if we want to differentiate public vs. private schools?
# We can do this using the shape attribute

ggplot(data=college) +
geom_point(mapping=aes(x=tuition, y=sat_avg, shape=control))

# That's hard to see the difference.  What if we try color instead?
ggplot(data=college) +
  geom_point(mapping=aes(x=tuition, y=sat_avg, color=control))

# I can also alter point size.  Let's do that to represent the number of students
ggplot(data=college) +
  geom_point(mapping=aes(x=tuition, y=sat_avg, color=control, size=undergrads))

# Adding some transparency (allow to see through points). alpha = 1, 1/100, 1/10, 1/2
ggplot(data=college) +
  geom_point(mapping=aes(x=tuition, y=sat_avg, color=control, size=undergrads), alpha=1)

##----- Lines and smoothers --------

# geom_point vs geom_line
ggplot(data=college) +
  geom_line(mapping=aes(x=tuition, y=sat_avg, color=control)) +
  geom_point(mapping=aes(x=tuition, y=sat_avg, color=control))

# I can also write this a different way
ggplot(data=college, mapping=aes(x=tuition, y=sat_avg, color=control)) +
  geom_line()+ # se=FALSE
  geom_point() # (alpha=1/2, 1/5)

##----- Bars and columns -----------
# geom_bar - creates a bar graph, allows specify x-value, uses count as an y-axis value.
# geom_col - creates a column graph, allows to specify x-value and y-value.

# Break out by public vs. private (color vs fill)
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, color=control))

# And I can pipe that straight into ggplot (ERROR!!!)
college %>%
  group_by(region) %>%
  summarize(average_tuition=mean(tuition)) %>%
  ggplot() +
  geom_bar(mapping=aes(x=region, y=average_tuition))

# But I need to use a column graph instead of a bar graph to specify my own y
college %>%
  group_by(region) %>%
  summarize(average_tuition=mean(tuition)) %>%
  ggplot() +
  geom_col(mapping=aes(x=region, y=average_tuition))
  
##----- Histograms -----------------
# Histograms group continious numerical data into bins (binning) in order to plot

# Let's look at student body size
ggplot(data=college) +
  geom_bar(mapping=aes(x=undergrads))

# Histograms can help us by binning results
ggplot(data=college) +
  geom_histogram(mapping=aes(x=undergrads), origin=0)

# What if we want fewer groups? Try 4 bins, 10 bins
ggplot(data=college) +
  geom_histogram(mapping=aes(x=undergrads), bins=4, origin=0)

# Or we can specify the width of the bins instead (try binwidth = 1e3, 1e4)
ggplot(data=college) +
  geom_histogram(mapping=aes(x=undergrads), binwidth=1000, origin=0)

##------ Boxplot ------------------
# Let's try looking at tuition vs. institutional control
ggplot(data=college) +
  geom_point(mapping=aes(x=control, y=tuition))

# One way I could visualize this better is by adding some jitter
ggplot(data=college) +
  geom_jitter(mapping=aes(x=control, y=tuition))

# But an even better way is with a boxplot
ggplot(data=college) +
  geom_boxplot(mapping=aes(x=control, y=tuition))

##------ Modifying view of graphs -------------

#----- Background --------
# Background can be a plot, panel, legend, etc.
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(plot.background=element_rect(fill='purple'))+ # plot bg color
  theme(panel.background=element_rect(fill='purple')) # panel bg color

# Let's be minimalist and make both backgrounds disappear
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank())

# Add grey gridlines
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  theme(panel.grid.major=element_line(color="grey"))

# Only show the y-axis gridlines
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  theme(panel.grid.major.y=element_line(color="grey"))

#----- Axis -------
# Axis (labels and limits and also colours and other attributes of title, text, ticks, lines)

# Rename the axes
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  xlab("Region") +
  ylab("Number of Schools")

# Resize the y-axis
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  xlab("Region") +
  ylab("Number of Schools") +
  ylim(0,500)

# Be careful - using the ylim function is like zooming
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  xlab("Region") +
  ylab("Number of Schools") +
  ylim(50,500) 


# Scales
# x and y axes are examples of more general concept called Scale
# Scales describe how data are mapped from data set to visual representations
# In the plot below there are 3 scales - descrete (categorical), continuous and fill colour
# of each bar.
# Scales can be also related to shape, colour, transparency.
# Scale funcion uses convention: scale_name_datatype
?scale_x_continuous

# Change the name of x-axis
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  scale_x_discrete(name="Region")

# Change the name and limits of the y-axis
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  scale_x_discrete(name="Region") +
  scale_y_continuous(name="Number of Schools", limits=c(0,500))

# Change the fill colors
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  scale_x_discrete(name="Region") +
  scale_y_continuous(name="Number of Schools", limits=c(0,500)) +
  scale_fill_manual(values=c("orange","blue"))
  
#------ Legends --------
# Change the legend title (argument guide_legend(title="Institution Type"))
ggplot(data=college) +
    geom_bar(mapping=aes(x=region, fill=control)) +
    theme(panel.background=element_blank()) +
    theme(plot.background=element_blank()) +
    scale_x_discrete(name="Region") +
    scale_y_continuous(name="Number of Schools", limits=c(0,500)) +
    scale_fill_manual(values=c("orange","blue"), guide_legend(title="Institution Type"))
  
# Adjust the legend formatting
ggplot(data=college) +
    geom_bar(mapping=aes(x=region, fill=control)) +
    theme(panel.background=element_blank()) +
    theme(plot.background=element_blank()) +
    scale_x_discrete(name="Region") +
    scale_y_continuous(name="Number of Schools", limits=c(0,500)) +
    scale_fill_manual(values=c("orange","blue"), guide=guide_legend(title="Institution Type", label.position="bottom", nrow=1, keywidth=2.5))
  
# Move the legend to the bottom of the plot
ggplot(data=college) +
    geom_bar(mapping=aes(x=region, fill=control)) +
    theme(panel.background=element_blank()) +
    theme(plot.background=element_blank()) +
    scale_x_discrete(name="Region") +
    scale_y_continuous(name="Number of Schools", limits=c(0,500)) +
    scale_fill_manual(values=c("orange","blue"), guide=guide_legend(title="Institution Type", label.position="bottom", nrow=1, keywidth=2.5)) +
    theme(legend.position="bottom")
  
# Move the legend to the top of the plot
ggplot(data=college) +
    geom_bar(mapping=aes(x=region, fill=control)) +
    theme(panel.background=element_blank()) +
    theme(plot.background=element_blank()) +
    scale_x_discrete(name="Region") +
    scale_y_continuous(name="Number of Schools", limits=c(0,500)) +
    scale_fill_manual(values=c("orange","blue"), guide=guide_legend(title="Institution Type", label.position="bottom", nrow=1, keywidth=2.5)) +
    theme(legend.position="top")

#----- Anotations -------
# Add a text annotation
ggplot(data=college) +
  geom_point(mapping=aes(x=tuition, y=sat_avg, color=control, size=undergrads), alpha=1/2) +
  annotate("text", label="Elite Privates", x=45000,y=1500)

# Add a line for the mean SAT score
ggplot(data=college) +
  geom_point(mapping=aes(x=tuition, y=sat_avg, color=control, size=undergrads), alpha=1/2) +
  annotate("text", label="Elite Privates", x=45000,y=1500) +
  geom_hline(yintercept=mean(college$sat_avg))

# And label it
ggplot(data=college) +
  geom_point(mapping=aes(x=tuition, y=sat_avg, color=control, size=undergrads), alpha=1/2) +
  annotate("text", label="Elite Privates", x=45000,y=1500) +
  geom_hline(yintercept=mean(college$sat_avg)) +
  annotate("text", label="Mean SAT", x=47500, y=mean(college$sat_avg)-15)

# Add a line for mean tuition
ggplot(data=college) +
  geom_point(mapping=aes(x=tuition, y=sat_avg, color=control, size=undergrads), alpha=1/2) +
  annotate("text", label="Elite Privates", x=45000,y=1500) +
  geom_hline(yintercept=mean(college$sat_avg)) +
  annotate("text", label="Mean SAT", x=47500, y=mean(college$sat_avg)-15) +
  geom_vline(xintercept=mean(college$tuition)) +
  annotate("text", label="Mean Tuition", x=mean(college$tuition)+7500, y=700)

# And let's tidy this up a bit more
ggplot(data=college) +
  geom_point(mapping=aes(x=tuition, y=sat_avg, color=control, size=undergrads), alpha=1/2) +
  annotate("text", label="Elite Privates", x=45000,y=1500) +
  geom_hline(yintercept=mean(college$sat_avg), color="dark grey") +
  annotate("text", label="Mean SAT", x=47500, y=mean(college$sat_avg)-15) +
  geom_vline(xintercept=mean(college$tuition), color="dark grey") +
  annotate("text", label="Mean Tuition", x=mean(college$tuition)+7500, y=700) +
  theme(panel.background = element_blank(), legend.key = element_blank()) +
  scale_color_discrete(name="Institution Type") +
  scale_size_continuous(name="Undergraduates") +
  scale_x_continuous(name="Tuition") +
  scale_y_continuous(name="SAT Scores")

#----- Title -----
# Add a title (using ggtitle with subtitle)
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme(panel.background=element_blank()) +
  theme(plot.background=element_blank()) +
  scale_x_discrete(name="Region") +
  scale_y_continuous(name="Number of Schools", limits=c(0,500)) +
  scale_fill_manual(values=c("orange","blue"), guide=guide_legend(title="Institution Type", label.position="bottom", nrow=1, keywidth=2.5)) +
  theme(legend.position="bottom") +
  ggtitle("More colleges are in the southern U.S. than any other region.")

#----- Themes ---------
# Try some different themes
ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme_bw()

ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme_minimal()

ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme_void()

ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme_dark()

# Check out ggthemes
install.packages("ggthemes")
library(ggthemes)

ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme_solarized()

ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme_excel()

ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme_wsj()

ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme_economist()

ggplot(data=college) +
  geom_bar(mapping=aes(x=region, fill=control)) +
  theme_fivethirtyeight()





