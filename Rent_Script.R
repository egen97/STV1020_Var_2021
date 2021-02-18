 
#Hvis jeg kjører kode her, vil dere se resultatene som vanlig tekst under. Vi kan jo gjøre et lite forsøk
# med noe enkel matte! For å kjøre koden setter dere musen ved siden av, og trykker ctrl+enter. 
100/2+4


#Her ønsker jeg å lage et objekt. I første omgang kan vi prøve å lage en vektor. Dette er et objekt
#som inneholder flere elementer, f.eks. tall av samme klasse. La oss først prøve å lage en med ett
#tall. For å gjøre dette må vi først velge et navn, så bruke det som heter en "assigner", og så
#skrive hva den skal inneholde. Her lager jeg en vektor som heter "To" og som inneholder tallet 2. 
To <- 2
# <- er det som er assigneren. Den sier bare at det som kommer på venstresiden skal lagres med 
#navnet som er på høyresiden. Om dere kjører koden (ctrl+enter med musen ved siden av, eller
#teksten markert) vil dere se i envoirnment at det kommer en linje hvor det står "To   2", dette
#betyr at vi har laget en variabel med navn To som inneholder verdien 2. 
#Nå som vi har et objekt kan vi begynne å bruke det til noe. Først kan vi prøve å gjøre matte igjen:
2 + To 


#Som dere ser kan jeg nå skrive 2 + To og få ut resultatet fire. Når vi nå skriver "To" vet R at vi
# *egentlig* mener tallet 2. For så enkle ting som dette er sikkert enklere å bare skrive 2, eller
#bare bruke en kalkulator for den saks skyld. Det fine med objekter er at de kan inneholde veldig mye
#informasjon! I første omgang kan vi prøve å lagre flere tall. Det er flere måter vi kan gjøre dette
#på, f.eks. kan vi skrive 1:10 for å få alle heltallene mellom 1 og 10, eller skrive c(1,22,5,2,1) for
#å lage en rekke tall. I det siste skiller jeg tallene med komma. Objektene kan hete hva du vil forøvrig. 
Hva_Du_Vil <- 1:100
Forovrig <- c(1,4,56,8,4,2,4)
#Eneste er at du ikke kan ha mellomrom i navnene eller tall som første tegn, og det er god kutyme å unnå
#æ/ø/å generelt i script.
#Nå som vi har et script med flere elementer kan vi prøve å kjøre noen funksjoner på dem
#Det kan nevnes at funksjoner faktisk er objekter de og, men det blir først innteresant når du holder
#på med litt mer avansert kode. La oss se om vi kan finne gjennomsnittet av disse vektorene. 
mean(Forovrig)
mean(Hva_Du_Vil)

#La oss si at vi vil ha element nr. 5 i vektoren Forovrig.
Forovrig[5] #Når vi kjører denne ser vi at vi får ut tallet 5,
#og dette kan vi jo også sjekke i envorement for å se at stemmer. 

#På samme måte som vi definerte en rekke tall istad, kan vi også bruke dette
#for å få ut en rekke elementer. 

Forovrig[3:6]
Forovrig[c(3,5,3,6)]
#Her kan vi også finne gjennomsnittet av kun disse tallene
mean(Forovrig[c(3,5,3,6)])
#Eller bruke disse som en ny vekter
Ny_Vektor <- Forovrig[c(3,5,3,6)]


#For å sjekke om noe er numeric kan vi bruke funksjonen is.numeric()

is.numeric(Hva_Du_Vil)
#Her ser vi at vi får opp "TRUE" som betyr at Hva_Du_Vil er et numerisk objekt


Tekst <- "Hei, jeg elsker R! <3"
#Denne klassen kan inneholde tekst, men vil f.eks. ikke kunne brukes til matte. 
mean(Tekst)
#Her ser dere at vi får en feilmelding, som sier at argumentet ikke er
#numerisk eller logisk. Funksjonen gir oss derfor resultatet NA, som
#betyr missing, altså at det ikke eksisterer et resultat. 

#Vi kan også kreve at et objekt skal ha en viss klasse. Det gjør vi med
#as. "klassenavn". Det kan føre til noen uforventede resultater. Si hvis gjør
#Forovrig om til character. 
Forovrig <- as.character(Forovrig)
mean(Forovrig)


