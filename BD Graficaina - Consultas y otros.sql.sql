DROP FUNCTION IF EXISTS calcular_precio_total_pedido;

DELIMITER $$

CREATE FUNCTION calcular_precio_total_pedido (id_pedido INT)
RETURNS FLOAT READS SQL DATA
BEGIN
    DECLARE total_pedido FLOAT;
    SELECT SUM(dp.cantidad * dp.precio_unidad) INTO total_pedido FROM detalle_pedido dp WHERE id_pedido = dp.id_pedido;
    RETURN total_pedido;
END$$

DELIMITER ;

DROP TRIGGER IF EXISTS identpago_bi;
   DELIMITER //
    CREATE TRIGGER identpago_bi BEFORE INSERT
    ON pago FOR EACH ROW 
    BEGIN
    DECLARE id_persona1 INT;
    SELECT id_persona INTO id_persona1 FROM pedido WHERE id_pedido = NEW.id_pedido;
    IF id_persona1 != NEW.id_persona THEN
    SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = "el pago no corresponde a la persona.";
     END IF; 
   END //
DELIMITER ;

CREATE VIEW Empleados AS SELECT id_empleado, puesto FROM empleado ORDER BY puesto;

SELECT estado, fecha_pedido FROM pedido WHERE estado LIKE  'cancelado' AND fecha_pedido BETWEEN '2015-9-20' AND '2015-10-25';
SELECT COUNT(Estado) AS cantidad FROM pedido Where Estado LIKE 'entregado' ;
SELECT COUNT(id_empleado), puesto From empleado GROUP BY puesto;
SELECT Direccion, ciudad FROM sucursal ORDER BY ciudad DESC;
SELECT Nombre, apellido FROM persona ORDER BY Id_persona ASC;	
SELECT COUNT(id_producto), gama FROM Producto GROUP BY gama;
SELECT estado, fecha_entrega FROM pedido WHERE estado LIKE 'pendiente' AND fecha_entrega >= '2021-06-20';
SELECT * FROM Empleado WHERE puesto IN (SELECT puesto FROM empleado Where sueldo > 5000);
SELECT Persona.ID_persona, pedido.ID_Pedido FROM persona INNER JOIN pedido ON Persona.ID_persona = pedido.ID_Pedido;

DROP PROCEDURE IF EXISTS obtener_sucursal_ciudad;
DELIMITER //
CREATE PROCEDURE obtener_sucursal_ciudad(City VARCHAR(20))
BEGIN
    SELECT COUNT(ID_sucursal), ciudad FROM sucursal WHERE ciudad = city;
END //

create user 'dueño'@'localhost' identified by 'graficaina123';

GRANT ALL PRIVILEGES on graficaina.* to  'dueño'@'localhost'

show grants for  'dueño'@'localhost'

DROP PROCEDURE IF EXISTS backupinsert;
DELIMITER //
CREATE PROCEDURE backupinsert()
BEGIN 
DECLARE done INT DEFAULT FALSE;
DECLARE nombre_backup, apellido_backup, email_backup, direccion_backup VARCHAR(50);
DECLARE id_backup, edad_backup, dni_backup, telefono_backup INT;
DECLARE Precioporproducto CURSOR FOR SELECT id_persona, nombre, apellido, edad, dni, telefono, direccion, email FROM persona; 
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN Precioporproducto;

 Getpp: LOOP 
 FETCH Precioporproducto INTO id_backup, nombre_backup, apellido_backup, edad_backup, dni_backup, telefono_backup, direccion_backup, email_backup;
 INSERT INTO backup VALUES (id_backup, nombre_backup, apellido_backup, edad_backup, dni_backup, telefono_backup, direccion_backup, email_backup);
 IF Done = 1 THEN LEAVE Getpp
 END IF;
 END LOOP;
 CLOSEPrecioporproducto;
END //
DELIMITER ;
 
