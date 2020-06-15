CREATE TABLE test(
	evento VARCHAR(50),
	fecha DATETIME
);

#habilitar nuestro servidor para que pueda ejecutar eventos:
SET GLOBAL event_scheduler = ON;

CREATE EVENT insertion_event
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MIMUTE
DO INSERT INTO test VALUES ("Eventoo 1", NOW());
#*el nombre del evento no debe poseer más de 64 caracteres.
