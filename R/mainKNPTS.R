#' Make predictions using KNPTS (K-Nearest Patterns in Time Series)
#'
#' @param ts
#' @param h
#' @param n
#'
#' @return model
#' @export
#'
#' @examples
predictKNPTS <- function(ts, h = 5, n = 3, kmax = 10, dist = 'Euclidean', pond = FALSE){

  #coger los h ultimos valores de la serie
  horizon <- horizon(ts, h)

  #CV para escoger la mejor k. De momento pongo k=3 hasta que esté hecha la funcion de crossvalidation
  kopt <- 3

  #calcular las distancias
  distances <- distance_knn(ts, horizon, n, dist)

  #y coger las k mas pequeñas con sus n siguientes valores
  kneighbors <- distances[1:kopt,]

  #combinar los n siguientes valores y meter en un vector de predicciones
  predictions <- predictknn(ts, kneighbors = kneighbors, n, pond)

  return(predictions)

}
