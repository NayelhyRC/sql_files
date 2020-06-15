/*para obtener en un mismo SET diferentes resultados de diferentes tablas*/
/*podemos unir la catnidad de tablas que queramos
siempre especificar a quá tabla pertenece el campo*/
/*ON permite condicionar el uso de varias tablas*/
SELECT li.titulo,
	CONCAT(au.nombre, " ", au.apellido) AS nombre_autor,
	li.fecha_creacion
FROM libros AS li
INNER JOIN autores AS au ON  li.autor_id = au.autor_id;
/*SUBCLUSULA USING(cuando nuestra llavea foránea tiene el mismo nombre que la primaria*/
SELECT li.titulo,
	CONCAT(au.nombre, " ", au.apellido) AS nombre_autor,
	li.fecha_creacion
FROM libros AS li
INNER JOIN autores AS au USING(autor_id);
/*esto no lo puedo hacer usando USING: */
SELECT li.titulo,
	CONCAT(au.nombre, " ", au.apellido) AS nombre_autor,
	li.fecha_creacion
FROM libros AS li
INNER JOIN autores AS au ON  li.autor_id = au.autor_id
		AND au.seudonimo IS NOT NULL;

#uso de LEFT JOIN y LEFT OUTER JOIN: son exactamente lo mismo
#para obtener registros de la unión de dos tablas 
#obtener los nombres de los usuarios y sus libros prestados
#usuarios = a , libros_usuarios= b
SELECT 
	CONCAT(nombre," ",apellidos),
	libros_usuarios.libro_id
FROM usuarios
LEFT JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NOT NULL;
#RIGHT JOIN Y RIGHT OUTER JOIN: son exactamente lo mismo(para obtener registros de las 2 tablas)
/*libros_usuarios = a , usuarios= b*/
SELECT 
	CONCAT(nombre," ",apellidos),
	libros_usuarios.libro_id
FROM libros_usuarios
RIGHT JOIN usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
WHERE libros_usuarios.libro_id IS NOT NULL;
#MÚLTIPLES JOINS
/*usuariios,libros_usuarios,autores,libros*/
SELECT DISTINCT
	CONCAT (usuarios.nombre," ",usuarios.apellidos) AS nombre_usuario
FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
		AND DATE (libros_usuarios.fecha_creacion) = CURDATE()
INNER JOIN libros ON libros_usuarios.libro_id = libros.libro_id
INNER JOIN autores ON libros.autor_id = autores.autor_id 
				AND autores.seudonimo IS NOT NULL;

#PRODUCTOS CARTESIANOS: the result of joining multiples tables no specifying any condition
#vamos a usar CROSS JOIN:(a cada usuario le corresponde un libro)
SELECT usuarios.username, libros.titulo FROM usuarios CROSS JOIN libros;
#para insertar:
INSERT INTO libros_usuarios (libro_id, usuario_id) SELECT libro_id, usuario_id 
		FROM usuarios CROSS JOIN libros;