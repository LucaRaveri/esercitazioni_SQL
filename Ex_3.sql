USE uni_db;

-- Quali prof. hanno una media voti più bassa del normale agli esami?

-- Professori e media
SELECT Professori.nome, Professori.cognome, AVG(Esami.voto) AS media
FROM Professori
INNER JOIN Corsi
ON Corsi.professore = Professori.matricola
INNER JOIN Esami
ON Esami.corso = Corsi.codice
GROUP BY Professori.matricola
ORDER BY media ASC;

-- Media totale
SELECT AVG(voto)
FROM Esami;

-- Quali prof. hanno una media voti più bassa del normale agli esami?
SELECT Professori.nome, Professori.cognome, AVG(Esami.voto) AS media
FROM Professori
INNER JOIN Corsi
ON Corsi.professore = Professori.matricola
INNER JOIN Esami
ON Esami.corso = Corsi.codice
GROUP BY Professori.matricola
HAVING media < (SELECT AVG(voto) FROM Esami)
ORDER BY media ASC;

-- Quanti esami sono stati svolti per ciascun anno? E per ciascun mese dell’anno?

-- Esami all'anno
SELECT YEAR(data) as anno, COUNT(*)
FROM Esami
GROUP BY anno
ORDER BY anno DESC;

-- Esami al mese
SELECT MONTH(data) AS mese, COUNT(*)
FROM Esami
GROUP BY mese
ORDER BY mese;

-- Ci sono casi di omonimia (nome e cognome uguale) tra studenti e/o professori?

-- Omonimia fra studenti
SELECT nome, cognome, COUNT(*) AS conteggio
FROM Studenti
GROUP BY nome, cognome
ORDER BY conteggio DESC;

-- Omonimia fra studenti e/o professori
SELECT nome, cognome, COUNT(*) AS conteggio
FROM ( SELECT nome, cognome
FROM Studenti
UNION ALL
SELECT nome, cognome 
FROM Professori) AS tabella
GROUP BY nome, cognome
ORDER BY conteggio DESC;

-- Quanti studenti e professori ci sono con lo stesso nome? (es. 9 persone si chiamano Luca, 11 si chiamano Matteo, ...)
SELECT nome, COUNT(*) AS conteggio
FROM ( SELECT nome
FROM Studenti
UNION ALL
SELECT nome
FROM Professori) AS tabella
GROUP BY nome
ORDER BY conteggio DESC;










