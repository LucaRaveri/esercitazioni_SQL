USE uni_db;

-- Studenti / lodi
SELECT Studenti.nome, Studenti.cognome, Esami.corso, Esami.lode
FROM Esami
INNER JOIN Studenti
ON Studenti.matricola = Esami.studente
ORDER BY Studenti.nome ASC;

-- Quali studenti non hanno mai preso una lode?
SELECT Studenti.nome, Studenti.cognome
FROM Studenti
WHERE NOT EXISTS ( 
	SELECT * 
    FROM Esami
    WHERE Esami.lode = TRUE AND
    Esami.studente = Studenti.matricola
    )
ORDER BY Studenti.cognome ASC;

-- Studenti che hanno almeno un esame con lode
SELECT Studenti.nome, Studenti.cognome
FROM Esami
INNER JOIN Studenti
ON Esami.studente = Studenti.matricola
WHERE Esami.lode = TRUE
GROUP BY Esami.studente
ORDER BY Studenti.nome ASC;

-- Studenti che hanno almeno un esame con lode
SELECT Esami.studente
FROM Esami
WHERE Esami.lode = TRUE
GROUP BY Esami.studente;

-- Quali studenti non hanno mai preso una lode?
SELECT Studenti.nome, Studenti.cognome
FROM Esami
INNER JOIN Studenti
ON Esami.studente = Studenti.matricola
WHERE Esami.studente NOT IN (
	SELECT Esami.studente
	FROM Esami
	WHERE Esami.lode = TRUE
	GROUP BY Esami.studente
)
GROUP BY Esami.studente
ORDER BY Studenti.cognome ASC;

-- Quali studenti non hanno mai preso una lode?
SELECT *
FROM Studenti
WHERE Studenti.matricola NOT IN (
	SELECT Esami.studente
    FROM Esami
    WHERE Esami.lode = TRUE
)
ORDER BY Studenti.cognome ASC;

-- Quali docenti svolgono un monte ore annuo minore di 120 ore?
-- Quali docenti hanno corsi per un totale di < 15 CFU?
SELECT Professori.nome, Professori.cognome
FROM Professori
INNER JOIN Corsi
ON Corsi.professore = Professori.matricola
GROUP BY Professori.matricola
HAVING SUM(Corsi.cfu) < 15
ORDER BY Professori.cognome ASC;

-- Quali docenti svolgono un monte ore annuo minore di 120 ore?
SELECT Professori.nome, Professori.cognome, SUM(8*Corsi.cfu) AS monte_ore
FROM Professori
INNER JOIN Corsi
ON Corsi.professore = Professori.matricola
GROUP BY Professori.matricola
HAVING monte_ore < 120
ORDER BY Professori.cognome ASC;

-- Qual `e la media ponderata di ogni studente?
-- la media ponderata si calcola moltiplicando il voto dell’esame per il suo peso in cfu, sommando, e poi dividendo per il numero di cfu
-- SUM(Esami.voto *Corsi.cfu)/SUM(Corsi.cfu) as media
SELECT Studenti.nome, Studenti.cognome, SUM(Esami.voto*Corsi.cfu)/SUM(Corsi.cfu) as media, COUNT(Esami.studente) AS numero_esami
FROM Studenti
INNER JOIN Esami
ON Esami.studente = Studenti.matricola
INNER JOIN Corsi
ON Esami.corso = Corsi.codice
GROUP BY Esami.studente
ORDER BY media DESC;
