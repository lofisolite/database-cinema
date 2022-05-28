-- Création base de données cinema.
CREATE DATABASE cinema CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;

-- Positionnement sur la BDD cinema.
use cinema;

-- Création des tables.
CREATE TABLE complex(
	id SMALLINT AUTO_INCREMENT NOT NULL,
	name VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	PRIMARY KEY(id)
) ENGINE = InnoDB ;


CREATE TABLE room(
	id SMALLINT AUTO_INCREMENT NOT NULL,
	room_number TINYINT NOT NULL,
	number_seat SMALLINT NOT NULL,
	id_complex SMALLINT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY(id_complex) REFERENCES complex(id)
) ENGINE = InnoDB ;

CREATE TABLE movie(
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(100) NOT NULL,
	duration TIME NOT NULL,
	director VARCHAR(100) NOT NULL,
	genre VARCHAR(25) NOT NULL,
	PRIMARY KEY(id)
) ENGINE = InnoDB ;

CREATE TABLE film_show(
	id INT AUTO_INCREMENT NOT NULL,
	date DATE NOT NULL,
	seat_reserved SMALLINT DEFAULT 0,
	start_time TIME NOT NULL,
	end_time TIME NOT NULL,
	id_complex SMALLINT NOT NULL,
	id_room SMALLINT NOT NULL,
	id_movie INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(id_complex) REFERENCES complex(id),
	FOREIGN KEY(id_room) REFERENCES room(id),
	FOREIGN KEY(id_movie) REFERENCES movie(id)
) ENGINE = InnoDB ;

CREATE TABLE admin(
	id INT AUTO_INCREMENT NOT NULL,
	firstname VARCHAR(100) NOT NULL,
	lastname VARCHAR(100) NOT NULL,
	role VARCHAR(11) NOT NULL,
	PRIMARY KEY(id)
) ENGINE = InnoDB ;

CREATE TABLE complex_management(
	id_complex SMALLINT NOT NULL,
	id_admin INT NOT NULL,
	PRIMARY KEY(id_complex, id_admin),
	FOREIGN KEY(id_complex) REFERENCES complex(id),
	FOREIGN KEY(id_admin) REFERENCES admin(id)	
) ENGINE = InnoDB ;

CREATE TABLE customer_online(
	id INT AUTO_INCREMENT NOT NULL,
	firstname VARCHAR(100) NOT NULL,
	lastname VARCHAR(100) NOT NULL,
	mail VARCHAR(255) NOT NULL,
	password VARCHAR(255) NOT NULL,
	PRIMARY KEY(id)
) ENGINE = InnoDB ;

CREATE TABLE customer_group(
	id INT AUTO_INCREMENT NOT NULL,
	number_adult SMALLINT NOT NULL,
	number_student SMALLINT  NOT NULL,
	number_children SMALLINT  NOT NULL,
	number_full SMALLINT NOT NULL,
	id_customer_online INT,
	PRIMARY KEY(id),
	FOREIGN KEY(id_customer_online) REFERENCES customer_online(id)
) ENGINE = InnoDB ;

CREATE TABLE reservation(
	id INT AUTO_INCREMENT NOT NULL,
	date DATE NOT NULL,
	reservation_type VARCHAR(6) NOT NULL,
	price FLOAT,
	id_film_show INT NOT NULL,
	id_customer_group INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(id_film_show) REFERENCES film_show(id),
	FOREIGN KEY(id_group) REFERENCES customer_group(id)
) ENGINE = InnoDB ;

CREATE TABLE prices(
	full DECIMAL(4,2) NOT NULL,
	student DECIMAL(4,2) NOT NULL,
	less14 DECIMAL(4,2) NOT NULL
) ENGINE = InnoDB ;

CREATE TABLE bill(
	id_reservation INT NOT NULL,
	id_customer_online INT,
	id_customer_group INT NOT NULL,
	PRIMARY KEY(id_reservation),
	FOREIGN KEY(id_reservation) REFERENCES reservation(id),
	FOREIGN KEY(id_customer_online) REFERENCES customer_online(id),
	FOREIGN KEY(id_customer_group) REFERENCES customer_group(id)
) ENGINE = InnoDB ;


