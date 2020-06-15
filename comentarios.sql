/*¿Qué tipo de entidades? Autores
Nombre: autores*/
#comandos: 
- USE DATABASE libreria_cf;--solo el nombre de la librería)
- SHOW DATABASES;
- SHOW TABLES;
- SELECT * FROM autores; --para obtener todos los registros de una tabla)
- DESC libros; -->es para mostrar la tabla "libros"
- ALTER TABLE libros ADD ventas INT UNSIGNED NOT NULL;(para añadir una columna)
- " DEFAULT 10";--hará que todos tengan 10 ventas)
- ALTER TABLE libros DROP COLUMN stock;
- SELECT libro_id, titulo FROM libros;
- SELECT * FROM libros\G;
- SELECT * FROM libros WHERE  titulo = "Carrie";
-  SELECT * FROM libros WHERE titulo = "Carrie" AND autor_id= 1;
- SELECT * FROM libros WHERE (autor_id=1 AND titulo = "Carrie") OR (autor_id = 3 AND titulo= "hola");
- SELECT * FROM autores WHERE seudonimo IS NULL;
- SELECT * FROM autores WHERE seudonimo <=> NULL;

/*TIP: todas nuestras tablas deben poseer campos que nos permitan saber
cuando fue creado un registro*/
comandos:
- SELECT current_timestamp;(es para obtener la fecha exacta)
- UNSIGNED: para no permitir números negativos

+TIPO ENUM

+integridad referencial

Como sabemos, si nosotros necesitamos validar valores únicos usaremos el constraint UNIQUE.
CREATE TABLE usuarios( 
  usuario_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) UNIQUE
);
Otra forma de expresarlo, es de la siguiente manera.
CREATE TABLE usuarios( 
  usuario_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  CONSTRAINT UNIQUE (nombre)
);
La palabra CONSTRAINT es opcional, sin embargo, por temas de legibilidad recomiendo colocarla.


VALORES MÚTIPLES COLUMNAS
Si necesitamos validar el valor único de una combinación de columnas lo haremos de la siguiente manera.

En este caso queremos validar que la combinación de nombre, apellido y matricula sean unicas en la tabla.

CREATE TABLE usuarios( 
  usuario_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  matricula VARCHAR(10),
  CONSTRAINT unique_combinacion UNIQUE (nombre, apellido, matricula),
  PRIMARY KEY (usuario_id)
);

-mysql> ALTER TABLE libros ADD ventas INT UNISGNED NOT NULL;(para añadir una columna a la tabla )
-mysql> ALTER TABLE libros ADD stock INT UNSIGNED NOT NULL DEFAULT 10; (he puesto el valor 10 por defecto)
-mysql> ALTER TABLE libros DROP COLUMN stock;(para eliminar una columna)

SENTENCIAS CON CONDICIONES:
- <
- >
- != <>   (para representar diferente)
//para obtener registros a partir de un rango, utilizamos "BETWEEN"
/*una vez utilizo un alias, el nombre original queda de lado*/
SELECT autor_id AS autor, titulo AS nombre FROM libros;(el alias se puede definit sin AS)
SELECT autor_id AS autor, titulo AS nombre FROM libros AS books;
SELECT books.autor_id AS autor, books.titulo AS nombre FROM libros AS books;
//para actualizar registros
UPDATE libros SET descripcion = "Nueva descripcion", ventas = 100 WHERE titulo = "Carrie";
/*para eliminar registros:*/
DELETE FROM libros WHERE autor_id= 2;
- no podemos eliminar registros dejando referencias huérfanas(no puedo eliminar un autor si su id se usa en algunos libros)
---------------
SELECT titulo FROM libros WHERE fecha_publicacion BETWEEN"1995-01-01" AND "2015-01-31";
/*para obtener registros que cumplan la condición en una lista:*/
SELECT * FROM libros WHERE titulo IN ("Carrie", "El resplandor");
/*para obtener valores únicos dentro de una consulta:*/
SELECT DISTINCT titulo FROM libros;(no me va a mostrar valores repetidos)
-para eliminar todos los registros de una tabla:
TRUNCATE TABLE libros;(a diferencia de delete, no puede ser usada con la sentencia WHERE y 
AUTO_INCREMENT empieza en 1, y resetea la definición de los datos)
- en una transacción con DELETE es posible recuperar los datos eliminados
------------------------------------
función para concatenar
SELECT CONCAT(nombre," ", apellido) FROM autores;
SELECT CONCAT(nombre," ", apellido) AS nombre_completo FROM autores;
-LENGTH 
SELECT * FROM autores WHERE LENGTH(nombre) > 6;
-UPPER and LOWER
SELECT UPPER(nombre), LOWER(nombre) FROM autores;
- TRIM : ELIMINAR PREFIJOS Y SUFIJOS DE UN STRING
SELECT TRIM(" cadena con espacio al inicio y al final");
- LEFT Y RIGHT
SELECT
    -> LEFT("es una cadena" , 5) AS substring_left,
    -> RIGHT("es una cadena", 10) AS substring_right;
    ------------
    SELECT * FROM libros WHERE LEFT(titulo, 12 ) = "Harry Potter";
