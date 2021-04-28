---
title: "Fasit 2020"
author: "Eric"
date: "12 4 2021"
output: 
    pdf_document: 
      keep_md: yes
    github_document:
    fig_width: 5
    fig_height: 5
    dev: jpeg
---

![](Bilder/dogate.png)








# Oppgave 1

Hent datasett


```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.2     v purrr   0.3.4
## v tibble  3.0.4     v dplyr   1.0.2
## v tidyr   1.1.2     v stringr 1.4.0
## v readr   1.4.0     v forcats 0.5.0
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
wages_data <- read.csv("https://raw.githubusercontent.com/langoergen/stv1020R/master/data/wages.csv")
```


# Oppgave 2

Se på variabelen for inntekt og utdanning. Hent ut gjennomsnittet, minimumsverdi, maxverdi og standardavvik hos begge variablene. Hvor mange missing-verdier er det hos de to variablene?







```r
summary(wages_data$wages)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##   2.300   9.235  14.090  15.553  19.800  49.920    3278
```

```r
sd(wages_data$wages, na.rm =  TRUE)
```

```
## [1] 7.883066
```

```r
summary(wages_data$education)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##    0.00   10.30   12.10   12.50   14.53   20.00     249
```

```r
sd(wages_data$education, na.rm = TRUE)
```

```
## [1] 3.362506
```

```r
#Inntekt har har henholdsvis 15.5, 2.3, 49.9, og 7.88
#Utdanning har 12.5, 0, 20, 3.36
```



# Oppgave 3

- Lag og presenter et histogram for inntektsvariabelen. Hva viser det?


```r
# Histogram 
ggplot(wages_data, aes(wages)) +
  geom_histogram(binwidth = 1, fill = "springgreen1") +
  theme_classic() +
  labs(title = "Inntekt")
```

```
## Warning: Removed 3278 rows containing non-finite values (stat_bin).
```

![](Fasit2020_files/figure-latex/unnamed-chunk-3-1.pdf)<!-- --> 

```r
#Histogrammet viser at vi har en høyreskjev fordeling, men noe lang hale
```





# Oppgavve 4.
- Plott inntekt og utdanning mot hverandre i et spredningsplott/scatterplot. Gi en kort kommentar til
plottet



```r
ggplot(wages_data, aes(education ,wages)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_classic()+
  labs(x = "Utdanning", y = "Lønn", title = "Forhold mellom inntekt og utdanning")
```

```
## `geom_smooth()` using formula 'y ~ x'
```

```
## Warning: Removed 3411 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 3411 rows containing missing values (geom_point).
```

![](Fasit2020_files/figure-latex/unnamed-chunk-4-1.pdf)<!-- --> 

```r
#Plottet viser at lønn generelt stiger med utanning, spesielt for de individer som har en svært lav utdannelse. 
#Samtidig er det en stor grad av spredning, og utdanning alene forklarer lite av lønnsforskjellene. 
```



# Oppgave 5

5.
- Opprett en krysstabell mellom kjønn og utdanning.



```r
table(wages_data$sex,wages_data$education)
```

