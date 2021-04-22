getwd()

# 변수(variable)
x <- 1
y <- 2
z <- x+y
z

# swapping
temp <- x
x <- y
y <- temp

# 변수의 타입
typeof(x)
a <- 'string'
typeof(a)
b <- "double quote"
typeof(b)
c <- '한글'
typeof(c)

# 실수(numeric)
x <- 5
y <- 2
x / y
# 복소수(complex)
xi <- 1 + 2i
yi <- 1 - 2i
xi + yi
xi * yi

# 범주형(category)
blood_type = factor(c('A','B','O','AB'))
blood_type

# 논리형(boolean)
TRUE
FALSE
T
F

xinf = Inf
yinf = -Inf
xinf / yinf

# 데이터형 확인 함수
class(x)     # R 객체지향 관점
typeof(x)    # R 언어 자체관점
is.integer(x)
is.numeric(x)
is.complex(xi)
is.character(c)
is.na(xinf/yinf)

# 데이터형 변환 함수
is.integer(as.integer(x))
is.factor(as.factor(c))

# 산술연산자(+, -, *, /, ^, **, %%, %/%) 
5 ^ 2
4 ^ (1/2)
x %% y # 나머지값(modulo)
x %/% y # 몫값

# 비교연산자 (= > , = < 순서로 이상 이하 표기 ! = 순서로 != 표기)
x < y
x <= y
x >= y
x == y
x != y

# 논리 연산자 (!, |, &)
!T
!F
x | y   # OR
x & y   # AND
a <- c(F, F, T, T)
b <- c(F, T, F, T)
a | b   # element-wise OR
a || b  # 첫번째 엘리먼트의 논리합
a & b   # element-wise AND
a && b  # 첫번째 엘리먼트의 논리합
2^-3-5**1/2>2  # 2^(-3) - 5**(1/2) > 2 우선순위를 괄호로 구별할 것
