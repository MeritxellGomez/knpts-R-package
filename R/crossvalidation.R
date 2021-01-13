cvknpts <- function(ts, h, n, kmax){

  #ESCOGER X FECHAS (5 POR DEFECTO) Y PREDECIR PARA K DESDE 1 A KMAX

  slices <- caret::createTimeSlices(y = ts, initialWindow = length(ts)/10, horizon = n, fixedWindow = FALSE)
  #la salida de esto son dos elementos $train y $test. En cada uno hay todas las posibles slices. Habría que coger al azar X de esas slices

  #sampleslices <- meter X numeros random desde 1 hasta el numero de slices que se hayan creado

  slices$train[sampleslices]
  slices$test[sampleslices]

  #funcion que pruebe los valores de k y escoja la mejor

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
