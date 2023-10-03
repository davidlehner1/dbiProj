-- nächster freier Termin für spezifischen Doctor (doctorid). Wenn null, dann gibt es heute noch keinen Termin
SELECT MIN(t.datum) AS next_available_date, (MIN(t.uhrzeit) + NUMTODSINTERVAL(t.dauer, 'MINUTE')) AS next_available_time
FROM termin t
WHERE t.arztfk = :inser_doctorId
AND (t.datum > CURRENT_DATE OR (t.datum = CURRENT_DATE AND t.uhrzeit > CURRENT_TIMESTAMP))
GROUP BY t.dauer;

-- get sum of prices of recipes per patient. Put svn in ' '
SELECT SUM(preis) AS total_cost
FROM rezept
WHERE patientfk = :insert_svn;

--- patientenliste pro Tag im format: 'yyyy-mm-dd'
SELECT p.svn, p.vname, p.nname, t.datum, t.uhrzeit
FROM patient p
INNER JOIN termin t ON p.svn = t.patientfk
WHERE t.datum = TO_DATE(:dateInput, 'yyyy-mm-dd');

--- ist ein Termin noch an bestimmten tag / Zeit bei bestimmten Doktor noch frei. Tag im format: 'yyyy-mm-dd' Zeit im Format: HH:MI:SS
SELECT CASE WHEN COUNT(*) = 0 THEN 'Ja' ELSE 'Nein' END AS availability
FROM termin t
WHERE t.arztfk = :doctorIdInput AND t.datum = TO_DATE(:dateInput, 'yyyy-mm-dd') AND t.uhrzeit = TO_TIMESTAMP(:timeInput, 'HH24:MI:SS');


--- bekomme die Anzahl der Krankheiten pro Monat
SELECT TO_CHAR(t.datum, 'YYYY-MM') AS month_year, d.name AS diagnosis, COUNT(*) AS diagnosis_count
FROM termin t
INNER JOIN diagnose d ON t.terminid = d.terminfk
WHERE t.datum >= ADD_MONTHS(CURRENT_DATE, -12)
GROUP BY TO_CHAR(t.datum, 'YYYY-MM'), d.name
ORDER BY month_year, d.name;


--- durchschnittliche Behandlungszeit
SELECT AVG(t.dauer) AS average_treatment_time
FROM termin t;

