# If you have scraped new files, then source this file.
# You don't need to be in this directory.
# Then go to Times directory and run update_mydata.R
# Then click on app.R, run and reconnect

# bind results together and error check
# make sure to source str_functions.R
# Run all code between; can source this
# creates fullresults.csv and Paddlers.csv in Times folder
# 
###############################################
if(Sys.info()["sysname"]=="Windows"){
  basedir = "C:/Users/Eli.Holmes/"
  }else{
    basedir = "~/"
  }
source(paste0(basedir,"Dropbox/__MyPers Archive/Sprint Kayak/Paddling_Results/R/str_functions.R"))

setwd(paste0(basedir,"Dropbox/__MyPers Archive/Sprint Kayak/Results/Scrapped Data Files"))

library(stringr)
files=dir()
files=files[str_detect(files,"csv") & files!="fullresults.csv" & files!="name-resolver.csv"]
mydata=data.frame()
for(i in files){
 tmp=read.csv(i,stringsAsFactors = FALSE, colClasses=c(name="character",boat="character",event="numeric",gender="character", time="numeric",
                                                       type="character",finish="character",level="character",venue="character",month="numeric",
                                                       day="numeric",year="numeric",certified="character",notes="character",venue.long="character",
                                                       race.name="character"),na.strings="")
 mydata=rbind(mydata,tmp)
}
for(j in c("notes","venue.long","race.name","level","type","finish")) mydata[j][is.na(mydata[j]) | mydata[j]=="NA"]=""
mydata$type=str_proper(mydata$type)
mydata$level=str_proper(mydata$level)

#mydata=mydata[order(mydata$name),]
#clean names
resolver=read.csv("name-resolver.csv", stringsAsFactors = FALSE)
#resolver$alt.name=str_replace_all(resolver$alt.name,"[(]","[(]")
#resolver$alt.name=str_replace_all(resolver$alt.name,"[)]","[)]")
# for(i in 1:dim(resolver)[1]){
#   #if(any(mydata$name==resolver$alt.name[i])) mydata$name[mydata$name==resolver$alt.name[i]]=resolver$name[i]
#   if(any(str_detect(mydata$name,resolver$alt.name[i]))){
# mydata$name = str_replace(mydata$name,resolver$alt.name[i],resolver$name[i])
#   }
#   if(any(mydata$name==resolver$alt.name[i])) mydata$name[mydata$name==resolver$alt.name[i]]=resolver$name[i]
# }
# boat42=(mydata$boat=="K4" | mydata$boat=="C4" | mydata$boat=="K2" | mydata$boat=="C2")
# sortednames=sapply(mydata$name[boat42], function(x){ paste(sort(str_split(x,"; ")[[1]]), collapse="; ") })
# mydata$name[boat42]=sortednames

# Change to make a little safer.  Won't replace 'abc' with 'abcc' if str_replace(x,"ab","abc")
for(i in 1:dim(resolver)[1]){
  if(any(mydata$name==resolver$alt.name[i])) mydata$name[mydata$name==resolver$alt.name[i]]=resolver$name[i]
}
boat42=(mydata$boat=="K4" | mydata$boat=="C4" | mydata$boat=="K2" | mydata$boat=="C2")
names42=sapply(mydata$name[boat42], function(x){ str_split(x,"; ")[[1]] })
for(i in which(boat42)){
  aa = str_split(mydata$name[i],"; ")[[1]]
  aa = sapply(aa, function(x){if(any(x==resolver$alt.name)) resolver$name[which(x==resolver$alt.name)] else x})
  mydata$name[i] = paste(sort(aa), collapse="; ")
}


write.csv(mydata, row.names=FALSE, file="fullresults.csv")
setwd(paste0(basedir,"Dropbox/__MyPers Archive/Sprint Kayak/Times"))
write.csv(mydata, row.names=FALSE, file="fullresults.csv")

