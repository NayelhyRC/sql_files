START TRANSACTION;

SET @libro_id = 1, @usuario_id = 1; 

UPDATE libros SET stock = stock - 1 WHERE libro_id = @libro_id;
SELECT stock FROM libros WHERE libro_id = @libro_id;

INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES (@libro_id,@usuario_id);
SELECT * FROM libros_usuarios;
#para que los cambios que hice en la tabla sean permanentes:)
COMMIT;
#para revertir los cambios:
ROLLBACK;
/*-----TRANSACCIONES Y STORE PROCEDURES---*/
DELIMITER //

CREATE PROCEDURE prestamo(usuario_id INT, libro_id INT)
BEGIN

	DECLARE EXIT HANDLER FOR SQLEXCEPTION -- Ocurre un error(es como un trycatch)
	BEGIN
		ROLLBACK;
	END;

	START TRANSACTION;
	INSERT INTO libros_usuarios(libro_id, usuario_id) VALUES(libro_id, usuario_id);
	UPDATE libros SET stock = stock - 1 WHERE libros.libro_id = libro_id;

	COMMIT;
END//

DELIMITER ;
#para conocer qué motor de búsqueda puedo utilizar:
SHOW ENGINES;
/*un EVENTO es una tarea que se ejecuta automáticamente
en un momento previamente programado*/