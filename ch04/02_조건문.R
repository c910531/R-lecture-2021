# 조건문
# 1. []에 행/열 조건 명시
test <- c(15, 20, 30, NA, 45)
test[test<40]                 # NA값 포함
test[test<40 & !is.na(test)]  # NA값 제거
test[test%%3==0 & !is.na(test)] #3의 배수 (NA값제거)

df <- data.frame(name=c('길동','춘향','철수'),age=c(30,16,21),gender=factor(c('M','F','M')))
df
# 여성인 행 추출
df[df$gender=='F',]
# 25세 이상 남성 행 추출
df[df$age>=25 & df$gender=='M',]

# 2. if문
x <- 5
if (x%%2 == 0) {
    print('짝수')  # indentation 주의할 것
} else{
    print('홀수')
}

x <- 0
if (x>0) {
    print('양수')
} else if (x<0) {
    print('음수')
} else {
    print('zero')
}

# 3. ifelse 문
score <- 50
pass <- ifelse(score>=60, '합격', '불합격')
pass

# students.csv 파일 읽어서 학점 부여
students <- read.csv('data/students.csv')
options(digits=4) # 소수점 설정
apply(students[,2:4], 1, mean)
students['평균'] = c(apply(students[,2:4], 1, mean))
students
students['학점'] = ifelse(students$평균>=90,'A',
                        ifelse(students$평균>=80,'B',
                        ifelse(students$평균>=70,'C',
                               ifelse(students$평균>=60,'D','학사경고'))))
students                        
