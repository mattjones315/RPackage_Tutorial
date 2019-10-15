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

You can make sure that this function is working by loading the package with `devtools` and tesing out your function:

```R
require(devtools)
load_all('.')

compute_average(10, 50)

```

### Creating Documentation

Creating documentation in R with Roxygen is extremely easy. Roxygen will take your comments beginning with a `#'` character before every function and automatically generate documention. For example, using our function from before we can add the following documentation:

```R
#' A function for computing a batter's average.
#' 
#' This function takes in the number of at-bats and number of hits and will return an average.
#' @param num_hits Number of hits
#' @param num_at_bats Number of at bats
#' @return The batting average.

#' @examples
#' compute_average(10, 50)
compute_average <- function(num_hits, num_at_bats) {

    if (num_at_bats < 1) {
        stop("You need at least one at bat for a batting average!")
    }

    return(num_hits / num_at_bats)
}
```

Using the function `devtools::document` will populate the `man/` directory with your documentation. After running this function, you should notice two new `.Rd` files in your `man/` directory: `BaseballStats-package.Rd` and `compute_average.Rd`. 

After running the function `devtools::document`, you can see your new documentation with the call `?compute_average`.

# Object Oriented Programming In R

For more advanced packages, you may want to develop from an object oriented (OO) perspective. Such an approach could be nice for wrapping up data (e.g. a gene expression matrix) or the parameters around an analysis to replicate downstream (e.g. the filtered gene list, normalization method, etc.).

R supports three different object oriented programming paradigms: S3, S4, and R5. Here we'll focus on S4 classes which are extremely flexible and similar to other object-oriented systems. 

To begin, we'll creating a file for declaring all classes and what data can be stored in each instance. This will go in the `AllClasses.R` file. 

### Defining S4 Classes

We'll begin by creating two classes: `Player` and `Club`. 

In `AllClasses.R` we'll add the following code: 

```R

Player <- setClass("Player",
    slots = c(
        name = "character",
        num_at_bats = "numeric",
        num_hits = "numeric",
        is_pitcher = 'logical',
        era = 'numeric'),
    prototype = list(
        name = character(),
        num_at_bats = 0,
        num_hits = 0,
        is_pitcher = FALSE,
        era = 0.0
))

Club <- setClass("Club",
    slots = c(
        name = 'character',
        city = 'character',
        winning_percentage = 'numeric',
        players = 'list'),
    prototype = list(
        name = character(),
        city = character(),
        winning_percentage = 0.0,
        players = list()

))
```
### Creating Class-Specific Functions 

To support classic object-oriented functionality, you might want to create class-specific functions, including a generator function akin to python's `__init__` function. 

For readability, you can create an `.R`. file for each class you have - for instance `methods-Player.R`. We'll add the following code to `methods-Player.R`: 

```R
#' Initialize a new Player object.
#'
#' @param name Name of the player
#' @param num_at_bats Number of at-bats the player has had
#' @param num_hits Number of hits the player has had 
#' @param is_pitcher Boolean indicating whether or not the player pitches
#' @param era The Earned Run Average (ERA) for a pitcher 
#' @return Player object
Player <- function(name = "", num_at_bats = NULL, num_hits = NULL,
        is_pitcher = FALSE, era = NULL) {

    .Object <- new('Player', name = name, num_at_bats = num_at_bats,
                    num_hits = num_hits, is_pitcher = is_pitcher, era = era)

    return(.Object)
}

#' Compute a Player's batting average
#'
#' @param object A Player
#' @return The player's batting average 
setMethod("compute_batting_average", signature(object = "Player"),
            function(object) {

            return(compute_average(object@num_hits, object@num_at_bats))

        }
```

As for the `Club` class we'll add to a file called `methods-Club.R`:

```R
Club <- function(name = "", city = "", winning_percentage = NULL,
        players = list()) {

    .Object <- new('Club', name = name, city = city,
                    winning_percentage = winning_percentage, players = players)

    return(.Object)
}


#' Compute the team's batting average
#'
#' @param object A Club
#' @return The Club's batting average
setMethod("compute_batting_average", signature(object = "Club"),
            function(object) {
            
            num_hits = sum(sapply(object@players, function(x) x@num_hits))
            num_at_bats = sum(sapply(object@players, function(x) x@num_at_bats))

            return(compute_average(num_hits, num_at_bats))

        }
```

You may notice that both objects have a function called `compute_batting_average`. This takes advantage of R's multiple dispatching feature, meaning that it will look for the object's "signature" before calling the function. In order to take advantage of this, we'll need to create one more file in `R/` that will store these **generics** that support multiple dispatch: `AllGenerics.R`. We'll add a single generic for now to `AllGenerics.R`:

```R
setGeneric("compute_batting_average", function(object, ...) {
    standardGeneric("compute_batting_average")
})

```

Now we can get this functionality:

```R
devtools::load_all()

p1 = Player('Babe Ruth', num_hits = 1000, num_at_bats = 2000)
p2 = Player('Joe Dimaggio', num_hits = 3000, num_at_bats = 5000)

yankees = Club(name = 'yankees', city='New York', players = list(p1, p2))

compute_batting_average(p1)
> 0.5

compute_batting_average(yankees)
```

# Publishing Your Code

# Topics

## Rcpp

## Shiny apps

