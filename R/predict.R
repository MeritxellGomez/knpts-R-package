predictknn <- function(ts, kneighbors, n, pond){

  #coger el segundo indice de kneighbors y copiar los npred siguientes
  nearest.neighbors <- kneighbors[['final.value']]

  k<-nrow(kneighbors)

  m <- matrix(, nrow = k, ncol = n)

  for (i in 1:k){

    m[i,] <- ts[(nearest.neighbors[i]+1) : (nearest.neighbors[i]+n)]

  }

  #hacer la media por indice

  if(kneighbors[['distances']]==0){pond==FALSE}

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
