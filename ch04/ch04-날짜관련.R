airquality
max_wind <- max(airquality$Wind)
wind.day <- airquality[airquality$Wind==max_wind, 5:6]
wind.day
date<-paste0('1973-',wind.day$Month,'-',wind.day$Day)
date # 문자열
date_type <- as.Date(date) # Date
date_type


# Date type으로 날짜 표기
days <- seq(as.Date('2021-04-01'), as.Date('2021-04-30'), by=1)
days
