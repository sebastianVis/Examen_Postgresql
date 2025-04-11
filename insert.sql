INSERT INTO empresa(nombre, direccion, nit) VALUES ('techzone', 'XD', 'XD');

INSERT INTO inventario(id_empresa) VALUES (1);

INSERT INTO categoria_producto(nombre) VALUES ('electronica');

INSERT INTO productos(id_inventario, nombre, valor, stock, id_categoria) VALUES (1, 'portatil', 2550, 7, 1), (1, 'pc-mesa', 3000, 3, 1),
(1, 'teclado', 300, 10, 1), (1, 'teclado-gamer', 350, 11, 1), (1, 'mouse', 200, 20, 1);

INSERT INTO cargo(nombre) VALUES ('chambeador');
INSERT INTO empleados(nombre, apellido, id_cargo, correo) VALUES ('jose', 'leal', 1, 'apsjdlka@gmail.com');
INSERT INTO cliente(nombre, apellido, documento, correo) VALUES ('arturo', 'cataño', '10123495' ,'arturo@catano.com'), ('jose', 'gustavo', '12312313', 'asjd@alksjd.com');
INSERT INTO ventas(id_producto, id_empleado, id_cliente) VALUES (1, 1, 1), (1,1,1), (2,1,1), (3,1,1), (4,1,1), (5,1,1), (4,1,1), (2,1,2);
INSERT INTO historial_ventas(id_venta, fecha) VALUES (17, '2025-03-03'),(18, '2025-03-02'),
(19, '2025-03-06'), (20, '2025-03-07'), (21, '2025-03-03'), (22, '2025-03-03'), (23, '2025-03-03'), (24, '2020-03-03');