### 01. 1부터 100까지의 수 중에서 3의 배수이면서 4의 배수는 아닌 수의 합을 구하라
sum <- 0
for (num in 1:100) {
    if (num %% 3 == 0 &
        num %% 4 != 0) {
        sum <- sum + num
    }
}
print(sum)

### 02. x와 n을 입력하면 1부터 n까지의 수 중에서 x의 배수 합을 구해주는 사용자 정의 함수를 만들어라
range_sum <- function(x,n) {
    sum <- 0
    for (i in 1:n) {
        if(i %% x==0){
            sum <- sum + i
        }
    }
    return(sum)
}
range_sum(2,6)

### 03. install.packages와 library 명령어를 이용하여 hflights 데이터를 활용하라.
###     hflights 데이터에는 총 몇개의 NA가 존재하는가?
##install.packages("hflights")
library(hflights)
sum(is.na(hflights))
### 04. hflights 데이터에서 비행시간이 가장 긴 데이터는 몇 시간 몇 분인가?
max(hflights$AirTime, na.rm = T) %/% 60
max(hflights$AirTime, na.rm = T) %% 60
### 05. hflights 데이터에서 비행거리가 가장 긴 데이터는 몇 마일인가?
max(hflights$Distance)
### 06. hflights 데이터에서 비행편이 취소된 건수는 몇 건인가?
sum(hflights$Cancelled)
