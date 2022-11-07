USE uni_db;

-- Quanti sono i ragazzi iscritti ad Ingegneria?
SELECT COUNT(cf) AS Count_M
FROM Studenti
WHERE matricola LIKE 'IN%' AND genere = 'M';

-- Quante sono le ragazze iscritte ad ingegneria?
SELECT COUNT(cf) AS Count_F
FROM Studenti
WHERE matricola LIKE 'IN%' AND genere = 'F';

-- Quanti studenti hanno preso una lode negli esami del prof. De Lorenzo?
SELECT COUNT(DISTINCT Esami.studente) AS studenti_lode_delor
FROM Esami 
INNER JOIN Corsi
ON Corsi.codice = Esami.corso
INNER JOIN Professori
ON  Corsi.professore = Professori.matricola
WHERE Professori.cognome = "De Lorenzo" AND Esami.lode = TRUE;

-- Chi sono gli studenti che hanno passato l'esame di Programmazione Web e che si chiamano Luca?
SELECT Studenti.nome, Studenti.cognome, Esami.voto, Corsi.nome
FROM Esami
INNER JOIN Corsi
ON Corsi.codice = Esami.corso
INNER JOIN Studenti
ON Studenti.matricola = Esami.studente
WHERE Corsi.nome = "Programmazione web" AND Studenti.nome = "Luca"
ORDER BY Esami.voto DESC;

-- Quali studenti hanno preso una lode con il prof. De Lorenzo?
SELECT Studenti.nome, Studenti.cognome, Esami.voto, Esami.lode, Corsi.nome
FROM Esami
INNER JOIN Corsi
ON Corsi.codice = Esami.corso
INNER JOIN Studenti
ON Studenti.matricola = Esami.studente
INNER JOIN Professori
ON  Corsi.professore = Professori.matricola
WHERE Professori.cognome = "De Lorenzo" AND Esami.lode = TRUE;

-- Quali studenti hanno preso più di una lode con il prof. De Lorenzo?
SELECT Studenti.nome, Studenti.cognome
FROM Esami
INNER JOIN Corsi
ON Corsi.codice = Esami.corso
INNER JOIN Studenti
ON Studenti.matricola = Esami.studente
INNER JOIN Professori
ON  Corsi.professore = Professori.matricola
WHERE Professori.cognome = "De Lorenzo" AND Esami.lode = TRUE
GROUP BY Esami.studente
HAVING COUNT(Esami.lode) >=2;
