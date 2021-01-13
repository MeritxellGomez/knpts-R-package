horizon <- function(datavar, h){

  n <- length(datavar)

  data_h <- datavar[(n-h+1):n]

  return(data_h)

}
