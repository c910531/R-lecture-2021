# 문자열 처리
# R에서 String(문자열) 처리하기
library(stringr)

# 1. character 형으로 변환
example <- 1
typeof(example)  # double = 숫자
example <- as.character(example)
str(example)

## 입력을 받는 경우
input <- readline('Prompt> ')
input
i <- as.numeric(input)
3 * i

# 2. String 이어 붙이기
paste('A', 'quick', 'brown', 'fox') # 결과값  "A quick brown fox" 출력
paste0('A', 'quick', 'brown', 'fox') # 결과값  "Aquickbrownfox" 출력
paste('A', 'quick', 'brown', 'fox', sep='-') # 결과값  "A-quick-brown-fox" 출력
s <- paste('A', 'quick', 'brown', 'fox', sep='-')
sample <- c('A', 'quick', 'brown', 'fox')
paste(sample)
paste(sample, collapse = '-') # 결과값 "A-quick-brown-fox" 출력
str_c(sample, '1', sep='_') # 결과값 "A_1"     "quick_1" "brown_1" "fox_1" 출력  
str_c(sample, '1', sep='_', collapse = '@@') # 결과값 "A_1@@quick_1@@brown_1@@fox_1" 출력

# 3. Character 개수 카운트
x <- 'Hello'
nchar(x)
h <- '안녕하세여'
nchar(h)
str_length(h)

# 4. 소문자 변환
tolower(x)

# 5. 대문자 변환
toupper(x)

# 6. 2개의 character vector를 중복되는 항목 없이 합하기 (합집합)
vector_1 <- c("hello", "world", "r", "program")
vector_2 <- c("hi", "world", "r", "coding")
union(vector_1, vector_2)  # 결과값 "hello"   "world"   "r"       "program" "hi"      "coding"  출력

# 7. 2개의 character vector에서 공통 항목 추출 (교집합)
intersect(vector_1, vector_2) #"world" "r"

# 8. 2개의 character vector에서 공통되지 않는 항목 추출(차집합)
setdiff(vector_1, vector_2) # "hello"   "program"

# 9. 2개의 character vector 동일 여부 확인 (순서에 관계없이)
vector_3 <- c("r", "hello", "program", "world")
setequal(vector_1,vector_2) # FALSE
setequal(vector_3,vector_1) # TRUE

# 10. 공백 없애기
str_1 <- c("   Hello World!   ", "      Hi R!     ")
str_trim(str_1, side='left')
str_trim(str_1, side='right')
str_trim(str_1, side='both')

# 11. String 반복
str_dup(x, 3) #"HelloHelloHello"
rep(x, 3) #"Hello" "Hello" "Hello"

# 12. Substring(String의 일정 부분) 추출 
string_1 <- "Hello World"
substr(string_1, 7, 9) # "Wor"
substring(string_1, 7, 9) # "Wor"
str_sub(string_1, 7, 9) # "Wor"
substr(string_1, 7) # error
substring(string_1, 7) # "World"
str_sub(string_1, 7) # "World"
str_sub(string_1, 7, -3)
string_1[7:9] # NA NA NA 오류

# 13. String 특정 위치 값 바꾸기
string_1 <- "Today is Monday"
substr(string_1, 10, 12) <- "Sun"
string_1
substring(string_1, 10, 12) <- "Thurs"
string_1 # 글자 초과시 제대로 출력 안됨 "Today is Thuday"

# 14. 특정 패턴(문자열)을 기준으로 String 자르기
strsplit(string_1, split=' ') # "Today"  "is"     "Thuday"
str_split(string_1, pattern=' ') # "Today"  "is"     "Thuday"
str_split(string_1, pattern=' ', n=2)
str_split(string_1, pattern = ' ', simplify = TRUE)
s <- str_split(string_1, pattern=' ')
typeof(s)
s[[1]][1] # list의 1번 항목에 1번 분류를 꺼내오기

## 리스트를 벡터로 변환 : unlist()
unlist(s)
paste(unlist(s), collapse = ' ')

# 15. 특정 패턴(문자열) 찾기 (기본 function)
vec_1 <- c("Xman", "Superman", "Joker")
grep("man", vec_1) # 1 2"
grepl("man", vec_1) # TRUE  TRUE FALSE
regexpr("man", vec_1)
gregexpr("man", vec_1)

# 16. 특정 패턴(문자열) 찾기 (stringr package function) 
fruit <- c("apple", "banana", "cherry")
str_count(fruit, "a")
str_detect(fruit, "a")
str_locate(fruit, "a")
str_locate_all(fruit, "a")

people <- c("rorori", "emilia", "youna")
str_extract(people, "o(\\D)")  # \\D는 non-digit character를 의미

# 17. 특정 패턴(문자열) 찾아서 다른 패턴(문자열)으로 바꾸기
fruits <- c("one apple", "two pears", "three bananas")
sub("a", "A", fruits)
gsub("[aeiou]", "-", fruits)
str_replace(fruits, "[aeiou]", "-")
str_replace_all(fruits, "[aeiou]", "-")
