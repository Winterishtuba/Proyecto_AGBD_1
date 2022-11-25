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