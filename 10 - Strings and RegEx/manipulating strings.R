
##---- Manipulating strings in R -----------

# Define a vector of strings that may have a word "cat" in them
myVector <- c("education", "notification", "cattle", "underdogs", "bulldog")


?grep
# g/RegEx/p => g/re/p => grep

#---- Find positions of elements in vector that contain word "cat" in them
grep("cat", myVector)
myVector[grep("cat", myVector)]

grep("cat", myVector, perl=TRUE, value=FALSE)

#---- Find elements in vector that contain word "cat" in them
grep("cat", myVector, perl=TRUE, value=TRUE)

#---- Function grepl() that returns logical vector of TRUE and FALSE
grepl("cat", myVector, perl=TRUE)

#---- Find the position of the first match of the word "cat' in the string
regexpr("cat", myVector, perl=TRUE)

#---- Find the position of all mathes of word "cat" in the string
gregexpr("cat", myVector, perl=TRUE)
gregexpr("[ae]", myVector, perl=TRUE)

#---- Visualize mathes in the string
myMatches <- gregexpr("[aeiouy].+[aeiouy]", myVector, perl=TRUE)
regmatches(myVector, myMatches)

#---- Substiture the first match in each vector element
sub("cat", "CAT", myVector, perl=TRUE)

#---- Substitute all matches in each vector element
myVector
gsub("[^aeiouy]","X", myVector, perl=TRUE)

library(stringr)



















