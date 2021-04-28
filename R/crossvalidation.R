cvknpts <- function(ts, h, n, kmax, dist){

  #ESCOGER X FECHAS (5 POR DEFECTO) Y PREDECIR PARA K DESDE 1 A KMAX

  slices <- caret::createTimeSlices(y = ts, initialWindow = length(ts)/10, horizon = n, fixedWindow = FALSE)
  #la salida de esto son dos elementos $train y $test. En cada uno hay todas las posibles slices. Habría que coger al azar X de esas slices

  sampleslices <- sample(length(slices$train), repetitions)

  #funcion que pruebe los valores de k y escoja la mejor
  for (i in sampleslices){

    trainperiods <- slices$train[i]

    horizon <- horizon(trainperiods, h)

    distances <- distance_knn(trainperiods, horizon, n, dist)

    #y coger las k mas pequeñas con sus n siguientes valores
    for (j in 1:kmax){

      kneighbors <- distances[1:j,]

    }

    #guardar para el test i el mejor valor j y el error obtenido

    #combinar los n siguientes valores y meter en un vector de predicciones
    predictions <- predictknn(ts, kneighbors = kneighbors, n, pond)

    testperiods <- slices$test[i]


  }


  #devolver data frame con las k, rmse, dtw, edr

  #o devolver la mejor k? bueno esto para un futuro próximo

}


# cvknn <- function(df.train, df.test, output_var_name, h, npred, kmax, pond){
#
#   dknn_complete <- distance_knn(df.train[[output_var_name]], h=h, npred=npred)
#
#   rmse <- vector(length = kmax)
#   dtw <- vector(length = kmax)
#   EDR <- vector(length = kmax)
#
#   for(k in 1:kmax){
#
#     dknn <- kneighbors(dknn_complete, k)
#     pred <- predict.knn(df.train[[output_var_name]], dknn, npred = npred, pond = pond)
#
#     dpred <- data.frame(df.test[1:npred,], pred=as.vector(pred))
#
#     rmse[k] <- ModelMetrics::rmse(dpred[[output_var_name]], dpred[['pred']])
#     dtw[k] <- d_dtw(dpred[[output_var_name]], dpred[['pred']])
#     #EDR[k] <- d_EDR(dpred[[output_var_name]], dpred[['pred']], eps = 20)
#   }
#
#   results<- data.frame(k=c(1:kmax), RMSE = rmse, DTW = dtw, EDR = EDR)
#
#   return(results)
#
# }
