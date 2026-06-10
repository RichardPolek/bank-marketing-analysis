# Analýza bankovej marketingovej kampane

## O projekte
Analýza reálneho datasetu Bank Marketing (UCI Machine Learning Repository, 11 162 záznamov). Chcel som zistiť, ktoré segmenty klientov majú najvyšší záujem o termínovaný vklad a kam by sa banke oplatilo cieliť kampaň.

## Nástroje
- Microsoft Excel (kontingenčné tabuľky, grafy, dashboard)
- SQL (SQLite): analytické dotazy, krížové analýzy, window funkcie

## Kľúčové zistenia
- Najvyšší záujem o vklad majú študenti (74,7 %) a dôchodcovia (66,3 %)
- Z pohľadu veku sú najlepší segment seniori 60+ (76,9 %)
- Blue-collar pracovníci reagujú najmenej (36,4 %)
- Odporúčanie: najlepšie segmenty pre kampaň sú retired a management, keďže majú vysoké % aj dostatočnú veľkosť skupiny

## Obsah repozitára
- `bank_data_analysis.xlsx`: Excel súbor s dashboardom, pivot tabuľkami a Data Quality Reportom

## Dátové zdroje
- Dataset pochádza z UCI Machine Learning Repository (Moro et al., 2014) a je voľne dostupný na akademické účely.
- [Originálny zdroj: UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/222/bank+marketing)

## Dashboard
![Dashboard](Dashboard.png)

## SQL analýza
Ten istý dataset som analyzoval aj v SQL (SQLite). Niektoré dotazy idú za rámec toho, čo som robil v Exceli. Napríklad kríženie profesie a veku v jednom dotaze odhalilo najsilnejší segment: management 60+ s mierou záujmu 85,3 %.

- `analyza.sql`: komentované SQL dotazy
- `vysledky.md`: výsledky s tabuľkami a interpretáciou
- `load_data.py`: načítanie dát do SQLite databázy
