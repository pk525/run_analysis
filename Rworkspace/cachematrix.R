
makeCacheMatrix <- function(x = matrix()) {
           #Return the matrix that was passed into the function
			m <- NULL  # matrix Inverse
			
		# assign a new matrix(y) & cache in parent environment
			set <- function (y){
					x <<- y
					m <<- NULL 
			}
		# return the earlier matrix passed
			get <- function() x  
		# return the inverse of the matrix
			set.inv <- function(solve) m <<- solve
			get.inv <- function() m
           # Return the four embedded functions in a list 
			list( set = set , get = get, 
				set.inv =set.inv ,
				get.inv =get.inv)
			
			
			
}



cacheSolve <- function(x, ...) {
	# retrieve the inverse matrix and compare with the matrix available in 
	#parent environment	
			m <- x$get.inv() 
			if(!is.null(m)) {
			
		message("getting cached inverted matrix")
			return(m)
			}
	# if fresh data calculate  inverse for the new matrix
			data <- x$get()
			m <- solve(data, ...)
			x$set.inv(m)
			m
        
}

