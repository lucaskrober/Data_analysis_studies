data(mtcars) ## load "mtcars" dataset into global environment
?mtcars ## getting help on "mtcars" data set

##---------- C-Q case ---------##
class(mtcars$vs) 
mtcars$vs <- factor(mtcars$vs, ## changing class of "mtcars$vs" from "numeric" to "factor"
                    levels=c(0,1), ## assigning to values "0" and "1" names of engines
                    labels=c("V-shaped","Straight")) ## assigning to values "0" and "1" names of engines
mtcars$am <- factor(mtcars$am, ## changing class of "mtcars$am" from "numeric" to "factor"
                    levels=c(0,1), ## assigning to values "0" and "1" types of transmission
                    labels=c("automatic","manual")) ## assigning to values "0" and "1" types of transmission
boxplot(mtcars$hp ~ mtcars$vs,col="blue") ## creating boxplot for values of horsepower for both types of engine
hist(mtcars$hp[mtcars$vs=="V-shaped"], col="red",breaks=10,xlim=c(0,350),main="Histogram")  # histogram of V-shaped
hist(mtcars$hp[mtcars$vs=="Straight"], col=rgb(0, 0, 1, 0.7), add=T)  # overlapping histogram of Straight

##---------- C-C case ---------##
summary(mtcars[,c(8,9)])
table(mtcars$vs,mtcars$am) ## creating two way table
addmargins(table(mtcars$vs,mtcars$am)) ## creating two way table with margins
margin.table(table(mtcars$vs,mtcars$am),1) ## row margins only
margin.table(table(mtcars$vs,mtcars$am),2) ## column margins only
barplot(table(mtcars$vs,mtcars$am),legend.text = T,beside=T) ## creating barplot

##---------- C-C case ---------##
mtcars[,c(4,7)]
plot(mtcars$hp,mtcars$qsec,pch=20,col="blue",cex=2.5) ## creating a plot
points(mtcars$hp[mtcars$am=="automatic"],mtcars$qsec[mtcars$am=="automatic"],col="black",pch=20) ## adding a layer of points for "automatic" transmission only
points(mtcars$hp[mtcars$am=="manual"],mtcars$qsec[mtcars$am=="manual"],col="red",pch=20) ## adding a layer of points for "manual" transmission only
model.full <- lm(mtcars$qsec~mtcars$hp) ## linear regression
model.auto <- lm(mtcars$qsec~mtcars$hp,subset=mtcars$am=="automatic") ## linear regression for "automatic" only
model.man <- lm(mtcars$qsec~mtcars$hp,subset=mtcars$am=="manual") ## linear regression for "manual" only
abline(model.full,lwd=2,col="blue") ## adding regression line to plot
abline(model.auto,lwd=2,col="black") ## adding regression line to plot for "automatic" only
abline(model.man,lwd=2,col="red") ## adding regression line to plot for "manual" only
legend("topright",legend=c("manual","automatic"),col=c("red","black"),lwd=2) ## adding legend to the plot