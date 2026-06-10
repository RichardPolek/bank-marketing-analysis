# Analýza bankovej marketingovej kampane

## O projekte
Analýza reálneho datasetu Bank Marketing (UCI Machine Learning Repository, 11 162 záznamov).
Cieľom bolo identifikovať, ktoré segmenty klientov majú najvyšší záujem o termínovaný vklad.

## Nástroje
- Microsoft Excel (kontingenčné tabuľky, grafy, dashboard)
- SQL (SQLite) — analytické dotazy, krížové analýzy, window funkcie
  
## Kľúčové zistenia
- Študenti (74,7%) a dôchodcovia (66,3%) majú najvyšší záujem o vklad
- Seniori 60+ sú najlepší vekový segment (76,9%)
- Blue-collar pracovníci reagujú najmenej (36,4%)
- Odporúčanie: optimálne segmenty sú retired a management — vysoké % aj veľká skupina

## Obsah repozitára
- `bank_data_analysis.xlsx` — Excel súbor s dashboardom, pivot tabuľkami a Data Quality Reportom

## Dátové zdroje
- Dataset pochádza z UCI Machine Learning Repository (Moro et al., 2014) a je voľne dostupný na akademické účely.
- [Originálny zdroj — UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/222/bank+marketing)
## Dashboard

![Dashboard](Dashboard.png)

## SQL analýza
Rovnaký dataset analyzovaný aj v SQL (SQLite). Dotazy idú za rámec Excelu —
napríklad kríženie profesie a veku v jednom dotaze odhalilo najsilnejší segment:
management 60+ s 85,3% mierou záujmu.

- `analyza.sql` — komentované SQL dotazy
- `vysledky.md` — výsledky s tabuľkami a interpretáciou
- `load_data.py` — načítanie dát do SQLite databázy
