\# Pizza Analytics



Projekt analityczny dotyczący sprzedaży Pizza Place, wykonany na podstawie danych sprzedażowych z platformy Maven Analytics.



Celem projektu była analiza wyników sprzedaży, identyfikacja najważniejszych trendów oraz przygotowanie interaktywnego dashboardu prezentującego kluczowe wyniki.





\## Cel projektu



Celem projektu było przeanalizowanie danych sprzedażowych Pizza Place oraz znalezienie informacji, które mogą pomóc w ocenie wyników sprzedaży i zachowań klientów.



W ramach projektu przeanalizowano m.in.:



\- całkowity przychód i liczbę zamówień

\- sprzedaż według miesięcy, kategorii i rozmiaru pizzy

\- najlepiej sprzedające się produkty

\- godziny o najwyższych przychodach

\- różnice między sprzedażą w dni robocze i weekendy





\## Wykorzystane technologie



\- SQL Server

\- SQL

\- Power BI

\- DAX

\- Power Query



## Źródło danych



Dane pochodzą z zestawu Pizza Place Sales udostępnionego przez Maven Analytics.



Projekt został wykonany na podstawie czterech tabel:



\- orders

\- order\_details

\- pizzas

\- pizza\_types



## Analiza SQL



Dane zostały zaimportowane do SQL Server, gdzie przeprowadzono analizę sprzedaży za pomocą zapytań SQL.



W ramach analizy wykorzystano m.in.:



\- agregowanie danych za pomocą SUM, COUNT i GROUP BY

\- filtrowanie i sortowanie wyników

\- łączenie tabel za pomocą JOIN

\- podzapytania

\- wyrażenia CASE WHEN

\- CTE

\- funkcje okna, m.in. ROW\_NUMBER()



## Analiza i wizualizacja w Power BI



Na podstawie przygotowanych danych utworzono interaktywny dashboard w Power BI.



Dashboard zawiera:



\- kluczowe wskaźniki sprzedaży: przychód, liczbę zamówień, liczbę sprzedanych pizz oraz średnią wartość zamówienia

\- analizę przychodów według miesięcy, kategorii i rozmiaru pizzy

\- ranking 10 najlepiej sprzedających się pizz według przychodu

\- filtry umożliwiające analizę danych według miesiąca i kategorii pizzy



## Kluczowe wnioski



\- Kategoria Classic wygenerowała najwyższy przychód spośród wszystkich kategorii — 220 053,10 USD

\- Lipiec był najlepszym miesiącem pod względem przychodu — 72 557,90 USD. Najsłabszym miesiącem był październik z wynikiem 64 027,60 USD, co wskazuje na stosunkowo stabilną sprzedaż w ciągu roku

\- Najwyższy przychód godzinowy odnotowano o 12:00 — 111 877,90 USD, a kolejną godziną była 13:00 z wynikiem 106 065,70 USD. Wskazuje to na wyraźny szczyt sprzedaży w porze obiadowej

\- Najlepiej sprzedającą się pojedynczą pizzą pod względem przychodu była Thai Chicken Pizza — 43 434,25 USD

\- Dni robocze odpowiadały za około 72,8% całkowitego przychodu, podczas gdy weekendy wygenerowały około 27,2%



## Struktura projektu



```text

PizzaAnalytics/

├── SQL/

│   └── PizzaAnalytics\_All\_Queries.sql

├── PowerBI/

│   └── PizzaAnalytics\_Dashboard.pbix

├── Images/

│   └── dashboard.png

└── README.md

```



## Podsumowanie



Projekt pozwolił przeanalizować dane sprzedażowe Pizza Place z wykorzystaniem SQL Server i Power BI, od przygotowania i analizy danych po stworzenie interaktywnego dashboardu oraz wyciągnięcie kluczowych wniosków biznesowych.

















