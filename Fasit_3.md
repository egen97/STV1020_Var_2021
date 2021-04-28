---
title: "Fasit Seminar 3"
author: "Eric"
date: "05 4 2021"
output: 
    pdf_document: 
      keep_md: yes
    github_document:
    fig_width: 5
    fig_height: 5
    dev: jpeg
---

![](Bilder/erro_biden.jpg)




# Oppgave 1



```r
#Her laster jeg inn data som vanlig :)
ESS <- readRDS("ess.rds")
#må også huske å kjøre library for å kunne bruke tidyverse
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

# Oppgave 2

* Hent ut flere runder fra samme land
    * Flere land har ikke deltatt i alle rundene. Sjekk at landet du valget
      har vært med i alle de rundene du valgte. 
      Hint: Kanskje table og unique kan hjelpe deg?
      
      
Denne oppgaven gjør at dere må sette sammen  mye av den koden vi har brukt så langt, og
tenke over hvordan de kan fungere sammen. Det første steget vil være å se hvilke land som
vi har tilgengelig i de forskjellige rundene. Det letteste her kan være å lage en krysstabell,
men her finnes det mange muligheter!


```r
table(ESS$Country, ESS$essround) #Her bruker jeg table for å lage en tabell med de variablene jeg ønsker. 
```

```
##     
##         1    2    3    4    5    6    7    8    9
##   AL    0    0    0    0    0 1201    0    0    0
##   AT 2257 2256 2405    0    0    0 1795 2010 2499
##   BE 1899 1778 1798 1760 1704 1869 1769 1766 1767
##   BG    0    0 1400 2230 2434 2260    0    0 2198
##   CH 2040 2141 1804 1819 1506 1493 1532 1525 1542
##   CY    0    0  995 1215 1083 1116    0    0  781
##   CZ 1360 3026    0 2018 2386 2009 2148 2269 2398
##   DE 2919 2870 2916 2751 3031 2958 3045 2852 2358
##   DK 1506 1487 1505 1610 1576 1650 1502    0    0
##   EE    0 1989 1517 1661 1793 2380 2051 2019 1904
##   ES 1729 1663 1876 2576 1885 1889 1925 1958 1668
##   FI 2000 2022 1896 2195 1878 2197 2087 1925 1755
##   FR 1503 1806 1986 2073 1728 1968 1917 2070 2010
##   GB 2052 1897 2394 2352 2422 2286 2264 1959 2204
##   GR 2566 2406    0 2072 2715    0    0    0    0
##   HR    0    0    0 1484 1649    0    0    0 1810
##   HU 1685 1498 1518 1544 1561 2014 1698 1614 1661
##   IE 2046 2286 1800 1764 2576 2628 2390 2757 2216
##   IL 2499    0    0 2490 2294 2508 2562 2557    0
##   IS    0  579    0    0    0  752    0  880    0
##   IT 1207 1529    0    0    0  960    0 2626 2745
##   LT    0    0    0    0 1677 2109 2250 2122 1835
##   LU 1552 1635    0    0    0    0    0    0    0
##   LV    0    0 1960 1980    0    0    0    0  918
##   ME    0    0    0    0    0    0    0    0 1200
##   NL 2364 1881 1889 1778 1829 1845 1919 1681 1673
##   NO 2036 1760 1750 1549 1548 1624 1436 1545 1406
##   PL 2110 1716 1721 1619 1751 1898 1615 1694 1500
##   PT 1511 2052 2222 2367 2150 2151 1265 1270 1055
##   RO    0    0 2139 2146    0    0    0    0    0
##   RS    0    0    0    0    0    0    0    0 2043
##   RU    0    0 2437 2512 2595 2484    0 2430    0
##   SE 1999 1948 1927 1830 1497 1847 1791 1551 1539
##   SI 1519 1442 1476 1286 1403 1257 1224 1307 1318
##   SK    0 1512 1766 1810 1856 1847    0    0 1083
##   TR    0 1856    0 2416    0    0    0    0    0
##   UA    0 2031 2002 1845 1931 2178    0    0    0
##   XK    0    0    0    0    0 1295    0    0    0
```

```r
#Her vil jeg jo bare ha Land og Runde variablene, 
```

Her ser vi at får alle landene, og antall respondenter de har pr. runde. Er det 0 respondenter vil jo det da fortelle oss at de ikke var med i den runden. Vi kan også se at noen land (f.eks. Kosovo) har vært med kun en gang, mens andre som Storbrittania har vært med hver gang. Siden oppgaven ber oss om å sammenligne over tid kan det være lurt å ta noen som har vært med ganske mange ganger. 


```r
GB <- ESS %>%
  filter(Country == "GB") #Her bruker jeg filter for å hente ut Storbrittania, siden jeg ikke sier noe om runder
