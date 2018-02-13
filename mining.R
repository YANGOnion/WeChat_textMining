
# summary
dt_full[year==2017,table(type)]

# week
library(ggplot2)
dt_2017=data.table(date=seq(as.Date('2017-01-01'),as.Date('2017-12-31'),1),week=c(7,rep(seq(1,7,1),52)))%>%merge(dt_full[year==2017],by='date')
dt=dt_2017[,.N,by=hh]
ggplot(dt, aes(x=hh,y=N))+geom_area(fill="springgreen4",alpha=.2)+
  geom_line(size=2,colour='springgreen4',alpha=.5)+geom_point()+theme_minimal(base_size=15)+
  coord_flip()+xlab('小时')+ylab('消息数')
dt=dt_2017[,.N,by=month]
ggplot(dt, aes(x=month,y=N))+geom_area(fill="springgreen4",alpha=.2)+
  geom_line(size=2,colour='springgreen4',alpha=.5)+geom_point()+theme_minimal(base_size=15)+
  coord_flip()+xlab('月份')+ylab('消息数')+scale_x_continuous(breaks=seq(1,12,1),labels=seq(1,12,1))


# wordcloud
library(wordcloud2)
wordcloud2(kwfreq2017[!char%in%c('早安','晚安')][freq>=20],size = 1,fontFamily="微软雅黑",
           minRotation=-pi/2,maxRotation=-pi/2,rotateRatio = 1)
wordcloud2(kwfreq2017[freq>=20],size = 1,fontFamily="微软雅黑",
           minRotation=-pi/2,maxRotation=-pi/2,rotateRatio = 1)


# stickers
stkfreq2017[order(freq,decreasing=T)][1:13]

# sorry
dt_2017[str_detect(message,'我错了')==TRUE,.N,by=user]
dt_2017[str_detect(message,'怪我')==TRUE,.N,by=user]
dt_2017[str_detect(message,'sorry')==TRUE,.N,by=user]
library(fmsb)
dt=data.table(a=c(118,0,118,51),b=c(118,0,23,44),c=c(118,0,29,28))
colnames(dt)=c('我错了','怪我','sorry')
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) )
radarchart( dt  , axistype=2 , 
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,120,20), cglwd=0.8,
            #custom labels
            vlcex=1.5,palcex=1
)
legend(x=0.7, y=1, legend = c("zzy","ywc"), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.5, pt.cex=3)
dt_2017[str_detect(message,'烦')==TRUE,.N,by=user]
dt_2017[str_detect(message,'哎')==TRUE,.N,by=user]

# animal
dt_2017[str_detect(message,'兔')==TRUE,.N]
dt_2017[str_detect(message,'鼠')==TRUE,.N]
dt_2017[str_detect(message,'狗')==TRUE,.N]
dt_2017[str_detect(message,'猫')==TRUE,.N]

# eat
dt_2017[str_detect(message,'吃')==TRUE,.N,by=user]
dt_2017[str_detect(message,'饿')==TRUE,.N,by=user]

# time for get up
dt=dt_2017[str_detect(message,'早安')==TRUE]
dt[,mean(hh+mm/60),by=user]


