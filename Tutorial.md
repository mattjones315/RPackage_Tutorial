# Introducing R packages

### Why consider creating an R package? 

R is a high-level langauge, popular for running statistical analyses and short data-processing scripts. 

While most users use R with one-off scripts, there are several reasons for creating an R package, including:

1. It is easier to dissemminate your code (for example, if you were publishing your code along with your paper - e.g. https://github.com/chris-mcginnis-ucsf/MULTI-seq).
2. It may be easier for a user to collate standard analyses into functions in a common interface. (e.g. https://github.com/YosefLab/VISION)
3. It is easier to version-control a pakcage than individual scripts. 

### Preliminaries

Before we get started, you'll want to make sure you have the following pieces of software installed:

1. R: https://www.r-project.org/ 
    - The latest R version is 3.6.1 (as of 2019-10-16), though if you have an earlier version that should be fine. 
2. Rstudio: https://rstudio.com/
   - This is just a nice development environment.
3. The R package `devtools`, which can be done from within R: `install.packages('devtools')`. This is an extremely useful package for everything R-development.
4. The R package `roxygen2` which you can install from github as so: `devtools::install_github('klutometis/roxygen')`. Roxygen will help you generate documentation. 

# The Anatomy of an R Package

R packages range in complexity, but standard packages will have the following items:

1. DESCRIPTION (**required**): this stores package metadata, including its name, version, authors, license, and required or suggested packages.
2. NAMESPACE (**required**): a text file storing information pertaining to which functions you'd like to import from external packages, or export from your own package for users.
3. R/ (**required**): a folder that will store *all* source code for your package.
4. man/ (**required**)*: a folder storing all code documentation (refer to the section below entitled "Creating Documentation")
5. LICENSE (*optional*): a text file storing your license information. 
6. vignettes/ (*optional*): a folder storing R vignettes (i.e. tutorials). These are kind of like static jupyter notebooks that users can follow.
7. data/ (*optional*): a folder that stores any **required** package data. 
8. tests/ (*optional*): a folder storing testing scripts. 

### Instantiating an R package

There are a couple of ways to create R packages. Of course you can do things manually, but it is more straightforward to use `devtools`: 

```R
require(devtools)
require(roxygen2)
package.skeleton('BaseballStats')
```

After doing this, you will now have a text files called DESCRIPTION and NAMESPACE and two folders: R/ and man/. Though it's not something you'll want to carry with you to publication, there is also a help doc called `Read-and-delete-me` which reminds you where to put specific files. 

**Alternatives to `package.skeleton`**: You can also create R packages using `devtools::create` or by using R studio by following the steps under `File > New Project`. 

### Add your functions or R scripts to R

The R directory will store all your R code. If you have code already you're trying to package up you can move this over to the R directory. Else, you can begin writing code. For example, we'll add a file called `statistics.R` and add a single function for now:

```R
compute_average <- function(num_hits, num_at_bats) {

    if (num_at_bats < 1) {
        stop("You need at least one at bat for a batting average!")
    }

    return(num_hits / num_at_bats)
}
```
### Creating Documentation

Creating documentation in R with Roxygen is extremely easy. Roxygen will take your comments beginning with a `#'` character before every function and automatically generate documention. For example, using our function from before we can add the following documentation:

```R
#' A function for computing a batter's average.
#' 
#' This function takes in the number of at-bats and number of hits and will return an average.
#' @param num_hits Number of hits
#' @param num_at_bats Number of at bats
#' @exporrt
#' @examples
#' compute_average(10, 50)
compute_average <- function(num_hits, num_at_bats) {

    if (num_at_bats < 1) {
        stop("You need at least one at bat for a batting average!")
    }

    return(num_hits / num_at_bats)
}
```

Using the function `document` will populate the `man/` directory with your documentation. After running this function, you should notice two new `.Rd` files in your `man/` directory: `BaseballStats-package.Rd` and `compute_average.Rd`. 

# Object Oriented Programming In R

R supports three different object oriented programming paradigms: S3, S4, and R5. Here we'll focus on S4 classes which are extremely flexible and similar to other object-oriented systems. 


# Topics


## Object Oriented Programming in R
### Hybrid class types (using OR)

## Rcpp

## Shiny apps

## CRAN, Bioconductor, and publishing your code

## Devtools

