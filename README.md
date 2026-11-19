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



2. **Ruch i sesje (imitacja Google Analytics):** wyniki ruchu, liczba sesji i źródła wizyt.
   * *Zastosowane miary:*

3. **Wyniki i opłacalność kampanii (ROI):** zestawienie wydatków na reklamy z przychodem.
   * *Zastosowane miary:*


## Podsumowanie i wnioski biznesowe
* Dane pokazały spore przepalenie budżetu marketingowego – w ogólnym rozrachunku bilans wyszedł ponad 15 tysięcy złotych na minusie.
* Średni koszt zdobycia zamówienia wyniósł około 1190 zł. Przy takiej skali kosztów pozyskania i niskiej efektywności działań wygląda na to, że zabrakło tu precyzyjnego targetowania (np. po geolokalizacji czy słów kluczowych), a decyzje budżetowe były podejmowane bez przełożenia na zwrot.

W repozytorium znajdują się również załączone pliki `.sql` ze skryptami.