#bind paddlers
setwd(paste0(basedir,"Dropbox/__MyPers Archive/Sprint Kayak/Results/Scrapped Data Files/paddlers"))
files=dir()
paddlers3=c()
hold = c()
for(fil in files){
  tmp=read.csv(fil, stringsAsFactors=FALSE)
  paddlers3=rbind(paddlers3,tmp)
}
paddlers3=paddlers3[order(paddlers3$age),]
#paddlers3$name=str_proper(paddlers3$name)
paddlers3=paddlers3[order(paddlers3$name),]
paddlers3$club[is.na(paddlers3$club)]=""
paddlers3$type[is.na(paddlers3$type)]=""
paddlers3=paddlers3[!duplicated(paddlers3$name),]
paddlers3=paddlers3[order(paddlers3$name),]

# Create list of all paddlers in US Nationals and other US races
# These are paddlers not in the other paddlers files and assumed to be USA
bad = c("OHR", "Worlds", "Canadian", "Pan", "Pacific Cup", "Slawko")
badvenue = FALSE
for(i in bad) badvenue = badvenue | str_detect(mydata$venue, i)
usnames = mydata[!badvenue & mydata$boat %in% c("K1", "C1"),c("name","gender")]
#usnames$name=str_proper(usnames$name)
usnames = usnames[!duplicated(usnames$name),]
usnames = usnames[order(usnames$name),]
usnames$gender = str_sub(usnames$gender,1,1)
usnames$gender[usnames$gender=="W"]="F"
#new if not in one of the paddler files
newusnames=usnames[!(usnames$name%in%paddlers3$name),]
paddlers4=data.frame(name=newusnames$name,age=NA,club=NA,boat=NA,gender=newusnames$gender,country="USA",type=NA,stringsAsFactors = FALSE)

paddlers5=rbind(paddlers3,paddlers4)
paddlers5=paddlers5[order(paddlers5$name),]
resolver=read.csv(paste0(basedir,"Dropbox/__MyPers Archive/Sprint Kayak/Results/Scrapped Data Files/name-resolver.csv"), stringsAsFactors = FALSE)
for(i in 1:dim(resolver)[1]){
  if(any(paddlers5$name==resolver$alt.name[i])) 
    paddlers5$name[paddlers5$name==resolver$alt.name[i]]=resolver$name[i]
}
paddlers5=paddlers5[order(paddlers5$age),]
paddlers5=paddlers5[!duplicated(paddlers5$name),]
paddlers5=paddlers5[order(paddlers5$name),]
setwd(paste0(basedir,"Dropbox/__MyPers Archive/Sprint Kayak/Times"))
write.csv(paddlers5, row.names=FALSE, file="Paddlers.csv")

########################################

