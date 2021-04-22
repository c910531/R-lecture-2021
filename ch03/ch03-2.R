# 벡터(Vector, 1차원 데이터)
s <- c(1,2,3,4,5,6)
s2 <- c(1:6)  # 시작:끝
s3 <- c(6:1)
s4 <- 1:5
c(1:3, c(4:6))
c(1:30)
seq(1, 100, by=2)  # from, to, increment 이 순서지만 생략 가능, by는 반드시 표기
seq(from=100, to=1, by=-3)
seq(0, 1, by=0.1)
seq(0, 1, length.out=11) # 0부터 1까지 11개의 표기
seq(1, 50, by=3)

rep(c(1:3), times=2) # 1 2 3 1 2 3 두번 반복
rep(c(1:3), each=2) # 1 1 2 2 3 3 두번 반복

# 인덱싱
x <- seq(2,10,by=2)
x[1] # x의 첫번째 값 (R프로그램 제외 0부터 시작)
x[-1] # x의 첫번째 값을 제외한 나머지 표기
x[-3] # x의 세번째 값을 제외한 나머지 표기

# slicing (R은 1:x x값까지 표기->이하(포함)로 처리, 이외 프로그램은 제외->미만으로 처리)
x[1:3]
x[c(1,3,5)] # x의 원하는 순서의 값을 표기
x[-c(2,4)] # x의 원하는 순서의 값을 제외하고 표기

# 연산
x <- c(1:4)
y <- c(5:8)
z <- c(3,4)
w <- c(5:7)

x + 2 # 3 4 5 6
x + y # 6 8 10 12
x + z # 4 6 6 8
x + w # 6 8 10 9 (배수관계 경고메세지)

length(w) # w의 개수
x > 2
x >= 2
all(x>2) # 전체값이 2가 넘는가 AND
any(x>2) # 값 중 2를 넘는 값이 있는가 OR

# fancy indexing
y[x>2]

# vector값의 head, tail
x <- 1:10
head(x) # head, tail default값은 6
head(x, 3)
tail(x)
tail(x, 3)

# 집합 연산
x <- 1:3
y <- 3:5
z <- c(3,1,2)

union(x, y) # 합집합, union은 집합시 중복 허용 X
intersect(x, y) # 교집합, 중복값만 표기
setdiff(x, y) # 차집합 1, 2 만 표기
setdiff(y, x) # 차집합 4, 5 만 표기
setequal(x, y) # x, y값 일치한가 , F
setequal(x, z) # T

