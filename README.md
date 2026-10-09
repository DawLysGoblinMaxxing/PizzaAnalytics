# Pizza Analytics

Projekt analizy sprzedaży Pizza Place wykonany z wykorzystaniem SQL Server i Power BI. Pracowałem na zbiorze danych z Maven Analytics, żeby sprawdzić, jak wygląda sprzedaż w różnych okresach, które produkty przynoszą największy przychód i kiedy pizzeria osiąga najlepsze wyniki.

## Cel projektu

Celem projektu było przeanalizowanie danych sprzedażowych i sprawdzenie, jakie informacje można z nich wyciągnąć. W projekcie skupiłem się głównie na przychodach, popularności produktów i zmianach sprzedaży w ciągu dnia oraz roku

W analizie sprawdziłem:

* całkowity przychód i liczbę zamówień,
* sprzedaż w poszczególnych miesiącach,
* wyniki według kategorii i rozmiarów pizzy,
* najlepiej sprzedające się produkty,
* godziny z najwyższymi przychodami,
* udział dni roboczych i weekendów w całkowitej sprzedaży.

## Wykorzystane technologie

* SQL Server
* SQL
* Power BI
* DAX
* Power Query

## Dane

Wykorzystałem zbiór Pizza Place Sales udostępniony przez Maven Analytics. Dane obejmowały cztery tabele: `orders`, `order_details`, `pizzas` i `pizza_types`.

## Analiza w SQL

Dane zaimportowałem do SQL Server, gdzie przygotowałem zapytania pozwalające przeanalizować poszczególne aspekty sprzedaży.

W praktyce wykorzystałem m.in.:

* `SUM`, `COUNT` i `GROUP BY` do obliczania wyników sprzedaży,
* `JOIN` do łączenia informacji z kilku tabel,
* filtrowanie i sortowanie danych,
* podzapytania i `CASE WHEN`,
* CTE do organizowania bardziej rozbudowanych zapytań,
* funkcje okna, w tym `ROW_NUMBER()`, do analizy i porządkowania wyników.

## Dashboard w Power BI

Po przygotowaniu danych, na ich podstawie stworzyłem interaktywny dashboard pozwalający szybko sprawdzić najważniejsze wyniki i porównać sprzedaż w różnych kategoriach.

Znalazły się w nim:

* KPI: całkowity przychód, liczba zamówień, liczba sprzedanych pizz i średnia wartość zamówienia,
* przychody w podziale na miesiące, kategorie i rozmiary pizzy,
* ranking 10 pizz generujących najwyższy przychód,
* filtry pozwalające analizować wybrane miesiące i kategorie.

## Najważniejsze wnioski

* **Classic** była kategorią z najwyższym przychodem, wynoszącym 220 053,10 USD.
* Najlepszym miesiącem pod względem przychodu był lipiec z wynikiem 72 557,90 USD, a najsłabszym październik z 64 027,60 USD.
* Największą sprzedaż odnotowano o 12:00 (111 877,90 USD), a następnie o 13:00 (106 065,70 USD). Najwyższe przychody przypadały zatem na godziny obiadowe.
* Thai Chicken Pizza osiągnęła najwyższy przychód spośród wszystkich rodzajów pizzy tj. 43 434,25 USD.
* Dni robocze odpowiadały za około 72,8% przychodu natomiast weekendy za pozostałe 27,2%.

## Struktura projektu

```text
PizzaAnalytics/
├── SQL/
│   └── PizzaAnalytics_All_Queries.sql
├── PowerBI/
│   └── PizzaAnalytics_Dashboard.pbix
├── Images/
│   └── dashboard.png
└── README.md
```

## Podsumowanie

W tym projekcie udało mi się przejść przez cały proces analizy danych. Od poprawy formatu tabel do przygotowania zapytań query aż po przygotowanie dashboardu i wyciągnięcie wniosków.

















