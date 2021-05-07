# Wiki '빅 데이터' 검색 결과 워드 클라우드 만들기
library(RCurl)
library(XML)
library(SnowballC)
library(tm)
library(wordcloud2)

enc <- URLencode(iconv('빅 데이터', 'CP949', 'UTF-8'))

URLdecode(enc)

enc <- '%EB%B9%85_%EB%8D%B0%EC%9D%B4%ED%84%B0' # 빅 데이터
url <- paste0('https://ko.wikipedia.org/wiki/',enc)
url
html <- readLines(url)
html <- htmlParse(html, asText=T)
doc <- xpathSApply(html, '//p', xmlValue)
length(doc)
doc[1]

# 전처리 수행
# 한글과 space만 남기고 다른 모든 글자를 지운다
hdoc <- gsub('[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣 ]','',doc)
hdoc[1]

# DTM - 한글의 조사로 인해 잘 되지 않음
corpus <- Corpus(VectorSource(hdoc))
inspect(corpus)
dtm <- DocumentTermMatrix(corpus)
inspect(dtm)

# 한글 처리
library(KoNLP)
useSejongDic()
nouns <- extractNoun(hdoc)
noun_vec <- unlist(nouns)
noun_freq <- table(unlist(nouns))
noun_freq[1:10]
v <- sort(noun_freq, decreasing=T)
v100 <- v[1:100]
wordcloud2(v100)

noun_vec <- unlist(nouns)
##############################
# 한글 불용어 처리 (반복해서 top_words에 단어 추가하며 진행)
##############################

stop_words <- c('한','등','수','적','년','이','것')
l <- list() # 빈리스트 생성
for (word in unlist(nouns)) {
    if (!word %in% stop_words){
        l <- append(1, word)
    }
}

noun_freq <- table(unlist(1))
v <- sort(noun_freq, decreasing=T)
v100 <- v[1:100]
wordcloud2(v100)