#får jeg bare alle rundene landet er med i. 
```


# Oppgave 3

* Noen av variablene kan gi mening å sammenligne over tid. Velg ut noen du synes er passende. 
  * Bruk et passende plott for å se utviklingen mellom rundene. 
  * Kan du finne noen mål på sentraltendens pr runde? For eksempel gjennomsnitt, median, e.l.?
  

De fleste variablene her kan vel egentlig være interesante i et tidsperspektiv. Her kommer jeg til  å se på hvordan tilitt til politiet har forandet seg over tid. For å plotte over tid må vi først ha en tidsvariabel på x-aksen. Her blir det runde variabelen vår. På y-aksen får vi fort et problem; vi har ikke lyst til å plotte alle *respondtene* over tid, men heller ett mål på hva tilliten er i hver runde generelt. Her er det veldig, veldig mange løsninger. 

Ett forslag er å gi respondentene en variabel som skiller mellom de som har "høy" tillit og "lav" tillit. Den kan vi bruke i et kolloneplot for å se hvor mange som har høy tillit i hver runde. 


```r
GB %>%
  mutate(High = ifelse(Trust_Police > 9, 1, 0)) %>%
  ggplot(aes(essround, High)) +
  geom_col()
```

![](Fasit_3_files/figure-latex/unnamed-chunk-4-1.pdf)<!-- --> 

```r
#Først kan vi lage en ny dikotom variabel som sier hvorvidt du har høy tilitt eller ikke. Her må vi velge
#et cut off point vi synes er rimelig. Jeg kommer til å bruke 7 og høyere. 

GB$highTrustPolice <- ifelse(GB$Trust_Police > 6, 1, 0)

#Nå som vi har denne kan vi bruke et geom_col() plott for å se hvor mange som hadde høy tillit i
#de forskjellige rundene

ggplot(GB, aes(as.factor(essround), highTrustPolice)) + #Har lyst til å se alle rundene, men vil at essround skal forbli numerisk
  geom_col() +                                          # i datasettet. Derfor legger jeg den inn her.
  theme_classic()+ #Her legger jeg til litt pynt
  labs(title = "Tillit til politiet", subtitle = "Storbrittania", x = "Runde", y = "Andel med høy tillit")
```

![](Fasit_3_files/figure-latex/unnamed-chunk-4-2.pdf)<!-- --> 


# Oppgave 4

* Kjønn og stemt er dikotome variabler, men med verdiene 1 og 2. 
  * Gjør om verdiene så de har 0 og 1 istedet, og gi variablene nye navn. 
  * Finn ut hvorvidt menn eller kvinner har størtst valgdeltagelse, finn
    et passende plott for dette i tillegg. 
    


```r
# For å gjøre om variablene til 1 og 0 kan vi bare trekke fra 1 på den orginale variabelen

GB <- GB %>%
  mutate(kjonn = Gender -1)

#Vi kan jo sjekke om det funka  med summary
summary(GB$kjonn)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
##  0.0000  0.0000  1.0000  0.5511  1.0000  1.0000      12
```

For å plotte finnes det ganske mange valg her. Et enkelt ett er å bare lage to plott, med filter for hvert kjønn og sammenligne de to. Her kommer jeg til å vise en måte å gjøre akkurat det på, men i enn samlet kode. 



```r
ggplot(GB, aes(vote)) + #
  geom_bar() +
  facet_wrap(~kjonn)
