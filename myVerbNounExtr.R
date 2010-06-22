

Using an example: (this is to extract words tagged as /VBx, where x is any single character)

library("openNLP")

acq <- "Gulf Applied Technologies Inc said it sold its subsidiaries engaged in pipeline and terminal operations for 12.2 mln dlrs. The company said the sale is subject to certain post closing adjustments, which it did not explain. Reuter."

acqTag <- tagPOS(acq)

sapply(strsplit(acqTag,"[[:punct:]]*/VB.?"),function(x) {res = sub("(^.*\\s)(\\w+$)", "\\2", x); res[!grepl("\\s",res)]} )

