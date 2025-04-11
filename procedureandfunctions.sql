-- 5. Procedimientos y Funciones
-- (ProcedureAndFunctions.sql)

-- Un procedimiento almacenado para registrar una venta.

CREATE OR REPLACE PROCEDURE registrar_venta(
    p_id_producto INT,
    p_id_empleado INT,
    p_id_cliente INT,
    p_cantidad INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_venta_id INT;
BEGIN
    IF NOT cliente_existe(p_id_cliente) THEN
        RAISE EXCEPTION 'El cliente con ID % no existe.', p_id_cliente;
    END IF;
    IF NOT stock_suficiente(p_id_producto, p_cantidad) THEN
        RAISE NOTICE 'No hay suficiente stock para el producto con ID %.', p_id_producto;
        RETURN;
    END IF;
    INSERT INTO ventas(id_producto, id_empleado, id_cliente)
    VALUES (p_id_producto, p_id_empleado, p_id_cliente)
    RETURNING id_venta INTO v_venta_id;

    INSERT INTO producto_venta(id_producto, id_venta)
    VALUES (p_id_producto, v_venta_id);

    INSERT INTO historial_ventas(id_venta, fecha)
    VALUES (v_venta_id, CURRENT_DATE);

    UPDATE productos
    SET stock = stock - p_cantidad
    WHERE id_producto = p_id_producto;
    
    RAISE NOTICE 'Venta registrada exitosamente. ID venta: %', v_venta_id;
END;
$$;


-- Validar que el cliente exista.

CREATE OR REPLACE FUNCTION cliente_existe(p_id_cliente INT)
RETURNS BOOLEAN AS $$
DECLARE
    existe BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM cliente WHERE id_cliente = p_id_cliente
    ) INTO existe;
    
    RETURN existe;
END;
$$ LANGUAGE plpgsql;

-- Verificar que el stock sea suficiente antes de procesar la venta.
-- Si no hay stock suficiente, Notificar por medio de un mensaje en consola usando RAISE.
-- Si hay stock, se realiza el registro de la venta.

CREATE OR REPLACE FUNCTION stock_suficiente(p_id_producto INT, p_cantidad INT)
RETURNS BOOLEAN AS $$
DECLARE
    disponible INT;
BEGIN
    SELECT stock INTO disponible FROM productos WHERE id_producto = p_id_producto;

    IF disponible IS NULL THEN
        RETURN FALSE;
    END IF;

    RETURN disponible >= p_cantidad;
END;
$$ LANGUAGE plpgsql;
