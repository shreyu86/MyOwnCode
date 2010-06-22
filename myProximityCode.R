# You will probably read these from an external file or a database
goodWords <- c("candesartan cilexetil", "glyburide", "nifedipine", "digoxin", "blabla", "warfarin", "hydrochlorothiazide")
badWords <- c("no significant", "other drugs")

mytext <- "no significant drug interactions have been reported in studies of candesartan cilexetil given with other drugs such as glyburide, nifedipine, digoxin, warfarin, hydrochlorothiazide."
mytext <- tolower(mytext) # Let's make life a little bit easier...

goodPos <- NULL
badPos <- NULL

# First we find the good words
for (w in goodWords)
    {
    pos <- regexpr(w, mytext)
    if (pos != -1)
        {
        cat(paste(w, "found at position", pos, "\n"))
        }
    else    
        {
        pos <- NA
        cat(paste(w, "not found\n"))
        }

    goodPos <- c(goodPos, pos)
    }

# And then the bad words
for (w in badWords)
    {
    pos <- regexpr(w, mytext)
    if (pos != -1)
        {
        cat(paste(w, "found at position", pos, "\n"))
        }
    else    
        {
        pos <- NA
        cat(paste(w, "not found\n"))
        }

    badPos <- c(badPos, pos)
    }

# Note that we use -badPos so that when can calculate the distance with rowSums
comb <- expand.grid(goodPos, -badPos)
wordcomb <- expand.grid(goodWords, badWords)
dst <- cbind(wordcomb, abs(rowSums(comb)))

mn <- which.min(dst[,3])
cat(paste("The closest good-bad word pair is: ", dst[mn, 1],"-", dst[mn, 2],"\n"))

