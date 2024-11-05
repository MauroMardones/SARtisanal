---
title: "User Guide **SARtisanal** package to calculate of Swept Area Ratio (SAR) in artisanal fisheries context"
subtitle: "Proyecto IN-BENTO (Desarrollo de bioindicadores para el seguimiento de los ecosistemas intermareal y submareal sometidos a explotación marisquera en el litoral de Huelva) (Consejería de Universidad, Investigación e Innovación de la Junta de Andalucía y el Gobierno de España. Financiado por la Unión Europea-NextGeneration EU. MRR)"
author: "Mardones. M., Delgado, M., González, José Manuel"
date:  "05 November, 2024"
#bibliography: INBENTO.bib
#csl: apa.csl
link-citations: yes
linkcolor: blue
output:
  html_document:
    keep_md: true
    toc: true
    toc_float:
      collapsed: false
      smooth_scroll: false
    theme: cosmo
    fontsize: 0.9em
    linestretch: 1.7
    html-math-method: katex
    self-contained: true
    code-tools: true
# title: "![](IEO-logo2.png){width=10cm}"
# output:
#   bookdown::pdf_document2:
#     includes:
#       before_body: titulo.sty
#     keep_tex: yes
#     number_sections: no
#     toc: true
#     toc_depth: 3
# bibliography: INBENTO.bib
# csl: apa.csl
# link-citations: yes
# linkcolor: blue
# indent: no
# header-includes:
# - \usepackage{fancyhdr}
# - \pagestyle{fancy}
# - \fancyhf{}
# - \lfoot[\thepage]{}
# - \rfoot[]{\thepage}
# - \fontsize{12}{22}
# - \selectfont
---

\newpage




``` r
library(SARtisanal)
library(tidyverse)
library(ggridges)
library(here)
library(lubridate)
library(readr)
library(ggthemes)
library(kableExtra)
library(gtsummary)
library(egg)
library(ggthemes)
library(sf)
```


# Initial steps

This is a basic example which shows you how to solve a common problem to read and calculate distance with this kind of data


``` r
library(SARtisanal)
```

Example to load owd data;


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

1. Load data example


``` r
data("artdata")
```


2. Remove duplicate data with `remo_dup`;


``` r
head(artdata)
```

```
##                     FK_ERES      FECHA      DIA     HORA FK_BUQUE MATRICULA
## Draga_01_2009.txt.1     601 29/01/2009 THURSDAY 13:31:17     9883  SE-1-768
## Draga_01_2009.txt.2     601 29/01/2009 THURSDAY 13:39:15     9883  SE-1-768
## Draga_01_2009.txt.3     601 29/01/2009 THURSDAY 13:42:13     9883  SE-1-768
## Draga_01_2009.txt.4     601 29/01/2009 THURSDAY 13:51:13     9883  SE-1-768
## Draga_01_2009.txt.5     601 30/01/2009   FRIDAY 11:01:20     9883  SE-1-768
## Draga_01_2009.txt.6     601 30/01/2009   FRIDAY 12:22:22     9883  SE-1-768
##                       PUERTO FK_TIPO_F F_LOCALIZA N_LONGITUD N_LATITUD      N_X
## Draga_01_2009.txt.1 SANLUCAR         3  29-JAN-09  -6.338148  36.80516 202279.3
## Draga_01_2009.txt.2 SANLUCAR         3  29-JAN-09  -6.338153  36.80516 202278.8
## Draga_01_2009.txt.3 SANLUCAR         3  29-JAN-09  -6.338127  36.80516 202281.2
## Draga_01_2009.txt.4 SANLUCAR         3  29-JAN-09  -6.338148  36.80515 202279.2
## Draga_01_2009.txt.5 SANLUCAR         3  30-JAN-09  -6.451208  36.87560 192471.5
## Draga_01_2009.txt.6 SANLUCAR         3  30-JAN-09  -6.360342  36.79270 200249.9
##                         N_Y N_VELOCIDAD N_RUMBO N_SATELITES N_EN_PUERTO
## Draga_01_2009.txt.1 4078662     0.10799  22.100           5           0
## Draga_01_2009.txt.2 4078661     0.11879  66.224           7           1
## Draga_01_2009.txt.3 4078662     0.14039  87.848           8           1
## Draga_01_2009.txt.4 4078661     0.10799 114.800           8           1
## Draga_01_2009.txt.5 4086838     1.83423  12.982           9           0
## Draga_01_2009.txt.6 4077348     0.76350 260.670           7           0
##                     L_BACKUP FK_ACTIVI FK_ESTADO FK_MODAL
## Draga_01_2009.txt.1        0         3         5        0
## Draga_01_2009.txt.2        0         1         5        0
## Draga_01_2009.txt.3        0         1         5        0
## Draga_01_2009.txt.4        0         1         5        0
## Draga_01_2009.txt.5        0         4         3        3
## Draga_01_2009.txt.6        0         3         3        0
```

