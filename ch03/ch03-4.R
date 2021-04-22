# 데이터 프레임
name <- c('철수', '춘향', '길동')
age <- c(22, 20, 25)
gender <- factor(c('M', 'F', 'M'))
blood_type <- factor(c('A', 'O', 'B'))

patients <- data.frame(name, age, gender, blood_type)
patients

patients$name
typeof(patients$name)
patients[1,] # 첫번째 행 모두 표기
patients[,2] # 두번째 열(patients$age) 모두 표기
patients[2,3]
patients$gender[3]
patients[patients$name=='철수',] # patients[1,], filter 기능
patients[patients$name=='철수',c('age','gender')] # select 기능

# 데이터프레임의 속성명을 변수명으로 사용(attach), detach로 닫아줘야됨
attach(patients)
name
blood_type
age
gender
detach(patients)

head(cars)
attach(cars)
speed
dist
detach(cars)
speed
mean(cars$speed)
with(cars, mean(speed))

# subset
subset(cars, speed>20)
cars[cars$speed>20,]
subset(cars, speed>20, select=c(dist)) # 속도 20 초과 중 거리만
subset(cars, speed>20, select=-c(dist)) # 속도 20 초과 중 거리제외하고 표기

# 결측값(NA) 처리 (결측치 많을때: 통째로 날린다 결측치 적을때: 결측치만 제거, 대표값(평균,중앙,최빈값)으로 대체도 가능)
head(airquality)
str(airquality)
sum(airquality$Ozone)
head(na.omit(airquality))

# 병합(merge)
patients
patients1 <- data.frame(name,age,gender)
patients2 <- data.frame(name,blood_type)
merge(patients1,patients2, by='name')

# 데이터프레임에 행 추가
length(patients1$name)
patients1[length(patients1)+1,] <- c('몽룡',19,'M')
patients1
patients2[length(patients2$name)+1,] <- c('영희','A')
patients2

# 데이터프레임에 열 추가
patients1['birth_year'] <- c(1500,1550,1600,1800)
patients1

# merge
# inner join
merge(patients1, patients2)
# left outer join
merge(patients1, patients2, all.x=T)
# right outer join
merge(patients1, patients2, all.y=T)
# (Full)outer join
merge(patients1, patients2, all.x=T, all.y=T)
