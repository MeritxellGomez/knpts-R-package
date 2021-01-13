d_euclidean <- function(vec_x, vec_y){

  d <- sqrt(sum((vec_x - vec_y)^2))

  return(d)

}

d_dtw <- function(vec_x, vec_y){

  library(dtw)

  alignment<-dtw(vec_x, vec_y)

  return(alignment$distance)

}

distance_knn <- function(ts, horizon, n, dist){

  n2 <- length(ts)
  h <- length(horizon)
  distances <- c()
  i_f <- n2-n-h+1
  df <- data.frame(initial.value = c(1:i_f), final.value = c(h:(i_f+h-1)), distances = rep(0,i_f))

  for (i in 1:i_f){

    int <- ts[i:(i+h-1)]

    #calcula la distancia
    if(dist == "DTW"){
      d_aux <- d_dtw(int, horizon)
    }else if(dist == "Euclidean"){
      d_aux <- d_euclidean(int, horizon)
    }else{
      d_aux <- "Distance can not be calculated"
    }

    distances <- c(distances, d_aux)

    #h <- h + 1

  }

  df[['distances']] <- distances

  library(dplyr)
  df <- df %>% arrange(distances)

  return(df)

}


