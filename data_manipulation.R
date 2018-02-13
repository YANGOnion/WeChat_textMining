

library(data.table)
library(lubridate)
dt_full=Reduce(function(x,y){rbind(x,y)},list(fread('data/1.csv'),fread('data/2.csv'),fread('data/3.csv')))
dt_full[,`:=`(date=as.Date(substr(time,1,10)),hh=as.numeric(substr(time,12,13)),mm=as.numeric(substr(time,15,16)),ss=as.numeric(substr(time,18,19)))]
dt_full[,`:=`(year=year(date),month=month(date),day=day(date))]
dt_full[,as.POSIXlt(time)]
dt_full=dt_full[,.(time,user,type,message,date,year,month,day,hh,mm,ss)]





