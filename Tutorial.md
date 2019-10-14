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

Finally, you'll want to install `devtools` in R, which can be done from within R:

```R
install.packages('devtools')
```



# Topics

## Creating Documentation

## Object Oriented Programming in R
### Hybrid class types (using OR)

## The anatomy of an R package

## Rcpp

## Shiny apps

## CRAN, Bioconductor, and publishing your code

## Devtools

