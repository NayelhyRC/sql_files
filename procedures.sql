DELIMITER //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT)
BEGIN
	INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
	UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;
END//

DELIMITER ;

#para listar todos mis store procedure:
SHOW PROCEDURE STATUS WHERE db = database() AND type = "PROCEDURE";
#para llamar a mi store procedure:
CALL prestamo (2,2);
/*---------ELIMINAR PROCEDURE:*/
DROP PROCEDURE prestamo;
#a diferencia de las funciones, los procedures no retornan valores.
/*---------OBTENER VALORES-----------*/
DELIMITER //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT, OUT cantidad INT)
BEGIN
	INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
	UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

	SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);
END//

DELIMITER ;
/*-----------CONDICIONALES-----*/
DELIMITER //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT, OUT cantidad INT)
BEGIN
	SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);
	IF cantidad > 0 THEN

		INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
		UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

		SET cantidad = cantidad - 1;

	ELSE	

		SELECT "No es posible realizar el prestamo" AS mensaje_error;

	END IF;

	SET cantidad = (SELECT stock FROM libros WHERE libros.libro_id = libro_id);
END//

DELIMITER //

CREATE PROCEDURE tipo_lector(usuario_id INT)
BEGIN
	
	SET @cantidad = (SELECT COUNT(*) FROM libros_usuarios
						WHERE libros_usuarios.usuario_id = usuario_id);

	CASE 
		WHEN @cantidad > 20 THEN
			SELECT "Fanatic" AS mensaje;
		WHEN @cantidad > 10 AND @cantidad < 20 THEN
			SELECT "aficionado" AS mensaje;
		WHEN @cantidad > 5 AND @cantidad < 10 THEN
			SELECT "promedio" AS mensaje;
		ELSE 
			SELECT "Nuevo" AS mensaje;
	END CASE;
END//
DELIMITER ;
/*------CICLOS------*/
#CICLO WHILE
DELIMITER //
CREATE PROCEDURE libros_azar()
BEGIN
	SET @iteracion = 0;

	WHILE @iteracion < 5 DO 

		SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
		SET @iteracion = @iteracion + 1;
	END WHILE;
END//
DELIMITER ;
#CICLO REPEAT
DELIMITER //
CREATE PROCEDURE libros_azar()
BEGIN
	SET @iteracion = 0;

	REPEAT

		SELECT libro_id, titulo FROM libros ORDER BY RAND() LIMIT 1;
		SET @iteracion = @iteracion + 1;
	
		UNTIL @iteracion >= 5
	END REPEAT;
END//
DELIMITER ;

