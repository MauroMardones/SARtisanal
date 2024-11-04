
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SARtisanal

<!-- badges: start -->
<!-- badges: end -->

The objective of the `SARtisanal` package is to facilitate a series of
calculations performed with monitoring data from artisanal fisheries,
derived from telecommunications information that monitors vessels
activities. It optimizes data processing and allows researchers and
professionals in the field to access efficient tools for data analysis.
This includes functions to read multiple files, calculate distance,
compute fishing effort and SAR (*Swept Area Ratio*), and provide
spatio-temporal visualization, among others. Furthermore, the package
aims to standardize analytical methods, promoting greater transparency
and reproducibility in research on artisanal fisheries and their
environmental impact through the calculation of SAR.

## Installation

You can install the development version of SARtisanal from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("MauroMardones/SARtisanal")
```

or

``` r
library(devtools)
install_github("MauroMardones/SARtisanal")
```

## Example

This is a basic example which shows you how to solve a common problem to
read and calculate distance with this kind of data

``` r
library(SARtisanal)
```

``` r
archivos <- c("Draga_01.txt", 
              "Draga_02.txt", 
              "Draga_03.txt")
carpeta <- "your/path"

# Read and join all files
if (all(file.exists(file.path(carpeta, archivos)))) {
  datos_combinados <- read_artdata(archivos, carpeta, sep = ",")
  print(datos_combinados)
} else {
  warning("One or more files are not found in the specified folder.")
}
```

Calculating distances;

1.  Load data example

``` r
data("artdata")
```

2.  Call the distar function using mapply

``` r
distancias <- mapply(distart, 
                     datos$lat1, 
                     datos$lon1, 
                     datos$lat2, 
                     datos$lon2)
print(distancias)
```

(working in data documentation…)