Skolenivaer <- factor(c("Barneskole", "Ungdomskole", "Videregaende", "Videregaende", "Ungdomskole"),
                      levels = c("Barneskole", "Ungdomskole", "Videregaende"))

#Her kan vi se at vi først definerer de forskjellige verdiene som er i variabelen
#Så skriver vi hvilke nivåer den kan ha, i den rekkefølgen vi ønsker dem
#Om vi ikke hadde definert nivåene ville R gjort det automatisk i alfabetisk
#rekkefølge, som oftest går det greit men noen ganger ønsker vi det annerledes
#Nå kan vi først se på hva som er i variabelen
Skolenivaer #Kjører vi bare denne ser vi alle verdiene



#Nå kan vi lage et objekt som inneholder både tekst og tall:
TekstTall <- c(1,4,0,4, "Bamse", "R", "R Seminarer er de BESTE seminarer", 42, "the answer")
#Nå kan vi bruke funksjonen "class()" for å se hvilken klasse dette nye objektet har
class(TekstTall)


Navn <- c("Arne", "Geir", "Hans", "Kleopatra", "Mari", "Gunnar", "Kalle")
Alder <- c(60, 45, 19, 19, NA, 87, 92)
Fylke <- c("Telemark", "Finnmark", "Buskerud", NA, "Hordaland", "Vestfold", "Trøndelag" )
By <- c("Skien", "karasjok", "Kongsberg", NA, "Dale", "Stokke", "Trondhjem")
#Her lager jeg først et sett med vektorer, med litt forskjellig informasjon.
#Dere kan se i envoirnment at alle har en lengde på 7. Dette kan vi også sjekke med
#length() funksjonen. 
length(Navn)

#For å lage en data.frame kan vi bruke funksjones as.data.frame()

Personer <- data.frame(Navn, Alder, Fylke, By)


#Før har vi kun skrevet navnet på vektoren. Nå som vi har det i en dataframe, må vi først
#velge denne, og så kolonnen. Det er to måter vi kan gjøre dette på:
Personer[2,1] #Med klammeparanteser kan vi velge rad og kolonne. Rad kommer først, og så kolonnen. 
Personer[,2] #Skriver vi en tom får vi alle kollonene/radene 
Personer[2,]
#Noen ganger er det ønskelig å velge ut noen grupper i datasettet. 
#Samtidig blir det fort vanskelig å huske tallet til plasseringen,
#neste gang skal vi derfor se på noen lettere måter å gjøre dette på. 

#En mer vanlig måte å hente ut kolonner på er med '$'.
Personer$Alder #Her skriver jeg først navnet på dataframen, og så variabelen
#Som dere ser får jeg ut verdien på alle aldrene

#Her kan vi bruke mattematiske formler på samme måte som istad.
#La oss prøve å få ut gjennomsnitt og alder på personene. 

mean(Personer$Alder)



mean(Personer$Alder, na.rm = TRUE) #Her ser dere at vi får svaret 52.5 istedet.
#na.rm betyr NA remove, og når vi setter den til TRUE ber R
#om å fjerne disse NA. 


#Eller median for å finne median
median(Personer$Alder, na.rm = TRUE)

#En lettere måte å få ut alle disse på er ved å bruke summary() funksjonen.
#Da trenger vi heller ikke bruke na.rm, fordi den heller sier hvor mange NA 
#det er i vektoren

summary(Personer$Alder)



install.packages("tidyverse")
#For å innstalere bruker vi funksjonen install.packages, og skriver navnet på
#pakken i parantesene med hermetegn


#For å gjøre dette bruker vi funksjonen library()
library("tidyverse")


#For å lage en figur starter vi alltid med å definere datasettet, og kan velge
#å definere variabler

ggplot(Personer, aes((Alder))) + #Første argument er navnet på datasettet, så skriver jeg aes()
  #som står for aesthetic. Der kan vi skrive navnet på variabelen
  #Jeg skriver også en + fordi jeg skal legge til mer på neste linje
  geom_histogram() #Her velger jeg hva slags type plott jeg vil ha, denne gangen et histogram
