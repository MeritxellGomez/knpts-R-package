predictknn_mimo <- function(ts, kneighbors, n, pond){

  #coger el segundo indice de kneighbors y copiar los npred siguientes
  nearest.neighbors <- kneighbors[['final.value']]

  k<-nrow(kneighbors)

  m <- matrix(, nrow = k, ncol = n)

  for (i in 1:k){

    m[i,] <- ts[(nearest.neighbors[i]+1) : (nearest.neighbors[i]+n)]

  }

  #hacer la media por indice

  if(0 %in% kneighbors[['distances']]){pond==FALSE}

  if(pond){
    w <- (1/(kneighbors[['distances']])^2)

    nw <- w/(sum(w))

    pred <- (nw %*% m)

  }else{
    pred <- apply(m, 2, mean)
  }
  #devolver vector de n longitud

  return(pred)

}

predictknn_recursive <- function(ts, horizon, h,  n, dist, kopt, pond){

  pred <- c()

  for(i in 1:n){

    distances <- distance_knn(ts, horizon, n, dist)
    kneighbors <- distances[1:kopt,]

    pos_combination <- kneighbors$final.value + 1
    values_combination <- ts[pos_combination]


    if(kneighbors[['distances']]==0){pond==FALSE} #avoid dividing by 0

    if(pond){
      w <- (1/(kneighbors[['distances']])^2)

      nw <- w/(sum(w))

      aux_pred <- nw * m

    }else{
      aux_pred <- mean(values_combination)
    }

    pred <- c(pred, aux_pred)

    ts <- c(ts, aux_pred)

    horizon <- horizon(ts, h)

  }

  return(pred)

}
