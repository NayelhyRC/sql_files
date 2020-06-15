SELECT COUNT(*) FROM autores;
SELECT COUNT(*) AS total FROM autores WHERE seudonimo IS NOT NULL;SELECT COUNT(*) AS total FROM autores WHERE seudonimo IS NOT NULL;
SELECT COUNT(seudonimo) AS total FROM autores;

SELECT SUM(ventas) FROM libros;
SELECT MAX(ventas) FROM libros;
SELECT MIN(ventas) FROM libros;
SELECT AVG(ventas) FROM libros;

SELECT autor_id, SUM(ventas) FROM libros GROUP BY autor_id;
SELECT autor_id, SUM(ventas) AS total FROM libros GROUP BY autor_id ORDER BY total DESC LIMIT 1;
SELECT autor_id, SUM(ventas) AS total FROM libros GROUP BY autor_id HAVING SUM(ventas) > 100;

SELECT CONCAT(nombre, " ",apellido) FROM autores
UNION
SELECT CONCAT(nombre, " ", apellidos) FROM usuarios;

SELECT CONCAT(nombre, " ",apellido)AS nombre_completo,"" , pais_origen AS pais FROM autores
UNION
SELECT CONCAT(nombre, " ", apellidos)AS nombre_completo, email,"" FROM usuarios;
/*PARA SUB CONSULTAS:*/

SELECT CONCAT(nombre," ", apellido)
FROM autores
WHERE autor_id IN(
	SELECT 
		autor_id 
	FROM libros 
	GROUP BY autor_id 
	HAVING SUM(ventas) > (SELECT AVG(ventas) FROM libros));

SELECT IF(
 EXISTS(SELECT libro_id FROM libros WHERE titulo = "Carrie"),"disponible","no disponible"
 )AS mensaje;