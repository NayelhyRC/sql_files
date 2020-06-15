CREATE VIEW prestamos_usuariios_vw AS
SELECT 
	usuarios.usuario_id,
	usuarios.nombre,
	usuarios.email,
	usuarios.username,
	COUNT(usuarios.usuario_id) AS total_prestamos
FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
GROUP BY usuarios.usuario_id;
#SHOW TABLES(para visualizar nuestras vistas)
#podemos usar una vista como una tabla misma:
SELECT * FROM prestamos_usuariios_vw;
SELECT * FROM prestamos_usuariios_vw WHERE total_prestamos > 4;
#para eliminar una vista:
DROP VIEW prestamos_usuariios_vw;
/*EDITAR VISTAS*/
CREATE OR REPLACE VIEW prestamos_usuariios_vw AS
SELECT 
	usuarios.usuario_id,
	usuarios.nombre,
	usuarios.email,
	usuarios.username,
	COUNT(usuarios.usuario_id) AS total_prestamos
FROM usuarios
INNER JOIN libros_usuarios ON usuarios.usuario_id = libros_usuarios.usuario_id
		AND libros_usuarios.fecha_creacion >= CURDATE() - INTERVAL 5 DAY
GROUP BY usuarios.usuario_id;
