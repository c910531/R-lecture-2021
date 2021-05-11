# 다음 웹 검색
library(httr)
library(jsonlite)
library(tm)
library(text2vec)
library(caret)
kakao_api_key <- readLines('OpenAPI/kakao_api_key.txt')
kakao_api_key

base_url <- 'https://dapi.kakao.com/v2/search/web'
keyword <- URLencode(iconv('데이터정제', to = 'UTF-8'))
keyword
query <- paste0('target=title&query=', keyword)
url <- paste(base_url, query, sep='?')
url

auth_key <- paste('KakaoAK', kakao_api_key)
auth_key
res <- GET(url, add_headers('Authorization'=auth_key))
res
result <- fromJSON(as.character(res))
class(result)         # 결과는 리스트로 도출
df <- as.data.frame(result)
View(df)
doc <- gsub('<b>',' ',df)
View(doc)
# 결과가 리스트이기 때문에 매트릭스로 변환 후 저장
write.csv(df, 'OpenAPI/web.csv', fileEncoding = 'UTF-8')
write.csv(as.matrix(df),'OpenAPI/web.csv',
          fileEncoding = 'UTF-8', row.names=F)

# 파일 내용 중 ',' 포함되어 열 개수 오류 / sep를 \t로 변경
write.table(as.matrix(df),'OpenAPI/web.tsv',
            fileEncoding = 'UTF-8', row.names=F, sep='\t')
df2 <- read.csv('OpenAPI/web.tsv', fileEncoding = 'UTF-8', sep='\t')
View(df2)
