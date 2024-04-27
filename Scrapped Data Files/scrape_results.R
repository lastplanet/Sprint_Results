setwd("C:/Users/Eli.Holmes/Dropbox/__MyPers Archive/Sprint Kayak/Results/Scrapped Data Files")
setwd("~/Dropbox/__MyPers Archive/Sprint Kayak/Results/Scrapped Data Files")
basedir="C:/Users/Eli.Holmes/Dropbox/__MyPers Archive/Sprint Kayak/Results/Scrapped Data Files/"
basedir="~/Dropbox/__MyPers Archive/Sprint Kayak/Results/Scrapped Data Files/"
########### NATIONALS
scrape.raceman("http://sckclub.org/sckc/Nat2012/Junior/resultsByRace/index.html", venue.short="US Nationals", venue.long="USACK Sprint National Championships", basedir=basedir)
scrape.raceman("http://sckclub.org/sckc/Nat2012/masters/resultsByRace/index.html", venue.short="US Masters Nationals", venue.long="USACK Sprint National Championships", basedir=basedir)
scrape.raceman("http://results.deltatiming.com/ck/2013-usack-sprint-nationals/", venue.short="US Nationals", venue.long="USA Canoe/Kayak Sprint Nationals and Paracanoe Nationals", basedir=basedir)
#remove the first 2 novice races by hand.  No boat info
scrape.raceman("http://results.deltatiming.com/ck/2013-usack-sprint-masters-nationals/", venue.short="US Masters Nationals", venue.long="USA Canoe/Kayak Sprint Nationals and Paracanoe Nationals", basedir=basedir)
scrape.raceman("http://sckclub.org/sckc/NT2016/resultsByRace/index.html", venue.short="US Nationals", venue.long="USA Canoe/Kayak Sprint National Championships", basedir=basedir)
scrape.raceman("http://sckclub.org/sckc/NT2016/Masters/resultsByRace/index.html", venue.short="US Masters Nationals", venue.long="USA Canoe/Kayak Sprint National Championships", basedir=basedir)
scrape.raceman("http://sckclub.org/sckc/NT2017/JuniorsSeniors/resultsByRace/index.html", venue.short="US Nationals", venue.long="USA Canoe/Kayak Sprint National Championships", basedir=basedir)
scrape.raceman("http://sckclub.org/sckc/NT2017/Masters/resultsByRace/index.html", venue.short="US Masters Nationals", venue.long="USA Canoe/Kayak Sprint National Championships", basedir=basedir)
#scrape.raceman("file:///Users/eli.holmes/Dropbox/__MyPers%20Archive/Sprint%20Kayak/Results/US%20Nationals/2001%20Nationals/index.html", venue.short="US Nationals", venue.long="USA Canoe/Kayak Sprint National Championships", basedir=basedir)

########### TRIALS
scrape.raceman("http://results.deltatiming.com/ck/2014-usack-sprint-team-trials/", venue.short="US Trials", venue.long="USA Canoe/Kayak Sprint Team Trials", basedir=basedir)
#clean up 2015; para and peewee have probs
scrape.raceman("http://results.deltatiming.com/ck/2015-usack-sprint-team-trials/", venue.short="US Trials", venue.long="USA Canoe/Kayak Sprint Team Trials", basedir=basedir)
tmp=read.csv("US Trials 2015.csv", stringsAsFactors=FALSE)
tmp=tmp[!is.na(tmp$event),]
write.csv(tmp, file="US Trials 2015.csv", row.names=FALSE, quote=FALSE)
scrape.raceman("file:///Users/eli.holmes/Dropbox/__MyPers%20Archive/Sprint%20Kayak/Results/US%20Team%20Trials/2016%20Team%20Trials/index.html", venue.short="US Trials", venue.long="USA Canoe/Kayak Sprint Team Trials", basedir=basedir)

########### TED HOUK
scrape.raceman("http://www.scn.org/rec/sckc/race_results/2003/ted_houk_2003/resultsByRace/index.html", venue.short="Houk", venue.long="Ted Houk Memorial Regatta", basedir=basedir, old.style=TRUE)
scrape.raceman("http://www.scn.org/rec/sckc/race_results/2004/ted_houk_2004/resultsByRace/index.html", venue.short="Houk", venue.long="Ted Houk Memorial Regatta", basedir=basedir, old.style=TRUE)
scrape.raceman("http://www.scn.org/rec/sckc/race_results/2005/th05/resultsByRace/index.html", venue.short="Houk", venue.long="Ted Houk Memorial Regatta", basedir=basedir, old.style=TRUE)
scrape.raceman("http://www.scn.org/rec/sckc/race_results/2006/th06/resultsByRace/index.html", venue.short="Houk", venue.long="Ted Houk Memorial Regatta", basedir=basedir, old.style=TRUE)
scrape.raceman("http://www.scn.org/rec/sckc/race_results/2007/th2007/resultsByRace/index.html", venue.short="Houk", venue.long="Ted Houk Memorial Regatta", basedir=basedir)
scrape.raceman("http://www.scn.org/rec/sckc/race_results/2008/th2008/resultsByRace/index.html", venue.short="Houk", venue.long="Ted Houk Memorial Regatta", basedir=basedir)
#don't rescrape 2009; lots of hand clean up
#scrape.raceman("http://www.scn.org/rec/sckc/race_results/2009/th2009/resultsByRace/index.html", venue.short="Houk", venue.long="Ted Houk Memorial Regatta", basedir=basedir)
scrape.raceman("http://www.scn.org/rec/sckc/race_results/2010/th2010/resultsByRace/index.html", venue.short="Houk", venue.long="Ted Houk Memorial Regatta", basedir=basedir)
# missing 2011-2012
scrape.raceman("http://sckclub.org/sckc/TH2013/resultsByRace/index.html", venue.short="Houk", venue.long="Ted Houk Regatta", basedir=basedir)
scrape.raceman("http://sckclub.org/sckc/TH2014/resultsByRace/index.html", venue.short="Houk", venue.long="Ted Houk Regatta", basedir=basedir)
scrape.raceman("http://sckclub.org/sckc/TH2015/resultsByRace/index.html", venue.short="Houk", venue.long="36th Ted Houk Memorial Regatta", basedir=basedir)
#some bad 200m times
tmp=read.csv("Houk 2015.csv", stringsAsFactors=FALSE)
tmp$time[tmp$event==200 & tmp$time<10 & !is.na(tmp$time)]=NA
write.csv(tmp, file="Houk 2015.csv", row.names=FALSE, quote=FALSE)
scrape.raceman("http://sckclub.org/sckc/TH2016/resultsByRace/index.html", venue.short="Houk", venue.long="37th Ted Houk Memorial Regatta", basedir=basedir)
scrape.raceman("http://sckclub.org/sckc/TH2017/resultsByRace/index.html", venue.short="Houk", venue.long="38th Ted Houk Memorial Regatta", basedir=basedir)
scrape.raceman("http://sckclub.org/sckc/TH2018/resultsByRace/index.html", venue.short="Houk", venue.long="39th Ted Houk Memorial Regatta", basedir=basedir)


