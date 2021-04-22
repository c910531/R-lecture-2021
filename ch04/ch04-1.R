# 파일 읽기
getwd()
students <- read.table('data/students1.txt', header=T) # read.table 일반 텍스트파일 읽을때
students
str(students)

students <- read.csv('data/students.csv') # csv는 header 설정 안해도댐
students

# 파일 쓰기 encoding 신경쓸 것
write.table(students, file='data/output.txt', fileEncoding='utf-8')
write.csv(students, file='data/output.csv', fileEncoding = 'utf-8')

# row.names=F option 설정, 행 인덱스 번호 표기 X
write.table(students, file='data/output.txt', fileEncoding='utf-8', row.names=F)
write.csv(students, file='data/output.csv', fileEncoding = 'utf-8', row.names=F)

# quote=F option "" 제거
write.table(students, file='data/output.txt', fileEncoding='utf-8', row.names=F, quote=F)
write.csv(students, file='data/output.csv', fileEncoding = 'utf-8', row.names=F, quote=F)

# 제대로 읽는지 확인
students <- read.table('data/output.txt', header=T, fill=T, fileEncoding = 'utf-8') 
students <- read.csv('data/output.csv', fileEncoding = 'utf-8')
students

str(students)
# 읽을때 stringasfactors=F 설정시 범주형으로 읽지않는다
students <- read.csv('data/output.csv', fileEncoding = 'utf-8', stringsAsFactors = F)
students
