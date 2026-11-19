# E-Commerce & Marketing ROI Analytics Dashboard

## O projekcie
Projekt zrobiłem po to, żeby w praktyce połączyć dane sprzedażowe z marketingowymi i sprawdzić, jak wygląda opłacalność kampanii reklamowych. Chciałem przejść całą drogę – od postawienia bazy w chmurze aż po gotowy raport w Power BI. wszystkie dane wykorzystane w projekcie są w pełni syntetyczne na potrzeby tego ćwiczenia.

**Co tu jest zrobione:**
* **Baza w chmurze:** całość postawiłem na Azure SQL Database.
* **Łączenie dwóch różnych źródeł:** Spiąłem syntetyczne dane transakcyjne w stylu systemu ERP (zamówienia, przychody, statusy) z danymi stanowiącymi imitację zrzutu z Google Analytics (sesje, wydatki na kampanie w Google Ads i Meta). Nazwy narzędzi oraz skrót `GA` w bazie posłużyły mi do odwzorowania realnych struktur rynkowych.
* **Własne dane i symulacja scenariuszy:** przygotowałem własne struktury tabel i dane, żeby przetestować w praktyce działanie atrybucji po UTM-ach oraz ocenę opłacalności kampanii.
* **Model gwiazdy:** strukturę pod model gwiazdy (wymiary i fakty, m.in. `dim_customer`, `dim_campaign`, `dim_status`, `dim_traffic_source`) przygotowałem w SQL, a w Power BI spiąłem relacje.

## Widoki w Azure SQL
W bazie celowo postawiłem na tworzenie widoków (`CREATE VIEW`) zamiast tradycyjnych tabel. 

Wszystkie przekształcenia, łączenia tabel i przygotowanie danych pod raport działają na poziomie zapytań w silniku T-SQL:
* Zależało mi na odciążeniu samego Power BI i przekazaniu do niego gotowych, uporządkowanych zbiorów.
* Składnia T-SQL w tym projekcie wynikała z wymogów środowiska Azure SQL i traktowałem ją jako niezbędne narzędzie do zrealizowania celu, a nie chęć przestawiania się na nową składnię.

## Raport Power BI i wnioski z danych

<img width="1316" height="798" alt="relacje" src="https://github.com/user-attachments/assets/504fb6e0-d9d0-4e0b-9ef7-0c1c99bf9d8f" />
<br><br>

Raport podzieliłem na 3 strony, żeby przechodzić od ogólnego obrazu do konkretów:

1. **Sprzedaż (dane w stylu ERP):** przychody, liczba zamówień i podgląd statusów (żeby wyłapać anulacje).
   * *Zastosowane miary:*
```dax
Całkowity Przychód = 
SUM(fact_erp_sales[order_amount])
```
```dax
Liczba Zamówień = 
COUNTROWS(fact_erp_sales)
```
```dax
Średnia Wartość Zamówienia = 
AVERAGEX(fact_erp_sales, [Całkowity Przychód])
```
```dax
Wskaźnik Anulowań = 
VAR LiczbaZamowien = [Liczba Zamówień]
VAR ZamowieniaAnulowane = CALCULATE([Liczba Zamówień], dim_status[order_status] = "Anulowane")
RETURN
DIVIDE(ZamowieniaAnulowane, LiczbaZamowien, 0)
```

<img width="1316" height="743" alt="przeglad_biznesowy_erp" src="https://github.com/user-attachments/assets/cf450895-9e21-4913-8a9b-4220e0513635" />
<br><br>

2. **Ruch i sesje (imitacja Google Analytics):** wyniki ruchu, liczba sesji i źródła wizyt.
   * *Zastosowane miary:*
```dax
Łączna liczba sesji = 
CALCULATE(SUM(fact_ga_sessions[sessions_count]), USERELATIONSHIP(dim_date[Date], fact_ga_sessions[event_date]))
```
```dax
Łączny koszt reklam = 
CALCULATE(SUM(fact_ga_sessions[ad_cost_pln]), USERELATIONSHIP(dim_date[Date], fact_ga_sessions[event_date]))
```
```dax
Średni koszt za sesję = 
DIVIDE([Łączny koszt reklam], [Łączna liczba sesji], 0)
```

<img width="1315" height="747" alt="analiza_aktywnosci_i_ruchu_ga" src="https://github.com/user-attachments/assets/05a1ac75-d048-44c1-9ea8-839260249cce" />
<br><br>

3. **Wyniki i opłacalność kampanii (ROI):** zestawienie wydatków na reklamy z przychodem.
   * *Zastosowane miary:*
```dax
Zwrot z nakładów na reklamę = 
DIVIDE([Całkowity Przychód], [Łączny koszt reklam], 0)
```
```dax
Zysk netto kampanii = 
[Całkowity Przychód] - [Łączny koszt reklam]
```
```dax
Średni koszt zdobycia zamówienia = 
DIVIDE([Łączny koszt reklam], [Liczba Zamówień], 0)
```
```dax
Wskaźnik Konwersji = 
DIVIDE([Liczba Zamówień], [Łączna liczba sesji], 0)
```

<img width="1314" height="746" alt="erp_+_ga" src="https://github.com/user-attachments/assets/5f33c196-6c49-4042-ac77-07a733a9c98e" />



## Podsumowanie i wnioski biznesowe
* Dane pokazały spore przepalenie budżetu marketingowego – w ogólnym rozrachunku bilans wyszedł ponad 15 tysięcy złotych na minusie.
* Średni koszt zdobycia zamówienia wyniósł około 1190 zł. Przy takiej skali kosztów pozyskania i niskiej efektywności działań wygląda na to, że zabrakło tu precyzyjnego targetowania (np. po geolokalizacji czy słów kluczowych), a decyzje budżetowe były podejmowane bez przełożenia na zwrot.

W repozytorium znajdują się również załączone pliki `.sql` ze skryptami.
