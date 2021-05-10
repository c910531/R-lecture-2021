# 지니 차트 웹 크롤링
library(rvest)
library(stringr)
library(dplyr)
library(httr)
url <- 'https://www.genie.co.kr/chart/top200?ditc=D&rtm=N'
ua <- 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36
'
res <- GET(url=url, user_agent(agent=ua))
html <- read_html(res, encoding = 'UTF-8')

table <- html %>% 
    html_node('div.newest-list') %>% 
    html_node('table')
trs <- table %>% 
    html_node('tbody') %>% 
    html_nodes('tr')

# 전주 순위 : 1, 2, 3, 22 (유지, 상승, 하강, 신규)
tr <- trs[1]
rank <- tr %>% 
    html_node('tr.number') %>% 
    html_text()
rank <- as.integer(rank)


for (i in 1:100) {
    tr <- trs[i]    
    tds <- html_nodes(tr,'td') 
    spans <- html_nodes(tds[3], 'span')
    last_str <- html_text(spans[3])
    if (length(spans)== 4) {
        t <- as.integer(html_text(spans[4]))
        if (last_str == '순위 동일') {
            last_rank <- rank
        } else if (last_str == '단계 상승') {
            last_rank <- rank + t
        } else {
            last_rank <- rank - t
        }
    } else {
        last_rank <- 999
    }
}

anchors <- tr %>% 
    html_node('.info') %>% 
    html_nodes('a')
title <- html_text(anchors[1])
artist <- html_text(anchors[2])

title <- tr %>% 
    html_node('.title ellipsis') %>% 
    html_node('a') %>% 
    html_text()
artist <- tr %>% 
    html_node('.artist ellipsis') %>% 
    html_node('a') %>% 
    html_text()
album <- tr %>% 
    html_node('.albumtitle ellipsis') %>% 
    html_node('a') %>% 
    html_text()

rank_vec <- c()
last_vec <- c()
title_vec <- c()
artist_vec <- c()
album_vec <- c()
for (tr in trs) {
    rank <- tr %>% 
        html_node('td.number') %>% 
        html_text()
    rank
    
    tds <- html_nodes(tr,'td') 
    spans <- html_nodes(tds[4], 'span')
    last_str <- html_text(spans[4])
    if (length(spans)==4) {
        t <- as.integer(html_text(spans[5]))
        if (last_str == '순위 동일') {
            last_rank <- rank
        } else if (last_str == '단계 상승') {
            last_rank <- rank + t
        } else {
            last_rank <- rank - t
        }
    } else {
        last_rank <- 999
    }
    title <- tr %>% 
        html_node('.title ellipsis') %>% 
        html_node('a') %>% 
        html_text()
    artist <- tr %>% 
        html_node('.artist ellipsis') %>% 
        html_node('a') %>% 
        html_text()
    album <- tr %>% 
        html_node('.albumtitle ellipsis') %>% 
        html_node('a') %>% 
        html_text()
    
    rank_vec <- c(rank_vec, rank)
    last_vec <- c(last_vec, last_rank)
    title_vec <- c(title_vec, title)
    artist_vec <- c(artist_vec, artist)
    album_vec <- c(album_vec, album)
}
week_chart <- data.frame(
    rank=rank_vec, last_rank=last_vec, title=title_vec,
    artist=artist_vec, album=album_vec)

View(week_chart)
