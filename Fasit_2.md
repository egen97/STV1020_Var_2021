---
title: "Fasit Seminar 2"
author: "Eric"
date: "19 3 2021"
output: 
    pdf_document: 
      keep_md: yes
    github_document:
    fig_width: 5
    fig_height: 5
    dev: jpeg
---

![](Bilder/solution.jpg)


# Oppgave 1:


* Hent et land-år du er innteresert i, og velg ut noen (minst 5) variabler du er interesert i.
  * Gi disse variablene nye navn du synes er mer logiske. 
  * Legg inn aldersvariabelen. Anta at dataene er fra 2020, legg inn en ny variabel som viser året de er født.


Før vi kan hente ut variablene, må vi laste ned datasettet. Dette kan vi enten gjøre med linken som følger i dokumentet for seminar 2, eller lese inn fra vår egen datamaskin. Her kommer jeg til å gjøre sistnevnte, om dere vil se løsningen for det første står dette i dokumentet. 


```r
ESS <- readRDS("ess.rds")
#Når jeg har gjort dette kan vi se i environment-fanen at jeg har fått et datasett
#med 24 variabler og 43065 observasjoner. 
#Her skal vi også bruke funksjoner fra tidyverse, så jeg må huske å laste inn disse. 
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

Neste oppgave er å hente ut 5 variabler, og gi disse nye navn. Dette kan vi gjøre med `select()`, `filter()` og `rename()`funksjonene. Siden neste oppgave ber oss om å legge til alders variabelen kommer jeg til å gjøre det her. 


```r
NO8 <- ESS %>%
  filter(Country == "NO" & essround == 8) %>% #Filter gjør at jeg kan velge ut kun de radene som oppfyller et kriterie. Her at variablene land og runde har verdiene "NO" og 8
  select(Time_News, Trust_People, Age, Party_Voted_NO, People_Fair, Gender) %>% #I select() funksjonen kan jeg skrive inn navnene på de variablene jeg ønsker å ha med
  rename(
    "tidNYHETER" = "Time_News", #I rename skriver jeg først det jeg ønsker skal være det nye navnet i hermetegn, og så = før det nye navnet i hermtegn. 
    "tillitANDRE" = "Trust_People", #For å skille mellom de forskjellige variablene bruker jeg et komma
    "alder" = "Age", 
    "partiSTEMT" = "Party_Voted_NO",
    "andreRETTFERDIGE" = "People_Fair"
    
    )
```

Det er flere forskjellige måter vi kan legge inn fødselsåret på. Det viktige er å få en variabel som inneholder 2020 - alderen på respondenten. Her kommer jeg til å vise to måter å gjøre det på, først base-R også i tidyverse med mutate. 


```r
#For å legge til en variabel kan vi gjøre det på samme måte som når vi ellers prøver å manipulere en, altså med dollartegn. Her kan vi bare si at en ny variabel
#skal være 2020 minus aldersvariabelen:

NO8$birthYear <- 2020- NO8$alder
#Nå kan vi bruke table() for å sjekke om det ble riktig
table(NO8$birthYear)
```

```
## 
## 1922 1925 1926 1927 1928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 
##    1    1    1    1    1    4    2    4    4    2    6    9    7    6   12    8 
## 1940 1941 1942 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 
##    7    9   10   13    7    6    8   12   17   19   24   17   27   27   25   24 
## 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 
##   26   19   18   16   25   22   21   30   29   22   26   23   33   35   33   23 
## 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 
##   32   29   27   23   27   36   23   21   21   23   24   21   25   23   26   25 
## 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 
##   24   28   21   17   31   26   25   17   20   30   23   24   24   19   22   24 
## 2004 2005 
##   26   16
```

```r
#I tabellen har kan vi se at vi har fått et ganske logisk resultat. Vi har noen få individer som er svært gamle, omlag 70 ut av 1500 før krigen, og de fleste
#mellom 60- og 90-tallet. 

#Vi kunne også gjort det samme med mutate-funksjonen fra tidyverse. I dette tilfellet er det hovedsakelig en forskjell i syntax, men i senere seminarer
#vil se at dette fort kan bli ganske nyttig!

NO8 <- NO8 %>%
  mutate(birthYear = 2020 - alder)

