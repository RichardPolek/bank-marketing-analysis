-- ============================================================
-- Analyza Bank Marketing datasetu (bank.db, tabulka clients)
-- ============================================================

-- Dotaz 1: Ktore profesie maju najvyssi zaujem o terminovany vklad?
-- Pre kazde povolanie spocita pocet klientov, pocet suhlasov (deposit='yes')
-- a percentualnu uspesnost, zoradene od najuspesnejsich.
SELECT job,
       COUNT(*) AS spolu,
       SUM(CASE WHEN deposit='yes' THEN 1 ELSE 0 END) AS ano,
       ROUND(100.0 * SUM(CASE WHEN deposit='yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS percento_ano
FROM clients
GROUP BY job
ORDER BY percento_ano DESC;

-- Dotaz 2: Ktore kombinacie profesie a vekovej skupiny su najochotnejsie?
-- Krizi povolanie s vekovymi skupinami (CASE), male skupiny pod 50 klientov
-- odfiltruje cez HAVING, aby percenta boli statisticky spolahlive.
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

-- Dotaz 3: Suvisi vyska priemerneho zostatku s ochotou vlozit vklad?
-- Pre kazde povolanie ukaze priemerny zostatok, uspesnost a poradie
-- podla zostatku (window funkcia RANK nad agregatom AVG).
SELECT job,
       ROUND(AVG(balance), 0) AS priemerny_zostatok,
       ROUND(100.0 * SUM(CASE WHEN deposit='yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS percento_ano,
       RANK() OVER (ORDER BY AVG(balance) DESC) AS poradie_podla_zostatku
FROM clients
GROUP BY job
ORDER BY priemerny_zostatok DESC;