```

```
## Warning: Removed 62 rows containing non-finite values (stat_count).
```

![](Fasit_3_files/figure-latex/unnamed-chunk-6-1.pdf)<!-- --> 

Her vi to plott, hvor vi kan se at det er noe fler kvinner som stemmer enn menn. Dette kunne dere også ha gjort med å bruke filter() for å få ett datasett med kun kvinner, og ett med kun menn. 

# Oppgave 5

* Prøv å sammenligne stemmegivning pr. kjønn over tid, og mellom land. 


Denne oppgaven ber deg gjøre det samme som over, bare med land i tilegg. Enkleste er dermed også bare lage flere datasett, hvor du kan plotte for seg. For hvert kjønn kan en lage stemmegivning over år på samme måte som vi gjorde i oppgave 3. Her kommer jeg til å vise en måte å gjøre det på. 



```r
#Først kan vi velge noen land

Land <- ESS %>%
  filter(Country == "GB" | Country == "NO" | Country == "DK") %>%
  filter(essround  >= 5 & essround <= 7) #Siden det blir fler land, velger jeg ut noen runder så det ikke blir
                                         # så alt for rotete

LandMenn <- Land %>%
  filter(Gender == 1)


ggplot(LandMenn, aes(vote)) + 
  geom_bar() +
  facet_wrap(c("Country", "essround"), scales = "free")
```

```
## Warning: Removed 16 rows containing non-finite values (stat_count).
```

![](Fasit_3_files/figure-latex/unnamed-chunk-7-1.pdf)<!-- --> 

# Oppgave 5

* Flere av variablene måler forskjellige typer tilitt. Ofte sier vi at disse til sammen kan måle det vi kaller
  en "latent" variabel; noe vi ikke kan måle direkte, men hvor flere variabler måler begrepet sammen. Her kan vi
  si at dette er en form for generell "tilit." Prøv å bruke disse variablene til å lage en ny skala du mener representerer
  dette. 
  * Er det noen sammenheng mellom denne nye skalaen og noen av de andre variablene? Velg ut de du tenker kan være
    logiske å sammenligne. 
  * Velg ut et land, ossen har tilitten utviklet seg over tid?
  * Sammenlign noen land, har noen av de høyere tillitt enn andre?
  
  
  
Den første oppgaven ber oss bare lage en ny skala basert på de andre. Her er det mange muligheter avhengig av hva du synes gir mest mening; en kan f.eks. bare ta summen av alle variablene, en kan ta et gjennomsnitt, median, og mange fler. Her kommer jeg til å bruke gjennomsnittet. Denne oppgaven er *veldig* vanskelig, siden dere må finne en måte å ta gjennomsnitt pr. rad om dere vil sammenligne innad et land. En annen litt enklere mulighet er å ta gjennomsnittet pr land, og så sammenligne disse. Her kommer jeg først til å vise den vanskelige løsningen, og så hvordan vi kan gjøre det ved å sette sammen observasjoner fra forskjellige land. 


```r
ESS <- ESS %>%
  mutate(id = 1:n()) %>%
  group_by(id) %>%
  mutate(tillit = mean(c(Trust_People, Trust_Police, Trust_Politicians), na.rm = TRUE)) %>%
  ungroup()

#Her får jeg gjennomsnittet for hver eneste person i ESS datasettet, men samtidig ser en jo at det skjer ganske mye her. 
#Det første jeg gjør er å lage en ny variabel som heter "id" med mutate. Når jeg skriver 1:n() betyr det at variabelen skal ha
#et tall som stiger med en for hver rad. Altså får hver rad en ID som bare er 1,2,3,4..434063, 434064, 434065
#Med en ID pr rad kan jeg bruke denne for å si at R skal gjøre noe for hver ID, og ikke hele datasettet. 

#Så bruker jeg group_by() (som vi ikke har lært enda, så her er du veldig god om du har funnet ut av det!!) den gjør at vi kan
#kjøre en kode pr. gruppe, heller enn hele datasettet. Siden jeg her skriver at gruppen er "id", blir det pr rad. 

#Til slutt bruker jeg mutate for å lage en ny variabel. Denne sier jeg at skal være gjennomsnittet av de tre tillitsvariablene, og
#siden jeg brukte group_by() blir det gjennomsnittet for hvert land. 


