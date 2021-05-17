library(geojsonio)
library(leaflet)
library(stringr)
library(dplyr)

map <- geojson_read('c:/workspace/R/data/map_data/daejon.json', what='sp')
leaflet(map) %>% 
    setView(lng=127.39, lat=36.35, zoom=11) %>% 
    addProviderTiles('Stamen.TonerLite') %>% 
    addPolygons()
class(map)   # SpatialPolygonsDataFrame
slotNames(map)
map@data
data.frame(map)

cities <- read.csv('c:/workspace/R/data/trade/t_total.csv')

names(map@data)
names(cities)
colnames(cities)[2] <-"name"
names(cities)
# cities$name <- lapply(cities$place,
#                      function(x) substring(x, 1, str_length(x)-1))

map@data <- merge(map@data, cities, by='name', sort = F)

t_ave16 <- cities 
avg16 <- t_ave16 %>%
    filter(계약연도 == '2016') %>%
    group_by(name) %>%
    summarise(t_ave16 = mean(거래금액))

avg16

t_ave20 <- cities 
avg20 <- t_ave20 %>%
    filter(계약연도 == '2020') %>%
    group_by(name) %>%
    summarise(t_ave20 = mean(거래금액))

avg20

 
# diff1620 <- (avg20$t_ave20/avg16$t_ave16) * 100
# diff1620
# diff1620m <- matrix(diff1620)
diff1620 <- data.frame(name = c('대덕구', '동구', '서구', '유성구', '중구'), 
                        상승비율=(avg20$t_ave20/avg16$t_ave16)*100)
diff1620

ratio <- merge(map@data, diff1620, by='name', sort = F) %>%
            group_by(name,상승비율)
View(map@data)

# t_ave16 <- cities 
# avg16 <- t_ave16 %>%
#     filter(계약연도 == '2016') %>%
#     group_by(name) %>%
#     summarise(t_ave16 = mean(거래금액))
# 
# avg16
# 
# View(avg16)

pal <- colorNumeric('YlOrRd', NULL)
leaflet(map) %>% 
    setView(lng=127.39, lat=36.35, zoom=11) %>% 
    addProviderTiles('Stamen.TonerLite') %>% 
    addPolygons(
        fillColor = ~pal(as.numeric(diff1620$상승비율)),
        weight = 2,
        opacity = 1,
        color = 'white',
        dashArray = '3',
        fillOpacity = 0.7,
        label = ~name
    )   %>% 
    addLegend(pal=pal, values = ~diff1620, opacity = 0.7,
              title='평균값', position='bottomright')
