cvknpts <- function(ts, h, n, kmax, dist, repeats, pond, metric){

  slices <- caret::createTimeSlices(y = ts, initialWindow = length(ts)/10, horizon = n, fixedWindow = FALSE)
  #la salida de esto son dos elementos $train y $test. En cada uno hay todas las posibles slices. Habría que coger al azar X de esas slices

  set.seed(123)
  sampleslices <- sample(length(slices$train), repeats)

  errors <- data.frame(matrix(NA, nrow = repeats, ncol = kmax))
  colnames(errors) <- paste('k =', 1:kmax)

  #funcion que pruebe los valores de k y escoja la mejor
  for (i in 1:repeats){

    trainperiods <- ts[slices$train[[sampleslices[i]]]]
    testperiods <- ts[slices$test[[sampleslices[i]]]]

    horizon <- horizon(trainperiods, h)

    distances <- distance_knn(trainperiods, horizon, n, dist)

    #y coger las k mas pequeñas con sus n siguientes valores
    for (j in 1:kmax){

      kneighbors <- distances[1:j,]

      #con cada k calculo los errores y los guardo en error de la fecha i con j vecinos

      name_iteration <- paste0('k', j, 'd', i)

      predictions <- predictknn_mimo(ts, kneighbors = kneighbors, n, pond)

      if(metric == 'rmse'){
        errors[i,j] <- ModelMetrics::rmse(predictions, testperiods)
      }

    }


  }

  errors_df <- apply(errors, 2, mean)

  kopt <- as.numeric(stringr::str_extract(names(which(errors_df == min(errors_df))), '[0-9]{1}'))

  return(kopt)


}
