DELIMITER //

CREATE TRIGGER after_insert_actualizacion_libros
AFTER INSERT ON libros
FOR EACH ROW
BEGIN
	UPDATE autores SET cantidad_libros = cantidad_libros + 1 WHERE autor_id = NEW.autor_id;

END;//

DELIMITER ;

#AHORA un trigger para decrecer la cantidad de libros
DELIMITER //

CREATE TRIGGER after_delete_actualizacion_libros
AFTER DELETE ON libros
FOR EACH ROW
BEGIN
	UPDATE autores SET cantidad_libros = cantidad_libros - 1 WHERE autor_id = OLD.autor_id;

END;//

DELIMITER ;

# trigger con el evento UPDATE
DELIMITER //

CREATE TRIGGER after_update_actualizacion_libros
AFTER UPDATE ON libros
FOR EACH ROW
BEGIN

	IF(NEW.autor_id != OLD.autor_id) THEN

	
	UPDATE autores SET cantidad_libros = cantidad_libros + 1 WHERE autor_id = NEW.autor_id;
	UPDATE autores SET cantidad_libros = cantidad_libros - 1 WHERE autor_id = OLD.autor_id;

	END IF;
END;//

DELIMITER ;
--
UPDATE libros SET autor_id = 2 WHERE libro_id = 6;
/*LISTADO Y ELIMINACION DE TRIGGER*/
SHOW TRIGGER
DROP TRIGGER IF EXISTS libreria_cf.after_delete_actualizacion_libros;