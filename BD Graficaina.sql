DROP DATABASE IF EXISTS graficaina;
CREATE DATABASE graficaina CHARACTER SET utf8mb4;
USE graficaina;

CREATE TABLE persona (
    id_persona INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    edad INT NOT NULL,
    dni INT NOT NULL,
    telefono INT NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_persona)
);

CREATE TABLE sucursal (
    id_sucursal VARCHAR(30) NOT NULL,
    ciudad VARCHAR(30) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_sucursal)
);

CREATE TABLE deposito (
    id_deposito VARCHAR(30) NOT NULL,
    id_sucursal VARCHAR(30) NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_deposito),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal)
);

CREATE TABLE empleado (
    id_empleado INT NOT NULL AUTO_INCREMENT,
    id_persona INT NOT NULL,
    id_sucursal VARCHAR(30) NOT NULL,
    puesto VARCHAR(50),
    sueldo FLOAT(10, 2) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_retiro DATE,
    motivo_retiro TEXT,
    PRIMARY KEY (id_empleado),
    FOREIGN KEY (id_persona) REFERENCES persona (id_persona),
    FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal)
);

CREATE TABLE pedido (
    id_pedido INT NOT NULL AUTO_INCREMENT,
    id_persona INT NOT NULL,
    estado VARCHAR(15) NOT NULL,
    fecha_pedido DATE NOT NULL,
    fecha_entrega DATE,
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_persona) REFERENCES persona (id_persona)
);

CREATE TABLE pago (
    id_pago INT NOT NULL AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_persona INT NOT NULL,
    suma FLOAT(10, 2) NOT NULL,
    metodo VARCHAR(30) NOT NULL,
    fecha_pago DATE NOT NULL,
    PRIMARY KEY (id_pago),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
    FOREIGN KEY (id_persona) REFERENCES persona (id_persona)
);

CREATE TABLE proveedor (
    id_proveedor VARCHAR(30) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_proveedor)
);

CREATE TABLE producto (
    id_producto INT NOT NULL,
    id_proveedor VARCHAR(30) NOT NULL,
    gama TEXT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    precio_unidad FLOAT(10, 2) NOT NULL,
    PRIMARY KEY (id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor (id_proveedor)
);

CREATE TABLE detalle_pedido (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    cantidad INT NOT NULL,
    precio_unidad FLOAT(10, 2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

CREATE TABLE detalle_deposito (
    id_deposito VARCHAR(30) NOT NULL,
    id_producto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_deposito, id_producto),
    FOREIGN KEY (id_deposito) REFERENCES deposito (id_deposito),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

CREATE TABLE pedido_interno (
    id_pedido INT NOT NULL AUTO_INCREMENT,
    costo FLOAT(10, 2) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    fecha_pedido DATE NOT NULL,
    fecha_entrega DATE,
    PRIMARY KEY (id_pedido)
);

CREATE TABLE detalle_pedido_interno (
    id_pedido_interno INT NOT NULL,
    id_producto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    cantidad INT NOT NULL,
    costo_unidad FLOAT(10, 2) NOT NULL,
    PRIMARY KEY (id_pedido_interno, id_producto),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);