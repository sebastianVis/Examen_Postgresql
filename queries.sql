-- 📄 4. Consultas SQL (queries.sql)
-- Incluir 6 consultas avanzadas:
--  Listar los productos con stock menor a 5 unidades.

SELECT id_producto, nombre, stock
FROM productos
WHERE stock < 5;

--  Calcular ventas totales de un mes específico.

SELECT v.id_venta, c.nombre AS cliente, e.nombre AS empleado, h.fecha
FROM ventas v
JOIN historial_ventas h ON v.id_venta = h.id_venta
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN empleados e ON v.id_empleado = e.id_empleado
WHERE h.fecha BETWEEN '2025-03-01' AND '2025-03-04';


--  Obtener el cliente con más compras realizadas.

SELECT c.id_cliente,c.nombre,c.apellido,COUNT(v.id_venta) AS total_compras
FROM cliente c
JOIN ventas v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY total_compras DESC
LIMIT 1;

--  Listar los 5 productos más vendidos.

SELECT  p.id_producto, p.nombre, COUNT(v.id_venta) AS veces_vendido
FROM  productos p
JOIN ventas v ON p.id_producto = v.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY veces_vendido DESC
LIMIT 5;

--  Consultar ventas realizadas en un rango de fechas de tres Días y un Mes.

SELECT  v.id_venta, c.nombre AS cliente, e.nombre AS empleado, h.fecha
FROM  ventas v
JOIN historial_ventas h ON v.id_venta = h.id_venta
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN empleados e ON v.id_empleado = e.id_empleado
WHERE h.fecha >= '2025-03-01' AND h.fecha < '2025-03-05';


--  Identificar clientes que no han comprado en los últimos 6 meses.

SELECT  c.id_cliente, c.nombre, c.apellido, c.correo
FROM  cliente c
WHERE 
c.id_cliente NOT IN (
   SELECT DISTINCT v.id_cliente
    FROM ventas v
    JOIN historial_ventas h ON v.id_venta = h.id_venta
    WHERE h.fecha >= CURRENT_DATE - INTERVAL '6 months'
);