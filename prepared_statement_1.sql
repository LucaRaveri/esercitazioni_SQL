USE uni_db;

SELECT * FROM Studenti;

-- Creare uno statement che mostri tutti gli studenti di un corso di laurea passato come parametro
PREPARE studenti_cdl FROM
"SELECT * 
FROM Studenti
WHERE matricola LIKE CONCAT(?, '%')";

SET @cdl = "IN05";
EXECUTE studenti_cdl USING @cdl;