``` r
artdata2 <- remo_dup(artdata)
dim(artdata2)
```

```
## [1] 41663    21
```

3. Call the `distar` function using `mapply`;


``` r
# Calcular distancias entre filas consecutivas
distancias <- mapply(distart,
   artdata2$N_LATITUD,
   artdata2$N_LONGITUD,
   lag(artdata2$N_LATITUD),
   lag(artdata2$N_LONGITUD)
   ) 
  
artdata2 <- artdata2 %>%
  mutate(distancias = distancias) %>% 
  mutate_if(is.numeric, round, 3)
```


Visualizing data with `skim`;


``` r
skimr::skim(artdata2)
```


Table: Data summary

|                         |         |
|:------------------------|:--------|
|Name                     |artdata2 |
|Number of rows           |41663    |
|Number of columns        |22       |
|_______________________  |         |
|Column type frequency:   |         |
|character                |6        |
|numeric                  |16       |
|________________________ |         |
|Group variables          |None     |


**Variable type: character**

|skim_variable | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:-------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|FECHA         |         0|             1|  10|  10|     0|       57|          0|
|DIA           |         0|             1|   6|   9|     0|        7|          0|
|HORA          |         0|             1|   8|   8|     0|    24313|          0|
|MATRICULA     |         0|             1|   8|  10|     0|       84|          0|
|PUERTO        |         0|             1|   4|  13|     0|        7|          0|
|F_LOCALIZA    |         0|             1|   9|   9|     0|       57|          0|


**Variable type: numeric**

|skim_variable | n_missing| complete_rate|       mean|       sd|         p0|        p25|        p50|        p75|       p100|hist  |
|:-------------|---------:|-------------:|----------:|--------:|----------:|----------:|----------:|----------:|----------:|:-----|
|FK_ERES       |         0|             1|     726.04|   250.68|     501.00|     581.00|     630.00|     681.00|    1310.00|▇▁▁▁▂ |
|FK_BUQUE      |         0|             1|   24574.71|  2951.43|    9883.00|   24204.00|   25171.00|   25978.00|   27201.00|▁▁▁▂▇ |
|FK_TIPO_F     |         0|             1|       3.00|     0.00|       3.00|       3.00|       3.00|       3.00|       3.00|▁▁▇▁▁ |
|N_LONGITUD    |         0|             1|      -6.84|     0.26|      -7.41|      -6.87|      -6.82|      -6.69|      -6.34|▃▁▇▆▂ |
|N_LATITUD     |         0|             1|      37.09|     0.10|      36.75|      37.06|      37.11|      37.12|      37.23|▁▁▁▇▃ |
|N_X           |         0|             1|  158833.07| 23071.89|  107650.37|  155969.19|  160927.12|  171739.75|  202389.14|▃▁▇▆▂ |
|N_Y           |         0|             1| 4111560.72| 11492.26| 4072521.42| 4108525.81| 4114135.27| 4115954.07| 4128613.72|▁▁▂▇▃ |
|N_VELOCIDAD   |         0|             1|       1.66|     0.89|       0.10|       1.08|       1.92|       2.22|       5.00|▆▇▇▁▁ |
|N_RUMBO       |         0|             1|     180.52|   101.10|       0.00|     102.62|     157.18|     284.67|     359.99|▅▇▅▃▆ |
|N_SATELITES   |         0|             1|       9.05|     1.14|       4.00|       8.00|       9.00|      10.00|      12.00|▁▁▂▇▁ |
|N_EN_PUERTO   |         0|             1|       0.11|     0.32|       0.00|       0.00|       0.00|       0.00|       1.00|▇▁▁▁▁ |
|L_BACKUP      |         0|             1|       0.01|     0.10|       0.00|       0.00|       0.00|       0.00|       1.00|▇▁▁▁▁ |
|FK_ACTIVI     |         0|             1|       3.39|     0.89|       1.00|       3.00|       4.00|       4.00|       4.00|▁▁▁▅▇ |
|FK_ESTADO     |         0|             1|       4.83|     0.67|       1.00|       5.00|       5.00|       5.00|       5.00|▁▁▁▁▇ |
|FK_MODAL      |         0|             1|       1.79|     1.51|       0.00|       0.00|       3.00|       3.00|       4.00|▆▁▁▇▁ |
|distancias    |         1|             1|    1127.35|  4130.41|       0.00|     101.82|     240.32|     608.74|  105605.95|▇▁▁▁▁ |

# Calculate SAR


# Maps

# References
