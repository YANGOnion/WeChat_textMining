library(magrittr)
library(jiebaR)
seg = worker() 
kw_seg=worker("keywords", topn=1)

cleanText=function(text){
  require(stringr)
  text=gsub('\\[.+?\\]','',text)
  text=gsub('[[:punct:]0-9a-zA-Z ]+','',text)
  return(text)
}

extractStickers=function(text){
  require(stringr)
  require(magrittr)
  str_extract_all(text,"\\[.+?\\]|/:[a-zA-Z]+")%>%unlist%>%gsub(pattern='[[:punct:]]',replacement='')%>%return
}

## words freq
words2017=dt_full[year==2017,message%>%cleanText%>%segment(jiebar=seg)]
freq2017=freq(words2017)%>%data.table
stwd=readr::read_lines('data/stop_words.utf8')
freq2017=freq2017[!char%in%stwd]
wordcloud2(freq2017[freq>=20],size=1)

## keywords
kw2017=dt_full[year==2017,lapply(message%>%cleanText,keywords,jiebar=kw_seg)]%>%unlist
kwfreq2017=freq(kw2017)%>%data.table
wordcloud2(kwfreq2017[freq>=10],size=1,shape='star')

## stickers
stk2017=dt_full[year==2017,message%>%extractStickers]
stkfreq2017=freq(stk2017)%>%data.table
stkfreq2017=stkfreq2017[freq>=2]