#Forskjellen her ligger kun i hvordan vi skriver koden. Her skrivet jeg istedet det nye navnet innad i funksjonen, uten å måtte skrive
#navnet på datasettet. I tilegg bruker jeg "=" heller enn "<-". Dette kommer av at vi bruker <- som en funksjon i seg selv, mens = brukes
#innad i andre funksjoner. 
```

* Hvilken klasse har variablene dine? Er de passende?
  * Forandre klassen på en av variablene. Hva har forandret seg?
  
  

```r
#Den letteste måten å finne klassen til alle variablene er ved å bruke str() funksjonen. Den viser i tilegg også de første observasjonene, 
#og navnet på variablene. 
str(NO8)
```

```
## 'data.frame':	1545 obs. of  7 variables:
##  $ tidNYHETER      : int  30 60 180 110 600 240 10 60 5 60 ...
##  $ tillitANDRE     : int  8 4 8 9 5 3 7 8 8 8 ...
##  $ alder           : int  74 17 54 50 25 43 45 75 27 62 ...
##  $ partiSTEMT      : int  4 NA 2 3 3 4 NA 4 7 6 ...
##  $ andreRETTFERDIGE: int  8 6 8 7 3 8 7 7 7 8 ...
##  $ Gender          : int  1 1 1 2 1 1 2 2 2 1 ...
##  $ birthYear       : num  1946 2003 1966 1970 1995 ...
```

```r
#Her kan vi se at alle variablene våre er integer, med unntak av birthYear som er numerisk. Forskjellen mellom de to er i utgangspunktet, ikke så
#viktig, det betyr bare at alle er tall. 
#Vi kan også sjekke ut enkeltvariabler med class() funksjonen:
class(NO8$tidNYHETER)
```

```
## [1] "integer"
```

```r
#Her får vi svar at det er en integer, men kun for den ene variabelen. Det kan ofte være nyttig når du har veldig mange variabler, slik at tabellen
#du får fra str() blir veldig uoversiktelig. 
```
  

* Finn, evt. lag, en factor-variabel. Hva er nivåene på dem?   Er de passende? Relevante?

Jeg tar denne oppgaven sammen med den siste i forrige, siden de i praksis spør om det samme. Det første vi må tenke over er hva slags informasjon vi kan få ut av en variabel. Numeriske variabler gjør det mulig å bruke matematiske funksjoner som f.eks. gjennomsnitt, standardavvik, m.m. Den ene variabelen vi nå har med tilsier hvilket parti de forskjellige respondentene stemte på, med 11 forskjellige tallverdier  (Hvilke partier de representerer står i en kodebok jeg glemte å legge ut, kommer med denne fasiten). La oss tenke oss at vi tar gjennomsnittet av disse, hvilken informasjon får vi ut av dette? Å bruke en slik skala vil kreve at vi kan sette verdiene på en skala, altså må 4 være større enn 2 (men ikke nødvendigvis dobbelt så stort, her kommer forskjellen på interval- og forholdsnivå inn). For partier gir dette åpenbart ikke mening, FrP er ikke dobbelt så mye et parti som Rødt. Når vi setter denne som factor-variabel sier vi at denne variabelen har flere verdier som er ulike hverandre, men ikke har noen skala-forskjell. Altså at verdiene er på nominal-nivå. Dette vil vi se er nyttig når vi senere skal se på regresjonsanalyser o.l. 


```r
# For å sette variabelen som en faktor bruker vi as.factor() funksjonen
NO8$partiSTEMT <- as.factor(NO8$partiSTEMT)
#Nå kan vi bruke funksjonen levels() for å se hvilke verdier variablen har. 
levels(NO8$partiSTEMT)
```

```
##  [1] "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10" "11"
```

```r
#Variabelen har altså et nivå for hvert parti. Dette er ganske passende for det vi ønsket å oppnå. 
```


* Se på en dikotom variabel. Hvordan tolker du den?

En dikotom variabel er en variabel som kun har to nivåer, ofte representert som 1/0 eller TRUE/FALSE. En slik variabel har ikke et målenivå, og vi kan derfor bruke den slik vi måtte ønske. I de variablene jeg har valgt ut er kjønn den som representerer dette. La oss først se på hvordan kjønn er kodet, dette kan vi gjøre med unique() funksjonen som viser de unike verdiene til variabelen. 


```r
unique(NO8$Gender)
```

```
## [1] 1 2
```

Her ser vi at variabelen har to verdier "1" og "2". I kodeboken kan vi lese at verdien 2 tilsvarer kvinner, og 1 menn. Det er ofte lettere å jobbe med 1/0 verdier, og jeg vil derfor først omgjøre verdiene til dette. 


```r
NO8$kjonn <-NO8$Gender -1 #Ved å trekke fra en blir nå kvinner 1, og 0 menn

