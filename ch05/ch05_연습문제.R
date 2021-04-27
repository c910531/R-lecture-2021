###연습문제
### 1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. 
### displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의
### hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.

library(ggplot2)
library(dplyr)

mpg2<-mpg
    displ4 <- mpg2 %>%
        filter(displ<=4)
    displ5 <- mpg2 %>%
        filter(displ>=5)
    mean(displ4$hwy)
    mean(displ5$hwy)
### mutate를 활용해 한번에 표기
mpg %>%
    mutate(displ45=ifelse(displ<=4,'DISPL4','DISPL5')) %>%
    group_by(displ45) %>%
    summarise(avg_hwy=mean(hwy)) %>%
    arrange(desc(avg_hwy))

### 2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. 
### "audi"와 "toyota" 중 어느 manufacturer(자동차 제조 회사)의 cty(도시 연비)가 
### 평균적으로 더 높은지 알아보세요.

mpg %>%
    filter(manufacturer %in% c('audi','toyota')) %>%
    group_by(manufacturer) %>%
    summarize(avg_cty=mean(cty)) %>%
    arrange(desc(avg_cty))

### 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다.
### 이 회사들의 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요.

mpg %>%
    filter(manufacturer %in% c('chevrolet','ford','honda')) %>%
    group_by(manufacturer) %>%
    summarize(avg_hwy=mean(hwy)) %>%
    arrange(desc(avg_hwy))

### 4. mpg 데이터는 11개 변수로 구성되어 있습니다. 이 중 일부만 추출해서 분석에 활용하려고 합니다.
### mpg 데이터에서 class(자동차 종류), cty(도시 연비) 변수를 추출해 새로운 데이터를 만드세요.
### 새로 만든 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인하세요.

mpg %>%
    group_by(class) %>%
    summarize(cty) %>%
    arrange(desc(cty)) %>%
    head(5)

### 5. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다.
### 앞에서 추출한 데이터를 이용해서 class(자동차 종류)가 "suv"인 자동차와 "compact"인 자동차 중 어떤 자동차의 cty(도시 연비)가 더 높은지 알아보세요.

mpg %>%
    filter(class %in% c('suv', 'compact')) %>%
    group_by(class) %>%
    summarize(avg_cty=mean(cty))

### 6. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다.
### "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.    
    
mpg %>%
    filter(manufacturer %in% c('audi')) %>%
    group_by(model) %>%
    select(model,hwy) %>%
    arrange(desc(hwy)) %>%
    head(5)

### 답안
mpg %>%
    filter(manufacturer=='audi') %>%
    arrange(desc(hwy)) %>%

### 7.mpg 데이터는 연비를 나타내는 변수가 hwy(고속도로 연비), cty(도시 연비) 두 종류로 분리되어 있습니다.
### 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 분석하려고 합니다.
#### 1) mpg 데이터 복사본을 만들고, cty와 hwy를 더한 '합산 연비 변수'를 추가하세요.
#### 2) 앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가하세요.
#### 3) '평균 연비 변수'가 가장 높은 자동차 3종의 데이터를 출력하세요.
#### 4) 1)~3)번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력하세요. 
#### 데이터는 복사본 대신 mpg 원본을 이용하세요.

mpg$total <- (mpg$cty + mpg$hwy)
mpg$avg <- (mpg$total / 2)
head(mpg)
mpg %>%
    group_by(manufacturer) %>%
    arrange(desc(avg)) %>%
    select(manufacturer,avg) %>%
    head(3)

mpg %>%
    mutate(total=mpg$cty + mpg$hwy, avg=(mpg$total)/2) %>%
    group_by(manufacturer) %>%  # 삭제시 나머지 구분항목 표기
    arrange(desc(avg)) %>%
    select(manufacturer,avg) %>% # 삭제시 나머지 구분항목 표기
    head(3)

### 8. mpg 데이터의 class는 "suv", "compact" 등 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다.
### 어떤 차종의 연비가 높은지 비교해보려고 합니다. class별 cty 평균을 구해보세요.

mpg %>%
    group_by(class) %>%
    summarize(avg_cty=mean(cty))
    


### 9. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다.
### 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty 평균이 높은 순으로 정렬해 출력하세요.

mpg %>%
    group_by(class) %>%
    summarize(avg_cty=mean(cty))%>%
    arrange(desc(avg_cty))

### 10. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 합니다.
### hwy 평균이 가장 높은 회사 세 곳을 출력하세요.

mpg %>%
    group_by(manufacturer) %>%
    summarize(avg_hwy=mean(hwy)) %>%
    arrange(desc(avg_hwy)) %>%
    head(3)

### 11. 어떤 회사에서 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 합니다.
### 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

mpg %>%
    filter(class %in% c('compact')) %>%
    group_by(manufacturer) %>%
    summarize(count=n()) %>%
    arrange(desc(count))
              
### 정답

mpg %>%
    filter(class=='compact') %>%
    group_by(manufacturer) %>%
    summarise(num_kind=n()) %>%  # n() - 행의 갯수
    arrange(desc(num_kind))
