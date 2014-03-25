lcm <- function(args){
   stopifnot(is.list(args), is.character(args[[1]]))
   
   .Call('lcm', c("", args))
}