# Det enkleste måten å tolke denne på er ved å ta gjennomsnittet. 
mean(NO8$kjonn)
```

```
## [1] 0.4627832
```

```r
#Her ser vi at vi får et gjennomsnitt på 0,46..
#Dette viser faktisk hvor mange i datasettet som er kvinner, altså
# er 46 % av respondentene kvinner. 
#Tar vi 1 gjennomsnittet, 
1- mean(NO8$kjonn)
```

```
## [1] 0.5372168
```

```r
#Får vi at 53 % er menn. 
```

* Lag et density-plot av en passende variabel. Hva forteller plottet deg?

Et density-plot viser fordelingen var verdier til en gitt variabel. Dette gjør at vi kan se hvorvidt en variabel f.eks. er normalfordelt, eller
veldig skjevfordelt. Her kan vi se på tyden folk bruker på nyheter. 


```r
ggplot(NO8, aes(tidNYHETER)) + #Først definerer jeg datasettet, og variabelen jeg vil se på 
  geom_density() + #Så legger jeg til hva slags type plot jeg vil ha
  theme_classic()+ #Så kan man legge til litt pynt med tittler, og temaer
  labs(title = "Antall minutter brukt på nyheter pr dag.",
       subtitle = "European Social Survey: Runde 8, Norge",
       y = " ",
       x = "Tid til nyheter i minutter") 
```

![](Fasit_2_files/figure-latex/unnamed-chunk-8-1.pdf)<!-- --> 



* Velg ut noen land, er det noen forskjell i stemmegivning? Vis dette ved et diagram 

Dette er en ganske vanskelig oppgave, så gratullerer om dere fikk den til! Her må vi nemlig først lage et datasett på en litt annerledes måte, så få en måte å representere stemmegivning på, og så plotte det hele. Her er det flere valg dere må ta, og en del kode vi ikke har vist som dere må finne ut av. 
Her kommer jeg til å vise prosenten som har stemt i 3 land. 




```r
#Det første vi må gjøre er å velge ut noen land for en enkel runde. Allerede her kommer det noe ny kode, siden vi ønsker å bruke | som betyr "or/eller" i tilegg til &. 

Stemme <- ESS %>%
  filter(Country == "NO" | Country == "DK" | Country == "SE" & essround == 8) %>% #Her sier jeg altså at Country er lik NO ELLER DK ELLER SE
  select(vote, Country) #Så kan jeg velte ut variablene, her er jeg kun innteresert i land og stemmegivning

#Om vi ser på "vote" variabelen ser vi at den er laget på samme måte kjønnsvariabelen, her med 2 = "Stemte ikke i sist valg." Altså kan vi gjøre det samme
#for å finne andelen som har stemt. Ved å ta 2 - variabelen isteden kan vi snu skalaen, slik at 1 betyr "stemte" 

Stemme$stemt <- 2- Stemme$vote 

#Her kommer nok den vanskeligste delen. For å få andelen som stemte ønsker vi å finne gjenomsnittet, men dette vil vi ha pr. land, og ikke for hele
#datasettet. Her må vå bruke to nye funksjoner "group_by" og "summarise()". Den første gjør at vi kan bruke en eller flere variabler for å si hvilke
#grupper som eksisterer i datasettet, og gjøre omregninger/funksjoner innad i gruppene. Den andre bruker en funksjon for å redusere/slå sammen rader. 
#Her ønsker vi å finne gjennomsnittet innad i landene, og så kun returnere gjennomsnittet. 

StemmeGjsnitt <- Stemme %>%
  group_by(Country) %>%
  summarise(Stemme = mean(stemt, na.rm = TRUE))

#Nå kan vi lage et bar-plot som viser andelen som stemte i sist valg for hvert land
# I tilegg vil jeg bruke pakken ggthemes for å få plottet litt finere
library(ggthemes)

ggplot(StemmeGjsnitt, aes(Country, Stemme)) +
  geom_col(fill = "green") +
  theme_economist() +
  scale_y_continuous(labels =  scales:: percent, limits = c(0,1)) +
  labs(y = "", x= "", title = "Stemmegivning i Skandinavia")
```

![](Fasit_2_files/figure-latex/unnamed-chunk-9-1.pdf)<!-- --> 

