library(stringr)
setwd("~/Dropbox/__MyPers Archive/Sprint Kayak/Results")
year <- c(2012:2019)
levs <- c("Bantam", "Juvenile", "Junior", "Senior", "Master")
for(boats in list("K1", "C1", c("K1", "C1"))){
  for(gen in c("Men", "Women")){
    vals <- c()
    for(j in year){
      i <- paste0("Scrapped Data Files/US Nationals ", j, ".csv")
      test <- read.csv(i, stringsAsFactors = FALSE)
      if(j %in% c(2012:2013, 2016:2017)){
        i <- paste0("Scrapped Data Files/US Masters Nationals ", j, ".csv")
        test2 <- read.csv(i, stringsAsFactors = FALSE)
        test <- rbind(test, test2)
      }
      df <- subset(test, boat %in% boats & gender==gen)
      df$level[str_detect(df$race.name, "Mas") | str_detect(df$level, "Mas")] <- "Master"
      df2 <- tapply(df$name, df$level, function(x){x})
      df2$Juvenile <- df2$Juvenile[!(df2$Juvenile %in% df2$Bantam)]
      df2$Junior <- df2$Junior[!(df2$Junior %in% df2$Bantam) & !(df2$Junior %in% df2$Juvenile)]
      df2$Senior <- df2$Senior[!(df2$Senior %in% df2$Junior) & !(df2$Senior %in% df2$Master) & !(df2$Senior %in% df2$Juvenile)]
      val <- lapply(df2, function(x){length(unique(x))})
      val <- unlist(val)
      #val <- tapply(df$name, df$level, function(x){length(unique(x))})
      vals <- cbind(vals, val[levs])
    }
    colnames(vals) <- year
    rownames(vals) <- levs
    cat("\n", boats, gen, "\n")
    print(vals)
  }
}
