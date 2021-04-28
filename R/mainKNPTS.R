#' Make predictions using KNPTS (K-Nearest Patterns in Time Series)
#'
#' @param ts univariate time series
#' @param h number of points in the horizon series
#' @param n
#'
#' @return model
#' @export
#'
#' @examples
predictKNPTS <- function(ts, h = 5, n = 3, kmax = 10, dist = 'Euclidean', pond = FALSE, strategy = 'mimo'){

  #coger los h ultimos valores de la serie
  horizon <- horizon(ts, h)

  #CV para escoger la mejor k. De momento pongo k=3 hasta que esté hecha la funcion de crossvalidation
  kopt <- 3

  if(strategy == 'mimo'){
    #calcular las distancias
    #y coger las k mas pequeñas con sus n siguientes valores
    distances <- distance_knn(ts, horizon, n, dist)
    kneighbors <- distances[1:kopt,]
    #combinar los n siguientes valores y meter en un vector de predicciones
    predictions <- predictknn_mimo(ts, kneighbors = kneighbors, n, pond)
  }else if(strategy == 'recursive'){
    predictions <- predictknn_recursive(ts, horizon = horizon, h = h, n = n, pond = pond, dist = dist, kopt = kopt)
  }else{
    stop('incorrect name for strategy argument')
  }

  return(predictions)

}
