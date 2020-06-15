DROP DATABASE IF EXISTS libreria_cf;
CREATE DATABASE IF NOT EXISTS libreria_cf;

USE libreria_cf;
/*comando para acceder desde la consola*/
/*mysql -u root -p < C:\Users\WHINERY\Desktop\sql_files/sentencias.sql*/
/*SOURCE C:\Users\WHINERY\Desktop\sql_files/sentencias.sql*/
/*this is a comment to proving git*/
CREATE TABLE IF NOT EXISTS autores(
	autor_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(25) NOT NULL,
	apellido VARCHAR(25) NOT NULL,
	seudonimo VARCHAR(50) UNIQUE,
	genero ENUM("M","F"), 
	fecha_nacimiento DATE NOT NULL,
	pais_origen VARCHAR(40) NOT NULL,
	fecha_creacion DATETIME DEFAULT current_timestamp
);

ALTER TABLE autores ADD COLUMN cantidad_libros INT DEFAULT 0;

CREATE TABLE libros(
	libro_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	autor_id INT UNSIGNED NOT NULL,
	titulo varchar(50) NOT NULL,
	descripcion varchar(250),
	paginas INTEGER UNSIGNED,
	fecha_publicacion Date NOT NULL,
	fecha_creacion DATETIME DEFAULT current_timestamp,
	FOREIGN KEY (autor_id) REFERENCES autores(autor_id) ON DELETE CASCADE 
);

ALTER TABLE libros ADD ventas INT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE libros ADD stock INT UNSIGNED DEFAULT 10;

/*ALTER TABLE libros ADD FOREIGN KEY (autor_id) REFERENCES autores(autor_id) ON DELETE CASCADE*/

CREATE TABLE usuarios(
	usuario_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	nombre varchar(25) NOT NULL,
	apellidos varchar(25),
	username varchar(25) NOT NULL,
	email varchar(50) NOT NULL,
	fecha_creacion DATETIME DEFAULT current_timestamp
);

CREATE TABLE libros_usuarios(
	libro_id INT UNSIGNED NOT NULL,
	usuario_id INT UNSIGNED NOT NULL,

	FOREIGN KEY (libro_id) REFERENCES libros(libro_id),
	FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
	fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

/*las tuplas deben tener la misma cantidad de valores que las de INSERT INTO*/

INSERT INTO autores(nombre, apellido, seudonimo,genero, fecha_nacimiento,pais_origen)
VALUES ("Joane", "Rowling", "J.K. Rowling","f", "1966-09-22", "UK"),
		("Stephen Edwin", "King", "Richard Bachman", "M", "1947-10-11", "USA");

INSERT INTO autores(nombre, apellido,genero, fecha_nacimiento,pais_origen)
VALUES ("Miguel", "de Unamuno","m", "1966-09-22", "UK"),
		("Federico", "Garcia Lorca","f", "1966-09-22", "UK");

INSERT INTO libros(autor_id, titulo, paginas, fecha_publicacion)
VALUES (1, "Harry Potter y la Piedra Filosofal", 233, "1997-08-04"),
		(1, "Harry Potter y la Cámara Secreta", 303, "1999-08-04"),

		(2, "Carrie", 433, "1986-08-04"),
		(2, "El resplandor", 493, "1977-08-04");

INSERT INTO libros(autor_id, titulo, fecha_publicacion)
VALUES	(1, "Harry Potter y las Reliquias de la Muerte", "2007-08-04");

		(2, "Carrie", 433, "1986-08-04"),
		(2, "El resplandor", 493, "1977-08-04");

INSERT INTO usuarios(nombre, apellidos, username, email)
VALUES 	("Nayelhy","RC","nayerc", "narece@gmail.com"),
		("Persona","Ideal xd", "perideal", "pideal@adolec.com");

INSERT INTO libros_usuarios(libro_id, usuario_id)
VALUES (1,1), (2,1), (3,1),
		(55,3), (55,3),(55,3);

SELECT * FROM autores;
SELECT * FROM libros;