# #code to develop name-resolver
# fullname=(unique(mydata$name[mydata$boat=="C2"]))
# fullname=(unique(mydata$name[mydata$boat=="C1"]))
# fullname=(unique(mydata$name[mydata$boat=="K1"]))
# fullname=unique(mydata$name)
# lastname=unlist(sapply(fullname, function(x){str_split(x," ")[[1]][2]}))
# firstname=unlist(sapply(fullname, function(x){str_split(x," ")[[1]][1]}))
# fullname[order(lastname)]
# fullname[order(firstname)]
# 
# fullname=(unique(mydata$name[mydata$boat=="K1"]))
# lastname=unlist(sapply(fullname, function(x){str_split(x," ")[[1]][2]}))
# fullname[order(lastname)]
# toolong=unlist(sapply(fullname,function(x){ lapply(str_split(x," "),
#                                    function(x){length(x)>2}) }))
# fullname[toolong]
# tmp=data.frame(name=NA, alt.name=fullname[toolong])
# tmp$name=unlist(lapply(str_split(fullname[toolong]," "),
#                        function(x){paste(x[1],x[length(x)])}))
# newresolver=rbind(resolver,tmp)
# write.csv(newresolver,row.names=FALSE,file="name-resolver.csv")
# 
# tmp=sort(unlist(str_split(fullname,"-")))
# 
# # Misc clean up for hand entered files
# for(i in files){
#   tmp=read.csv(i,stringsAsFactors = FALSE)
#   if("gender" %in% colnames(tmp)){
#     redo=FALSE
#     if(any(is.na(tmp$gender))) browser()
#     if(any(tmp$gender=="M")|any(tmp$gender=="F")) redo=TRUE
#     tmp$gender[tmp$gender=="M"]="Men"
#     tmp$gender[tmp$gender=="F"]="Women"
#     if(redo) write.csv(tmp, row.names=FALSE, file=i)
#   }
# }
# 
# # Error checking
# for(i in files){
#   tmp=read.csv(i,stringsAsFactors = FALSE)
#     if(any(is.na(tmp$boat))){cat(i);cat("\n")}
# }
# for(i in files){
#   tmp=read.csv(i,stringsAsFactors = FALSE)
#   if(any(is.na(tmp$year))){cat(i);cat("\n")}
# }
# for(i in files){
#   tmp=read.csv(i,stringsAsFactors = FALSE)
#   if(!("gender"%in%colnames(tmp))){cat(i);cat("\n")}
# }
# for(i in files){
#   tmp=read.csv(i,stringsAsFactors = FALSE)
#   if(any(is.na(tmp$level))){cat(i);cat("\n")}
# }
# for(i in files){
#   tmp=read.csv(i,stringsAsFactors = FALSE)
#   if(any(is.na(tmp$event))){cat(i);cat("\n")}
# }
# for(i in files){
#   tmp=read.csv(i,stringsAsFactors = FALSE)
#   if(any(is.na(tmp$year))){cat(i);cat("\n")}
# }
# apply(mydata,2,function(x){any(is.na(x))})
# 
# fullname=(unique(mydata$name[mydata$boat=="C4"]))
# bad=fullname[which(sapply(fullname, function(x){ length(str_split(x,"; ")[[1]])!=4 }))]
# mydata[which(mydata$name%in%bad & mydata$boat=="C4" & !is.na(mydata$time)),c("name","venue","race.name")]
# 
# fullname=(unique(mydata$name[mydata$boat=="C2"]))
# bad=fullname[which(sapply(fullname, function(x){ length(str_split(x,"; ")[[1]])!=2 }))]
# mydata[which(mydata$name%in%bad & mydata$boat=="C2" & !is.na(mydata$time)),c("name","venue","race.name")]
# 
# fullname=(unique(mydata$name[mydata$boat=="C1"]))
# bad=fullname[which(sapply(fullname, function(x){ length(str_split(x,"; ")[[1]])!=1 }))]
# mydata[which(mydata$name%in%bad),c("name","venue","race.name")]
# 
# fullname=(unique(mydata$name[mydata$boat=="K4"]))
# bad=fullname[which(sapply(fullname, function(x){ length(str_split(x,"; ")[[1]])!=4 }))]
# mydata[which(mydata$name%in%bad & mydata$boat=="K4" & !is.na(mydata$time)),c("name","venue","race.name")]
# 
# fullname=(unique(mydata$name[mydata$boat=="K2"]))
# bad=fullname[which(sapply(fullname, function(x){ length(str_split(x,"; ")[[1]])!=2 }))]
# mydata[mydata$name%in%bad & mydata$boat=="K2" & !is.na(mydata$time),c("name","venue","race.name")]
# 
# fullname=(unique(mydata$name[mydata$boat=="K1"]))
# bad=fullname[which(sapply(fullname, function(x){ length(str_split(x,"; ")[[1]])!=1 }))]
# mydata[which(mydata$name%in%bad),c("name","venue","race.name")]

# aa=sort(unique(mydata$name))
# aaa=c(); for(i in aa) aaa=c(aaa, str_trim(str_split(i,"; ")[[1]]))
# sort(unique(aaa))