```
##         
##            0   1 1.5   2   3   4 4.1 4.5 4.6 4.8   5 5.5   6 6.4 6.5 6.9   7
##   Female  26   5   0   9  18  20   0   0   0   1  26   0  30   1   2   1  40
##   Male    12   3   1   3   8  14   1   2   1   0  28   2  27   0   2   0  37
##         
##          7.3 7.4 7.5 7.6   8 8.1 8.2 8.3 8.5 8.6 8.8   9 9.1 9.2 9.3 9.4 9.5
##   Female   0   0   0   0 238   1   1   2  14   1   2 138   0   1   1   3  24
##   Male     1   1   3   1 231   0   2   0  18   0   0 150   2   0   1   0  14
##         
##          9.6 9.8 9.9  10 10.1 10.2 10.3 10.4 10.5 10.6 10.7 10.8 10.9  11 11.1
##   Female   0   2   1 298    4    2    4    3   61    8    2    1    0 246    4
##   Male     1   2   0 302    2    3    4    2   45    4    0    8    1 227    4
##         
##          11.2 11.3 11.4 11.5 11.6 11.7 11.8 11.9  12 12.1 12.2 12.3 12.4 12.5
##   Female    2    3    1   49    6    0    4    2 570   14    6   11    3  170
##   Male      5    8    1   33    6    2    5    1 476   13    6    9    5  105
##         
##          12.6 12.7 12.8 12.9  13 13.1 13.2 13.3 13.4 13.5 13.6 13.7 13.8 13.9
##   Female   14    6    9    6 302    9    5   14    8   73   13    3   11    4
##   Male      9    4    8    6 256    9    8    7    5   54   13    1    6    4
##         
##           14 14.1 14.2 14.3 14.4 14.5 14.6 14.7 14.8 14.9  15 15.1 15.2 15.3
##   Female 238   17    6   13    2   46    8    0    6    4 186    5    4   11
##   Male   210   10    3    6    3   34    9    1    3    2 164   11    4    5
##         
##          15.4 15.5 15.6 15.7 15.8 15.9  16 16.1 16.2 16.3 16.4 16.5 16.6 16.7
##   Female    3   44    9    1    3    2 151    7    0    7    2   25    2    1
##   Male      0   24    5    1    3    0 157    8    4   10    3   20    4    1
##         
##          16.8 16.9  17 17.1 17.2 17.3 17.4 17.5 17.6 17.7 17.8 17.9  18 18.1
##   Female    5    4 147    6    4    7    6   14    4    2    3    2  67    5
##   Male      1    1 136   10    2    9    4   20    4    0    3    0  95    3
##         
##          18.2 18.3 18.4 18.5 18.6 18.7 18.8  19 19.1 19.2 19.3 19.4 19.5 19.7
##   Female    3    5    1    6    0    1    2  45    3    1    3    2    1    2
##   Male      0    4    2    9    1    1    2  45    3    1    3    0    4    0
##         
##          19.9  20
##   Female    0  55
##   Male      1 104
```


# Oppgave 6

Opprett en numerisk, dikotom variabel for kjønn. Du kan selv velge om kvinne skal få verdien 0 eller
1, mens mann får den motsatte verdien.

- Opprett en dikotom utdannings variabel som har verdien 1 om originalvariabel har større verdier
enn sitt gjennomsnitt og 0 om originalvariabelen har mindre verdier enn sitt gjennomsnitt.

- Kontroller om de to omkodingene har gått i orden med en krysstabell


```r
wages_data <- wages_data %>% 
  mutate(sex2 = ifelse(sex == "Female", 1, 0),
         education2 = ifelse(education > mean(education, na.rm = TRUE) , 1, 0))
```


# Oppgave 7 
 - Kontroller om de to omkodingene har gått i orden med en krysstabell.



```r
table(wages_data$sex2,wages_data$sex)
```

```
##    
##     Female Male
##   0      0 3545
##   1   3880    0
```

```r
table(wages_data$education,wages_data$education2)
```

