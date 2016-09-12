## First function will make a matrix as demanded then the second function will 
## calculate the inverse and cach it. If the already created matrix didn't change
## then calling the second function will only retreve the already calculated and
## cached inverse to avoid wasting computation power, otherwise the matrix will 
## be calculated again.

## This function will creat a matrix with the supplied values and dimentions.

makeCacheMatrix <- function(x = matrix()) {
     inverse <- NULL
     set <- function(y) {
          x <<- y
          inverse <<- NULL
     }
     get <- function() x
     setinv <- function(solve) inverse <<- solve
     getinv <- function() inverse
     list(set = set, get = get,
          setinv = setinv,
          getinv = getinv)
}


## This function will calculate the inverse of the matrix created by the above
## function and cach it, if the matrix changed the new inverse will be recalculated
## otherwise the cached inversed will be returned and computation power won't be
## wasted.

cacheinv <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
     inverse <- x$getinv()
     if(!is.null(inverse)) {
          message("getting cached data")
          return(inverse)
     }
     data <- x$get()
     inverse <- solve(data, ...)
     x$setinv(inverse)
     #inverse
}