//FUNCIONES SOBRE números
  -RAND
  SELECT RAND();
  -
  SELECT ROUND(RAND() * 100);
  -trunca los números después de la coma decimal
 SELECT TRUNCATE (1.123456789, 3);
  -
  SELECT POW(2,16);
-----------------//FUNCIONES SOBRE FECHAS-------
 SELECT now();
-almacenar la fecha exacta en una variable llamada NOW();
SET @now= NOW();ahora podemos extraer:
SELECT SECOND(@now),MINUTE(@now), HOUR(@now),MONTH(@now),YEAR(@now);
SELECT DAYOFWEEK(@now), DAYOFMONTH(@now),DAYOFYEAR(@now);
SELECT DATE(@now);
-ahora para los libros que se han agregado hoy, con CURDATE();
SELECT * FROM libros WHERE DATE(fecha_creacion) = CURDATE();
- para sumar o restar días:
SELECT @now + INTERVAL 30 DAY;
//---------------FUNCIONES SOBRE CONDICIONES
SELECT IF( 10>9, "NUMBER IS MAJOR", "THE NUMber isnt major");
SELECT IF(paginas = 0, "book has noy pages", paginas) FROM libros;
SELECT IFNULL (seudonimo , "author has not one") FROM autores;

//CREANDO una variable de tipo CURDATE;
SET @now = CURDATE();
//para listar todas mis FUNCIONES
SELECT name FROM mysql.proc WHERE db = database() AND type = "FUNCTION";
-a partir de la versión 8 es:
SHOW FUNCTION STATUS WHERE db = database() AND type = "FUNCTION";
-para eliminar:
DROP FUNCTION agregar_dias;
-----------------------
//--------------BÚSQUEDA MEDIANTE STRINGS--
-para buscar substrings al principio, final o al medio... de la cadena
SELECT * FROM libros WHERE titulo LIKE "Harry Potter%";
(el porcentaje es para indicar que quiero que el substring se encuentre
al principio del texto original)
(pongo el %inicio poque quiero que se encuentre al final)
-si no sé en qué parte está el substring, pongo %texto%:
SELECT * FROM libros WHERE titulo LIKE "%ar%";
-more complex
SELECT * FROM libros WHERE titulo LIKE "__r__";
//-----------EXPRESIONES REGULARES--
SELECT titulo FROM libros WHERE titulo REGEXP "^[HC]";
//-------QUE ME ENTREGUE UN LISTADO ORDENADO:
SELECT titulo FROM libros ORDER BY titulo;
SELECT titulo FROM libros ORDER BY titulo DESC;(ASC para ascendente)
SELECT libro_id, titulo FROM libros ORDER BY libro_id DESC;
SELECT libro_id, titulo FROM libros ORDER BY libro_id AND titulo DESC;
//---------PARA TRABAJAR CON SOLO UNA PORCIÓN DE LOS REGISTROS DE MIT ABLA---
SELECT titulo FROM libros LIMIT 2;
SELECT titulo FROM libros WHERE autor_id= 2 LIMIT 2;
-para ir obteniendo porciones de registro de poco a poco:
SELECT libro_id,titulo FROM libros LIMIT 0,5;
//-------FUNCIONES DE AGREGACIÓN------
Solo podemos trabajar con una columna
-COUNT(): NOS Permite contar registros
-SUM(): para sumar jeje
  SELECT SUM(ventas) FROM libros;
-MAX(): mayor número;
    SELECT MAX(ventas) FROM libros;
-MIN(): MENOR número;
  SELECT MIN(ventas) FROM libros;
-AVG(): nos permite saber el promedio
//----------------AGRUPAMIENTO--------------
SELECT autor_id, SUM(ventas) FROM libros GROUP BY autor_id;
- para saber el autor que más vendió:
SELECT autor_id, SUM(ventas) AS total FROM libros GROUP BY autor_id ORDER BY total DESC LIMIT 1;
//------------CONDICIONES DE AGRUPAMIENTO
No puedo usar el WHERE, uso el HAVING:
SELECT autor_id, SUM(ventas) AS total FROM libros GROUP BY autor_id HAVING SUM(ventas) > 100;
//------------------UNIR RESULTADOS-------------
-UNION()
//-------------SUBCONSULTAS----
//------------VALIDAR REGISTROS----------
-Con el operador EXISTS -->siempre put the main key
SELECT IF(
 EXISTS(SELECT libro_id FROM libros WHERE titulo = "Carrie"),"disponible","no disponible"
 )AS mensaje;
)