-- Création d'utilisateurs
CREATE USER 'jeanpierre.martin'@'localhost' IDENTIFIED BY 'Lofigirl12' ;
CREATE USER 'arthur.dubois'@'localhost' IDENTIFIED BY 'Lighting45' ;
CREATE USER 'jeanne.petit'@'localhost' IDENTIFIED BY 'Metrosubway96' ;
CREATE USER 'raphael.radis'@'localhost' IDENTIFIED BY 'Pistachebasilic73' ;
CREATE USER 'nathalie.gonzales'@'localhost' IDENTIFIED BY 'Montagnechien85' ;
CREATE USER 'nolween.bianca'@'localhost' IDENTIFIED BY 'Palaisguitare66' ;

-- Mise en place des droits des utilisateurs en tant qu'admin ou superadmin.
GRANT SELECT, INSERT, UPDATE, DELETE ON cinema.film_show TO 'jeanpierre.martin'@'localhost';
GRANT SELECT, INSERT ON cinema.movie TO 'jeanpierre.martin'@'localhost' ;

GRANT SELECT, INSERT, UPDATE, DELETE ON cinema.film_show TO 'marie.lefebvre'@'localhost';
GRANT SELECT, INSERT ON cinema.movie TO 'marie.lefebvre'@'localhost' ;

GRANT SELECT, INSERT, UPDATE, DELETE ON cinema.film_show TO 'arthur.dubois'@'localhost';
GRANT SELECT, INSERT ON cinema.movie TO 'arthur.dubois'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON cinema.film_show TO 'raphael.radis'@'localhost';
GRANT SELECT, INSERT ON cinema.movie TO 'raphael.radis'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON cinema.film_show TO 'nathalie.gonzales'@'localhost';
GRANT SELECT, INSERT ON cinema.movie TO 'nathalie.gonzales'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON cinema.film_show TO 'nolween.bianca'@'localhost';
GRANT SELECT, INSERT ON cinema.movie TO 'nolween.bianca'@'localhost;

GRANT ALL PRIVILEGES ON cinema.* TO 'jeanne.petit'@'localhost';

FLUSH PRIVILEGES;


-- Insertion de données fictives

INSERT INTO complex(name, city) 
VALUES('le grandiose', 'bordeaux'), 
('la rigolade', 'compiègne'), 
('hollywood', 'cannes'), 
('pop corn', 'paris'), 
('l''eden', 'la rochelle'), 
('la projection ', 'toulouse');


INSERT INTO admin(firstname, lastname, role)
VALUES('jean-pierre', 'martin', 'admin'), 
('marie', 'lefebvre', 'admin'), 
('arthur', 'dubois', 'admin'), 
('jeanne', 'petit', 'superadmin'), 
('raphael', 'radis', 'admin'), 
('nathalie', 'gonzales', 'admin'), 
('nolween', 'bianca', 'admin');


INSERT INTO complex_management(id_complex, id_admin)
VALUES(1, 3), 
(1, 4), 
(2,2), 
(2,4), 
(3,1), 
(3,4), 
(4,5), 
(4,4), 
(5,6), 
(5,4);


INSERT INTO room(room_number, number_seat, id_complex)
VALUES(1, 150, 1), 
(2, 80, 1), 
(3, 100, 1), 
(1, 125, 2), 
(2, 80, 2), 
(3, 55, 2), 
(1, 150, 3), 
(2, 100, 3), 
(3, 65, 3), 
(1, 130, 4), 
(2, 105, 4), 
(3, 65, 4), 
(1, 140, 5), 
(2, 110, 5), 
(3, 95, 5), 
(1, 180, 6), 
(2, 200, 6), 
(3, 85, 6);

INSERT INTO movie(name, duration, director, genre)
VALUES('titanic', '03:15:00', 'james cameron' 'romance'), 
('sky fall', '02:20:00', 'sam mendes', 'action'), 
('ratatouille', '01:50:00', 'brad bird', 'animation'), 
('love actually', '02:30:00', 'richard curtis', 'romance'), 
('i robot', '01:55:00', 'jeff vintar', 'science fiction'),
('pokemon détective pikachu', '01:45:00', 'justice smith', 'action'), 
('le seigneur des anneaux', '03:00:00', 'peter jackson', 'aventure');

