#' Make predictions using KNPTS (K-Nearest Patterns in Time Series)
#'
#' @param ts univariate time series
#' @param h number of points in the horizon series
#' @param n number of points to be predicted
#' @param kmax maximum number of neighbours to be tested in the cross validation
#' @param dist name of the distance function
#' @param repeats number of partitions in the cross validation
#' @param pond logical if the average should be ponderated or not
#' @param strategy mimo or recursive strategy to forecast
#' @param metric error metric to calculate and compare the accuracy in cross validation
#'
#' @return predictions
#' @export
#'
#' @examples
predictKNPTS <- function(ts, h = 5, n = 3, kmax = 10, dist = 'Euclidean', repeats = 3, pond = FALSE, strategy = 'mimo', metric = 'rmse'){

  # get last h values of the time series
  horizon <- horizon(ts, h)

  # choose the best k value doing time series cross validation
  kopt <- cvknpts(ts = ts, h = h, n = n, kmax = kmax, dist = dist, repeats = repeats, pond = pond, metric = metric)

  # choose the strategy to get estimations of the future values
  if(strategy == 'mimo'){

    # MultiInput MultiOutput Strategy
    distances <- distance_knn(ts, horizon, n, dist)
    kneighbors <- distances[1:kopt,]

    predictions <- predictknn_mimo(ts, kneighbors = kneighbors, n, pond)

  }else if(strategy == 'recursive'){

    # Recursive Strategy (each estimated point is used as input in the next iteration)
    predictions <- predictknn_recursive(ts, horizon = horizon, h = h, n = n, pond = pond, dist = dist, kopt = kopt)

  }else{
    stop('incorrect name for strategy argument')
  }

  return(predictions)

}
