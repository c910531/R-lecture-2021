# Wikipedia "data science"
library(RCurl)
library(XML)
library(stringr)

html <- readLines('https://en.wikipedia.org/wiki/Data_science')
html <- htmlParse(html, asText = T)
doc <- xpathSApply(html, '//p', xmlValue)
length(doc)
doc[1]
doc[2]
doc[3]
corpus <- doc[2:3]

# 모두 소문자로 변경
corpus <- tolower(corpus)
corpus

# 숫자 제거
corpus <- gsub('\\d','',corpus)
corpus[1]

# 구둣점 제거
corpus <- gsub('[[:punct:]]','',corpus)
corpus

# 끝에 있는 공백 제거
corpus <- gsub('\n', ' ', corpus)
corpus <- str_trim(corpus, side='right')
corpus

# 불용어 제거
stopwords <- c('a', 'the', 'and', 'in', 'of', 'to', 'but')
words <- strsplit(corpus, split = " ") # 결과가 리스트 형태로
unlist(words) # 여러개 리스트(엘리먼트)를 하나(벡터)로 취합

l <- list() # 빈 리스트 생성
for (word in unlist (words)) {
    if (!word %in% stopwords) {
        l <- append(l, word)
    }
}
corpus <- paste(l,collapse = ' ')
corpus

`%notin%` <- Negate(`%in%`)     # ``, back quote
l <- list() # 빈 리스트 생성
for (word in unlist (words)) {
    if (word %notin% stopwords) {
        l <- append(l, word)
    }
}
corpus <- paste(l,collapse = ' ')
corpus
