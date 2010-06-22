library("RCurl")
library("XML")
library("lattice")
#
#be sure and put your username and passy here
username<-"YourUserName"
passy<-"YourPass"
#
#This sets up the options for curl
#then makes the request from the Twitter API
#the count=200 option pulls the last 200 tweets from your friends
#the twitter api limits you to a max of 200.... yeah, well that's life
#
opts <- curlOptions(header = FALSE, userpwd = paste(username,":",passy,sep=""))
request <- "http://twitter.com/statuses/friends_timeline.xml?count=200"
timeline <- getURL(request,.opts = opts)
#
#Now let's beat up on the XML like it owes us money
doc <- xmlInternalTreeParse(timeline, useInternalNodes = TRUE)
#
#grab only the screen_names and make a list
xml_names_of_posters <- getNodeSet(doc, "/statuses/status/user/screen_name")
text_names_of_posters <- lapply(xml_names_of_posters,xmlValue)
#
#let's take it out of a list... just for kicks
Twitterbaters <- unlist(text_names_of_posters)
#
#and shove it into a data frame... seems like going around my
#ass to get to my elbow, but I want to put it in a table eventually
#table is kinda like a cross tab. It calcs the frequency for me
posters_list_df<-as.data.frame(Twitterbaters)
Tweets = table(posters_list_df)
#
#lets graph this monkey business with lattice
#
NiftyChart<-barchart(~sort(Tweets), main=list("Who's Tweets Am I Getting?" ,cex=1),xlab=list("Number of Tweets",cex=1))
NiftyChart
update(NiftyChart, col="brown")
#
