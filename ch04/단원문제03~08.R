#03 airquality 데이터는 어느 도시 공기 질을 나타내는 데이터인가?
?airquality
## new york

#04 airquality 데이터의 온도 단위는 무엇인가?
?airquality
## [,4]	Temp	numeric	Temperature (degrees F)

#05 airquality 데이터에서 바람이 가장 세게 분 날은 언제인가?
airquality[airquality$Wind == max(airquality$Wind),]
## 1973 06 17

#06 airquality 데이터에서 총 몇개의 NA가 표함되어있는가?
table(is.na(airquality))
## 44개

#07 quakes 데이터는 어느 섬의 지진을 관측한 데이터인가?
?quakes
## Fiji

#08 quakes에 기록된 가장 큰 지진의 규모는 얼마인가?
quakes
max(quakes$mag)