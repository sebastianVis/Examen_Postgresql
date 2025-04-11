DROP DATABASE IF EXISTS techzone;
CREATE DATABASE techzone;
\c techzone;

CREATE TABLE empresa(
id_empresa SERIAL PRIMARY KEY,
nombre VARCHAR(30),
direccion VARCHAR(50),
nit VARCHAR (15)
);

CREATE TABLE inventario(
id_inventario SERIAL PRIMARY KEY,
id_empresa SERIAL,
FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE categoria_producto(
id_categoria SERIAL PRIMARY KEY,
nombre VARCHAR(20)
);

CREATE TABLE productos(
id_producto SERIAL PRIMARY KEY,
id_inventario SERIAL,
id_categoria SERIAL,
nombre VARCHAR(30),
valor NUMERIC(7,2),
stock INTEGER DEFAULT 0,
FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario),
FOREIGN KEY (id_categoria) REFERENCES categoria_producto(id_categoria)
);

CREATE TABLE cargo(
id_cargo SERIAL PRIMARY KEY,
nombre VARCHAR(30)
);

CREATE TABLE empleados(
id_empleado SERIAL PRIMARY KEY,
nombre VARCHAR(40),
apellido VARCHAR(40),
correo VARCHAR(50),
id_cargo SERIAL,
FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)
);

CREATE TABLE pais(
id_pais SERIAL PRIMARY KEY,
id_direccion SERIAL
);

CREATE TABLE departamento(
id_departamento SERIAL PRIMARY KEY,
nombre VARCHAR(30),
id_pais SERIAL,
FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE ciudad(
id_ciudad SERIAL PRIMARY KEY,
nombre VARCHAR(30),
id_departamento SERIAL,
FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

CREATE TABLE direccion(
id_direccion SERIAL PRIMARY KEY,
carrera VARCHAR(10),
calle VARCHAR(10),
barrio VARCHAR(20),
id_ciudad SERIAL,
zip VARCHAR(10),
FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);