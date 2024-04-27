library(stringr)
files=dir()
files=files[str_detect(files,"csv") & files!="fullresults.csv" & files!="name-resolver.csv"]
files=files[str_detect(files,"x") & !(str_detect(files,"_x"))]
for(i in files){
  tmp=read.csv(i,stringsAsFactors = FALSE, colClasses=c(name="character",boat="character",event="numeric",gender="character", time="numeric",
                                                        type="character",finish="character",level="character",venue="character",month="numeric",
                                                        day="numeric",year="numeric",certified="character",notes="character",venue.long="character",
                                                        race.name="character"),na.strings="")
  boat4=(tmp$boat=="K4" | tmp$boat=="C4")
  if(any(boat4)){
    hyphens=which(boat4 & sapply(tmp$name, function(x){nrow(str_locate_all(x, "-")[[1]])==3}) &
                    !any(sapply(tmp$name, function(x){str_detect(x, ";")[[1]]})))
    bad=which(boat4 & sapply(tmp$name, function(x){nrow(str_locate_all(x, "-")[[1]])>3}))
    tmp$name[hyphens]=str_replace_all(tmp$name[hyphens],"-","; ")
    if(length(bad)!=0) browser()
  }
  boat2=(tmp$boat=="K2" | tmp$boat=="C2")
  if(any(boat2)){
    hyphens=which(boat2 & 
                    sapply(tmp$name, function(x){nrow(str_locate_all(x, "-")[[1]])==1}) &
                    !any(sapply(tmp$name, function(x){str_detect(x, ";")[[1]]}))
                  )
    bad=which(boat2 & sapply(tmp$name, function(x){nrow(str_locate_all(x, "-")[[1]])>1}))
    tmp$name[hyphens]=str_replace_all(tmp$name[hyphens],"-","; ")
    if(length(bad)!=0) browser()
  }
  write.csv(tmp, row.names=FALSE, file=i)
}

files=dir()
files=files[str_detect(files,"csv") & files!="fullresults.csv" & files!="name-resolver.csv"]
files=files[str_detect(files,"x") & !(str_detect(files,"_x"))]
for(i in files){
  boat4=(tmp$boat=="K4" | tmp$boat=="C4")
  if(any(boat4)){
    bad=which(boat4 & sapply(tmp$name, function(x){nrow(str_locate_all(x, "; ")[[1]])!=3}))
    if(length(bad)!=0) cat(i, tmp$name[bad],"\n")
  }
  boat2=(tmp$boat=="K2" | tmp$boat=="C2")
  if(any(boat2)){
    bad=which(boat2 & sapply(tmp$name, function(x){nrow(str_locate_all(x, "; ")[[1]])!=1}))
    if(length(bad)!=0) cat(i, tmp$name[bad],"\n")
  }
  
}