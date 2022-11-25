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

SELECT estado, fecha_pedido FROM pedido WHERE estado LIKE  'cancelado' AND fecha_pedido BETWEEN '2015-9-20' AND '2015-10-25';
SELECT COUNT(Estado) AS cantidad FROM pedido Where Estado LIKE 'entregado' ;
SELECT COUNT(id_empleado), puesto From empleado GROUP BY puesto;
SELECT Direccion, ciudad FROM sucursal ORDER BY ciudad DESC;
SELECT  Nombre, apellido FROM persona ORDER BY Id_persona ASC;	
SELECT  COUNT(id_producto), gama FROM Producto GROUP BY gama;
SELECT estado, fecha_entrega FROM pedido WHERE estado LIKE 'pendiente' AND fecha_entrega >= '2021-06-20';

