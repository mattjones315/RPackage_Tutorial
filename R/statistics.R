
#' A function for computing a batter's average.
#' 
#' This function takes in the number of at-bats and number of hits and will return an average.
#' @param num_hits Number of hits
#' @param num_at_bats Number of at bats
#' @export
#' @examples
#' compute_average(10, 50)
compute_average <- function(num_hits, num_at_bats) {

    if (num_at_bats < 1) {
        stop("You need at least one at bat for a batting average!")
    }

    return(num_hits / num_at_bats)
}