INSERT INTO film_show(date, start_time, end_time, id_complex, id_room, id_movie)
VALUES('2021-06-19', '20:00:00', '23:15:00', 2, 5, 1),
('2021-07-23', '19:00:00', '22:15:00', 2, 6, 1), 
('2021-05-12', '20:00:00', '22:30:00', 3, 8, 4),  
('2021-10-05', '20:00:00', '22:20:00', 3, 9, 2), 
('2021-09-17', '15:30:00', '18:30:00', 5, 13, 7),
('2021-10-03', '16:00:00', '17:45:00', 6, 17, 6);


INSERT INTO customer_online(firstname, lastname, mail, password)
VALUES('béatrice', 'alonzo', 'b.alonzo@hotmail.fr', '$2y$10$UFEGn0VDYRp7N8JlFKwPIOqltLyPNJ9KHy0SU90IOQaDR9eR6tEji '), 
('franck', 'holmes', 'Franck.dioz23@gmail.com', '$2y$10$q3ErH7DsnuLaGjrbLfEmNe7zVrt4RlrMrIxd7G7cvH56iZG9Z6CBK'), 
('fanny', 'breton', 'nynylasirene99@laposte.net', '$2y$10$ipa4s6jVn8QWuii3.rlsMe1zhnJrtGFGLOyaQGapsoFkhcjfS1M3a'), 
('damien', 'noir', 'dada.black@hotmail.fr', '$2y$10$6MzuqsjO2lFrTESXj0E1IutXJM1i06IkW.LGkLCCGu7T1UUGmPYKu'), 
('Sabrina', 'durand', 's.durand92@gmail.com', '$2y$10$JgKO3IDmmONfCbnDNiBWDe9dOaQ71LyGGYUaEcF7UNJtkm1urIREm');


INSERT INTO customer_group(number_adult, number_student, number_children, number_full, id_customer_online)
VALUES(4, 0, 2, 6, NULL), 
(2, 0, 0, 2, 1), 
(3, 1, 0, 4, NULL), 
(2, 2, 1, 5, 3), 
(2, 0, 1, 3, 5), 
(1, 0, 0, 1, 1), 
(5, 10, 3, 18, 2), 
(3, 1, 1, 5, NULL), 
(6, 0, 0, 6, 3), 
(2, 0, 3, 5, NULL);

INSERT INTO reservation(date, reservation_type, price, id_film_show, id_customer_group)
VALUES('2021-07-23', 'onspot', 48.6, 2, 1), 
('2021-07-20', 'online', 18.4, 2, 2), 
('2021-06-19', 'onspot', 42.8, 1, 3), 
('2021-09-14', 'online', 39.5, 5, 4), 
('2021-05-11', 'online', 24.3, 3, 5), 
('2021-05-09', 'online', 9.2, 3, 6), 
('2021-09-29', 'online', 139.7, 6, 7), 
('2021-07-23', 'onspot', 41.2, 2, 8), 
('2021-06-16', 'online', 55.2, 1, 9), 
('2021-10-05', 'onspot', 36.1, 4, 10);

INSERT INTO prices(full, student, less14)
VALUES(9.2, 7.6, 5.9);


INSERT INTO bill(id_reservation, id_customer_online, id_customer_group)
VALUES(1, NULL, 1), 
(2, 1, 2), 
(3, NULL, 3), 
(4, 3, 4), 
(5, 5, 5), 
(6, 1, 6), 
(7, 2, 7), 
(8, NULL, 8), 
(9, 3, 9), 
(10, NULL, 10);


-- Test CRUD
-- Selection du complexe dont l'identifiant est 2 et de ses administrateurs.
SELECT complex.name as nom_complexe, admin.firstname as prénom, admin.lastname as nom
FROM admin JOIN complex_management
ON admin.id = complex_management.id_admin
JOIN complex
ON complex.id = complex_management.id_complex
WHERE complex_management.id_complex = 2;

-- Selection du complexe qui a une ou plusieurs salles de plus de 150 places.
SELECT DISTINCT complex.name as nom_complexe
FROM complex JOIN room
ON complex.id = room.id_complex
WHERE room.number_seat > 149;

-- Selection du nombre d'enregistrement des séances où le film est titanic.
SELECT count(*) 
FROM film_show 
WHERE id_movie = 1 ;

-- Modification du genre du film i robot.
UPDATE movie
SET genre = 'action'
WHERE name = 'i robot';

-- supprimer la salle de cinema dont l'identifiant est 1.
DELETE FROM room
Where id = 1;


--Sauvegarde de la base de données
mysqldump -u root -p cinema > "C:\backup-bdd\cinemabackup.sql"
