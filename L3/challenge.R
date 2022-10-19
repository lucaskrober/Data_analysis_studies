challenge=ToothGrowth
View(challenge)

supp1=subset(challenge, supp=="VC")
supp2=subset(challenge, supp=="OJ")

h=1280
w=780
x11(h,w)
par(mfrow=c(1,2))
with(supp1,boxplot(len,main="Supplement = VC",ylab="Tooth Length"))
with(supp2,boxplot(len,main="Supplement = OJ",ylab="Tooth Length"))


iris=iris
names(iris)
especies=unique(iris$Species);especies
i=iris$Species=="setosa"
cor(iris[i, "Sepal.Length"], iris[i, "Petal.Length"])
i2=iris$Species=="versicolor"
cor(iris[i2, "Sepal.Length"], iris[i2, "Petal.Length"])
i3=iris$Species=="virginica"
cor(iris[i3, "Sepal.Length"], iris[i3, "Petal.Length"])

# One way to do this:
sp1=subset(iris,Species=="setosa")
sp2=subset(iris,Species=="versicolor")
sp3=subset(iris,Species=="virginica")

h=1280
w=780
x11(h,w)
par(mfrow=c(1,3))
plot(Petal.Length~Sepal.Length,data=sp1,pch=16,col=1,main="Setosa",ylim=range(0,8),ylab="Petal Length",xlab="Sepal Length")
plot(Petal.Length~Sepal.Length,data=sp2,pch=16,col=1,main="Versicolor",ylim=range(0,8),ylab="Petal Length",xlab="Sepal Length")
plot(Petal.Length~Sepal.Length,data=sp3,pch=16,col=1,main="Verginica",ylim=range(0,8),ylab="Petal Length",xlab="Sepal Length")

#or we can do like this

x11()
plot(Petal.Length~Sepal.Length,data=iris,pch=20,col=c(1,2,3)[iris$Species],ylab="Petal Length",xlab="Sepal Length")


# Comparing:
h=1280
w=780
x11(h,w)
par(mfrow=c(2,2))
plot(Petal.Length~Sepal.Length,data=sp1,pch=20,col=1,main="Setosa",ylim=range(0,8),ylab="Petal Length",xlab="Sepal Length")
plot(Petal.Length~Sepal.Length,data=sp2,pch=20,col=1,main="Versicolor",ylim=range(0,8),ylab="Petal Length",xlab="Sepal Length")
plot(Petal.Length~Sepal.Length,data=sp3,pch=20,col=1,main="Verginica",ylim=range(0,8),ylab="Petal Length",xlab="Sepal Length")
plot(Petal.Length~Sepal.Length,data=iris,pch=20,col=c(1,2,3)[iris$Species],ylab="Petal Length",xlab="Sepal Length")
