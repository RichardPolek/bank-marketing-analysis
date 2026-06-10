# Analýza Bank Marketing datasetu

Databáza: `bank.db`, tabuľka `clients` (11 162 riadkov).
Cieľ: zistiť, ktoré skupiny klientov najčastejšie súhlasia s termínovaným vkladom (`deposit = 'yes'`).

---

## Dotaz 1: Ktoré profesie majú najvyšší záujem o termínovaný vklad?

```sql
SELECT job,
       COUNT(*) AS spolu,
       SUM(CASE WHEN deposit='yes' THEN 1 ELSE 0 END) AS ano,
       ROUND(100.0 * SUM(CASE WHEN deposit='yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS percento_ano
FROM clients
GROUP BY job
ORDER BY percento_ano DESC;
```

| job | spolu | ano | percento_ano |
|---|---:|---:|---:|
| student | 360 | 269 | 74.7 |
| retired | 778 | 516 | 66.3 |
| unemployed | 357 | 202 | 56.6 |
| management | 2566 | 1301 | 50.7 |
| unknown | 70 | 34 | 48.6 |
| admin. | 1334 | 631 | 47.3 |
| self-employed | 405 | 187 | 46.2 |
| technician | 1823 | 840 | 46.1 |
| services | 923 | 369 | 40.0 |
| housemaid | 274 | 109 | 39.8 |
| entrepreneur | 328 | 123 | 37.5 |
| blue-collar | 1944 | 708 | 36.4 |

**Záver:** Najvyššiu úspešnosť majú študenti (74,7 %) a dôchodcovia (66,3 %), teda skupiny mimo aktívneho pracovného pomeru. Najnižšiu blue-collar (36,4 %), ktorá je zároveň druhá najpočetnejšia.

---

## Dotaz 2: Ktoré kombinácie profesie a vekovej skupiny sú najochotnejšie?

Malé skupiny (pod 50 klientov) sú odfiltrované cez `HAVING`, aby percentá boli štatisticky spoľahlivé.

```sql
SELECT job,
       CASE
         WHEN age < 30 THEN 'do 30'
         WHEN age < 40 THEN '30-39'
         WHEN age < 50 THEN '40-49'
         WHEN age < 60 THEN '50-59'
         ELSE '60+'
       END AS vekova_skupina,
       COUNT(*) AS spolu,
       ROUND(100.0 * SUM(CASE WHEN deposit='yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS percento_ano
FROM clients
GROUP BY job, vekova_skupina
HAVING COUNT(*) >= 50
ORDER BY percento_ano DESC
LIMIT 15;
```

| job | vekova_skupina | spolu | percento_ano |
|---|---|---:|---:|
| management | 60+ | 75 | 85.3 |
| retired | 60+ | 526 | 77.9 |
| student | do 30 | 289 | 76.5 |
| student | 30-39 | 65 | 69.2 |
| management | do 30 | 262 | 66.4 |
| self-employed | do 30 | 64 | 62.5 |
| technician | do 30 | 223 | 59.2 |
| unemployed | 50-59 | 76 | 57.9 |
| unemployed | 30-39 | 122 | 56.6 |
| admin. | do 30 | 205 | 54.1 |
| technician | 50-59 | 264 | 50.0 |
| unemployed | 40-49 | 108 | 50.0 |
| management | 30-39 | 1183 | 49.6 |
| management | 40-49 | 596 | 47.8 |
| services | do 30 | 151 | 47.7 |

**Záver:** Vek je silnejší signál než povolanie. Najochotnejšie sú krajné vekové kategórie: mladí do 30 a ľudia 60+ (manažéri 60+ až 85,3 %). Stredný produktívny vek (30–49) má pri zamestnaných profesiách úspešnosť pod 50 %.

---

## Dotaz 3: Súvisí výška priemerného zostatku s ochotou vložiť vklad?

```sql
SELECT job,
       ROUND(AVG(balance), 0) AS priemerny_zostatok,
       ROUND(100.0 * SUM(CASE WHEN deposit='yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS percento_ano,
       RANK() OVER (ORDER BY AVG(balance) DESC) AS poradie_podla_zostatku
FROM clients
GROUP BY job
ORDER BY priemerny_zostatok DESC;
```

| job | priemerny_zostatok | percento_ano | poradie_podla_zostatku |
|---|---:|---:|---:|
| retired | 2417 | 66.3 | 1 |
| unknown | 1945 | 48.6 | 2 |
| self-employed | 1865 | 46.2 | 3 |
| management | 1794 | 50.7 | 4 |
| entrepreneur | 1622 | 37.5 | 5 |
| technician | 1556 | 46.1 | 6 |
| student | 1501 | 74.7 | 7 |
| housemaid | 1366 | 39.8 | 8 |
| unemployed | 1315 | 56.6 | 9 |
| blue-collar | 1204 | 36.4 | 10 |
| admin. | 1196 | 47.3 | 11 |
| services | 1081 | 40.0 | 12 |

**Záver:** Vyšší zostatok automaticky neznamená vyššiu ochotu. Študenti sú až 7. podľa zostatku, ale majú najvyššiu úspešnosť (74,7 %); podnikatelia sú 5. najbohatší, ale druhí najmenej ochotní (37,5 %). Dôchodcovia vedú v oboch ukazovateľoch, z marketingového pohľadu je to ideálny segment.