```
##       
##           0    1
##   0      38    0
##   1       8    0
##   1.5     1    0
##   2      12    0
##   3      26    0
##   4      34    0
##   4.1     1    0
##   4.5     2    0
##   4.6     1    0
##   4.8     1    0
##   5      54    0
##   5.5     2    0
##   6      57    0
##   6.4     1    0
##   6.5     4    0
##   6.9     1    0
##   7      77    0
##   7.3     1    0
##   7.4     1    0
##   7.5     3    0
##   7.6     1    0
##   8     469    0
##   8.1     1    0
##   8.2     3    0
##   8.3     2    0
##   8.5    32    0
##   8.6     1    0
##   8.8     2    0
##   9     288    0
##   9.1     2    0
##   9.2     1    0
##   9.3     2    0
##   9.4     3    0
##   9.5    38    0
##   9.6     1    0
##   9.8     4    0
##   9.9     1    0
##   10    600    0
##   10.1    6    0
##   10.2    5    0
##   10.3    8    0
##   10.4    5    0
##   10.5  106    0
##   10.6   12    0
##   10.7    2    0
##   10.8    9    0
##   10.9    1    0
##   11    473    0
##   11.1    8    0
##   11.2    7    0
##   11.3   11    0
##   11.4    2    0
##   11.5   82    0
##   11.6   12    0
##   11.7    2    0
##   11.8    9    0
##   11.9    3    0
##   12   1046    0
##   12.1   27    0
##   12.2   12    0
##   12.3   20    0
##   12.4    8    0
##   12.5    0  275
##   12.6    0   23
##   12.7    0   10
##   12.8    0   17
##   12.9    0   12
##   13      0  558
##   13.1    0   18
##   13.2    0   13
##   13.3    0   21
##   13.4    0   13
##   13.5    0  127
##   13.6    0   26
##   13.7    0    4
##   13.8    0   17
##   13.9    0    8
##   14      0  448
##   14.1    0   27
##   14.2    0    9
##   14.3    0   19
##   14.4    0    5
##   14.5    0   80
##   14.6    0   17
##   14.7    0    1
##   14.8    0    9
##   14.9    0    6
##   15      0  350
##   15.1    0   16
##   15.2    0    8
##   15.3    0   16
##   15.4    0    3
##   15.5    0   68
##   15.6    0   14
##   15.7    0    2
##   15.8    0    6
##   15.9    0    2
##   16      0  308
##   16.1    0   15
##   16.2    0    4
##   16.3    0   17
##   16.4    0    5
##   16.5    0   45
##   16.6    0    6
##   16.7    0    2
##   16.8    0    6
##   16.9    0    5
##   17      0  283
##   17.1    0   16
##   17.2    0    6
##   17.3    0   16
##   17.4    0   10
##   17.5    0   34
##   17.6    0    8
##   17.7    0    2
##   17.8    0    6
##   17.9    0    2
##   18      0  162
##   18.1    0    8
##   18.2    0    3
##   18.3    0    9
##   18.4    0    3
##   18.5    0   15
##   18.6    0    1
##   18.7    0    2
##   18.8    0    4
##   19      0   90
##   19.1    0    6
##   19.2    0    2
##   19.3    0    6
##   19.4    0    2
##   19.5    0    5
##   19.7    0    2
##   19.9    0    1
##   20      0  159
```



# Oppgave 8

- Lag et nytt datasett som inneholder variablene inntekt, utdanning, kjønn, og de to nye variablene du opprettet.


```r
new_data <- wages_data %>% 
  select(wages, education, sex,age, education2, sex2)
```

# Oppgave 9

- Estimer en enkel bivariat regresjonsmodell med inntekt som avhengig variabel, og utdanning som
uavhengig variabel, tolk resultatene



```r
m1 <- lm(wages ~ education, 
         data = new_data,
         na.action = "na.omit")
summary(m1)
```

```
## 
## Call:
## lm(formula = wages ~ education, data = new_data, na.action = "na.omit")
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -17.700  -5.836  -1.033   4.161  34.206 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  4.93753    0.53285   9.266   <2e-16 ***
## education    0.79460    0.03894  20.405   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 7.494 on 4012 degrees of freedom
##   (3411 observations deleted due to missingness)
## Multiple R-squared:  0.09403,	Adjusted R-squared:  0.0938 
## F-statistic: 416.4 on 1 and 4012 DF,  p-value: < 2.2e-16
```

```r
#Inntekt har en stigningskoeffisient på 0,8, signifikant på < 0.001 nivå, og justert R^2 på 0.09
```

# Oppgave 10 
- Legg til kjønn som en kontrollvariabel i denne modellen. Estimer modellen og tolk resultatene



```r
m2 <- lm(wages ~ education + sex, 
                 data = new_data,
                 na.action = "na.omit")

summary(m2)
```

```
## 
## Call:
## lm(formula = wages ~ education + sex, data = new_data, na.action = "na.omit")
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -19.575  -5.202  -0.860   3.982  32.518 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  2.97127    0.53357   5.569 2.74e-08 ***
## education    0.81028    0.03787  21.399  < 2e-16 ***
## sexMale      3.52823    0.23003  15.338  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 7.284 on 4011 degrees of freedom
##   (3411 observations deleted due to missingness)
## Multiple R-squared:  0.1442,	Adjusted R-squared:  0.1438 
## F-statistic:   338 on 2 and 4011 DF,  p-value: < 2.2e-16
```

```r
#Med kjønn ser vi at vi kan forklare noe mer varians. Menn tjener også i snitt 3.5 skalapunkter mer enn kvinner. 
```

