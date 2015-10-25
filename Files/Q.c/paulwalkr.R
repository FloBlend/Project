# install.packages(c("ggplot2") # only run this if ggplot2 is not yet installed
install.packages(c("plyr")
library(ggplot2)
library(plyr)
# Set the working directory
setwd('C:/Users/Martijn/Desktop/Films_Martijn/Films_Martijn')

# reference to the review file
reviewFile = "AngeloWilson.txt"
# read the reviews as tab-separated values
reviews = read.csv(reviewFile, stringsAsFactors=FALSE, sep = '\t')

# add names to the columns
names(reviews) <- c("date","rating","helpful","total","title","text")

# interpret column values as dates
reviews$date <- as.Date(reviews$date, "%Y-%m-%d") 
# add month column
reviews$month <- as.Date(cut(reviews$date, breaks = "month"))

# aggregate mean rating per month
aggr <- aggregate(reviews$rating ~ reviews$month, FUN = mean) 
# add frequency column aggregate per month
aggr$freq = count(reviews$month)$freq 
# add names to the aggr data frame
names(aggr) <- c("month","avg_rating","num_ratings") 

# set up a two-plot graph
par(mfrow=c(2,1))
# plot avg_rating per month
plot(avg_rating ~ month, data= aggr[aggr$month >= as.Date("2011-01-01", format= "%Y-%m-%d"),], 
     type="s", xlab="Month", ylab="ratings")
# plot avg_rating per month
plot(num_ratings ~ month, data= aggr[aggr$month <= as.Date("2015-01-01", format= "%Y-%m-%d"),], 
     type="s", xlab="Month", ylab="# ratings")




