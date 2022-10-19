# Challenge:
# Writing a function myColMeans that takes a dataset as an argument and returns a list, in which a name
# of an element corresponds to the column name of a dataset and a value is a mean of the column. 
# For columns where mean can't be calculated the value should be equal to NA. 
# Check function myColMeans on mtcars dataset.

car=mtcars #just to allow me to modify mtcars data
car$test="test"; #just for testing if assing NA to non-numeric variables is working

myColMeans<-function(x){
  mean_c=NULL #creating the object with NULL value
    for( i in 1:ncol(x)){
    if(class(x[,i])=="numeric"){
      mean_c[i] = as.list(apply(x[i],2,mean)) #if numeric, return a list of means
    }else{
      mean_c[i] = NA #if not numeric, then assing NA to it
    }
  }
  return (mean_c)
}

mean=myColMeans(car); #creating object with function myColMeans
names(mean) <- names(car);mean #naming each attribute in the list according to mtcars data

#comparing myColMeans (challenge function) to colMeans (R built-in function)
colMeans(car) # error message because of the non-numeric variable "test"
colMeans(mtcars) # returns a vector of means 


# So, basically, the difference between "myColMeans" function and "colMeans" r built-in function 
# is that "colMeans" returns a vector and "myColMeans" returns a list.
# Also, "colMeans" can't calculate the numerical variable means if all the columns weren't 
# numerical too, if there is a single column with different class in your dataframe, then the 
# R built-in function "colMeans" will get you an error message saying that "x" must be numeric.

# Instead, myColMeans look at the class of the columns and if it isn't numeric, it apply "NA" to it and 
# calculate all the other means 