#Denne er veldig vanskelig, så noe lettere  kan være å hente ut gjennomsnittet pr land, og så sette sammen disse. Det kan vi gjøre 
#ved å bruke filter for å hente ut forskjellige land, og så regne ut gjennomsnittet. Disse kan vi så slå sammen til ett nytt
#datasett. Her henter jeg ut tre land, og setter sammen disse. Her legger jeg til noen ekstra variabler i tilegg

FR_Til <- ESS %>%
  select(Country, essround, Trust_People, Trust_Police, Trust_Politicians, Time_News) %>%
  filter(Country == "FR" & essround == "8") %>%
  mutate(tillit = mean(c(Trust_Police, Trust_People,Trust_Politicians), na.rm = TRUE)) %>%
  mutate(Time_News = mean(Time_News, na.rm = TRUE)) %>%
  select(Country, tillit, Time_News)


GB_Til <- ESS %>%
  select(Country, essround, Trust_People, Trust_Police, Trust_Politicians, Time_News) %>%
  filter(Country == "GB" & essround == "8") %>%
  mutate(tillit = mean(c(Trust_Police, Trust_People,Trust_Politicians), na.rm = TRUE)) %>%
  mutate(Time_News = mean(Time_News, na.rm = TRUE)) %>%
  select(Country, tillit, Time_News)


NO_Til <- ESS %>%
  select(Country, essround, Trust_People, Trust_Police, Trust_Politicians, Time_News) %>%
  filter(Country == "NO" & essround == "8") %>%
  mutate(tillit = mean(c(Trust_Police, Trust_People,Trust_Politicians), na.rm = TRUE)) %>%
  mutate(Time_News = mean(Time_News, na.rm = TRUE)) %>%
  select(Country, tillit, Time_News)



#Nå kan vi bare slå sammen disse, med row-bind

TillitData <- bind_rows(FR_Til, GB_Til, NO_Til)


TillitData <- distinct(TillitData, .keep_all = TRUE) #Nå kan vi bruke distinct for å få en rad pr. land


ggplot(TillitData, aes(Time_News, tillit, fill = Country )) +
  geom_col() +
  theme_classic()+
  labs(y = "Tillit", x = "Tid på nyheter, i min. pr dag", title = "Sammenheng mellom nyheter og tillit", fill = "Land" )
```

![](Fasit_3_files/figure-latex/unnamed-chunk-8-1.pdf)<!-- --> 

Hvordan kan vi tolke dette plottet? Vel vi ser at franskmenn bruker minst tid på nyheter, og også har lavest tillit. Storbritannia og Norge er ganske likt på nyheter, men Norge har betydelig høyere tillit. Kanskje kan vi se at å bruke mer tid på nyheter skaper en større tillit, men at det også er noe annet her som påvirker men som vi ikke vet hva er?


# Oppgave 6


* Velg ut ett land, men alle runder de er med. Lag en variabel som har verdien 1 om de i ett gitt år har høyere tilitt
  enn gjennomsnittet, og to om det er under. 
  * Finn hvilke år de har høyere enn gjennomsnittet. 
  
  
  
Her velger jeg Storbrittania, siden de har verdt med i de fleste rundene. Her må vi også finne en måte å få frem variablene på land-runde-nivå

```r
GB <- ESS %>%
  filter(Country == "GB") %>%
  select(essround, tillit) %>%
  group_by(essround) %>%
  summarise(TilMean = mean(tillit, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(TilOver = ifelse(TilMean > mean(TilMean, na.rm = TRUE), 1, 0))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```r
#Dette ble også en ganske vanskelig kode, men det jeg gjør her er å skaffe gjennomsnittet for hver runde.
#Så ser jeg om dette gjennomsnittet er større en gjennomsnittet for alle rundene. 




ggplot(GB, aes(essround, TilOver)) +
  geom_line() +
  theme_classic()
```

![](Fasit_3_files/figure-latex/unnamed-chunk-9-1.pdf)<!-- --> 

Her på plottet ser vi at tilliten plutselig bli høyere etter runde 5. 

Som sagt, disse oppgavene ble veldig vanskelige. Har du fått til noe så er det mer enn bra! 

    
