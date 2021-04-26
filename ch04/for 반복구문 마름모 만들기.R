{
    n <- 10
    for (i in 1:n) {
        star <- ''
        for (j in 1:(n-i+1)){
            star <- paste0(star, ' ')
        }
        for (k in 1:(2*i-1)) {
            star <- paste0(star, '#')
        }
        print(star)
    }
    for (i in (n-1):1) {
        star <- ''
        for (j in 1:(n-i+1)){
            star <- paste0(star, ' ')
        }
        for (k in 1:(2*i-1)) {
            star <- paste0(star, '#')
        }
        print(star)
    }
}