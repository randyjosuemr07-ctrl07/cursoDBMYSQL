-- BORRAR SI YA EXISTE
DROP DATABASE IF EXISTS SaludTotal;
CREATE DATABASE SaludTotal;
USE SaludTotal;

-------------------------------------------------
-- TABLA Medicinas
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Medicinas (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo CHAR(3),           -- GEN o COM
    precio DECIMAL(15,2),
    stock INT,
    fechacaducidad DATETIME
);

-------------------------------------------------
-- TABLA Clientes
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Clientes (
    cedula VARCHAR(13) PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_nacimiento CHAR(10), 
    persona_tipo CHAR(3)       -- NAT o JUR
);

-- Datos de ejemplo clientes 
INSERT INTO Clientes (cedula, nombre, fecha_nacimiento, persona_tipo)
VALUES
('15464546553', 'Jose', '14-06-1985', 'NAT'),
('51505505', 'Mario', '04-08-1995', 'NAT'),
('1800000002', 'Paul', '22-06-2005', 'NAT');

-------------------------------------------------
-- INSERTAR MEDICINAS
-------------------------------------------------
INSERT INTO Medicinas (id, nombre, tipo, precio, stock, fechacaducidad)
VALUES
(1, 'paracetamol', 'GEN', 1.50, 12, '2026-12-24 00:00:00'),
(2, 'amoxicilina', 'GEN', 2.60, 30, '2026-11-24 00:00:00'),
(3, 'penicilina',  'GEN', 3.50, 12, '2026-08-24 00:00:00'),
(4, 'ibuprofeno',  'COM', 2.20, 40, '2027-01-01 00:00:00');

-------------------------------------------------
-- TABLA Descuentos
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Descuentos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_cliente CHAR(3),
    tipo_medicina CHAR(3),
    descuento_porcentaje DECIMAL(5,2),
    descripcion VARCHAR(200)
);

INSERT INTO Descuentos (tipo_cliente, tipo_medicina, descuento_porcentaje, descripcion)
VALUES
('NAT', 'DBT', 8.00,  'Descuento para gente con diabetes tipo 2 que usa Metformina'),
('JUR', 'DBT', 12.00, 'Descuento para gente con diabetes tipo 1 que necesita Insulina'),
('NAT', 'DBT', 6.00,  'Descuento para gente con diabetes que utiliza Glibenclamida');

-------------------------------------------------
-- TABLA Cliente_Medicina 
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente_Medicina (
    cliente_cedula VARCHAR(13),
    medicina_id INT,
    condicion VARCHAR(100),
    frecuencia CHAR(3),
    descuento DECIMAL(5,2),
    PRIMARY KEY (cliente_cedula, medicina_id),
    CONSTRAINT fk_cm_cliente FOREIGN KEY (cliente_cedula) REFERENCES Clientes(cedula),
    CONSTRAINT fk_cm_medicina FOREIGN KEY (medicina_id) REFERENCES Medicinas(id)
);

INSERT INTO Cliente_Medicina (cliente_cedula, medicina_id, condicion, frecuencia, descuento)
VALUES ('15464546553', 1, 'diabetes', 'SEM', 0.25);

-------------------------------------------------
-- TABLA Medicinas_Tipo_ID
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Medicinas_Tipo_ID (
    id INT PRIMARY KEY AUTO_INCREMENT,
    medicina_id_gen INT NULL,
    medicina_id_com INT NULL,
    CONSTRAINT fk_mtid_gen FOREIGN KEY (medicina_id_gen) REFERENCES Medicinas(id),
    CONSTRAINT fk_mtid_com FOREIGN KEY (medicina_id_com) REFERENCES Medicinas(id)
);

-- GEN
INSERT INTO Medicinas_Tipo_ID (medicina_id_gen, medicina_id_com)
SELECT id, NULL FROM Medicinas WHERE tipo = 'GEN';

-- COM
INSERT INTO Medicinas_Tipo_ID (medicina_id_gen, medicina_id_com)
SELECT NULL, id FROM Medicinas WHERE tipo = 'COM';

-------------------------------------------------
-- TABLA EMPRESA
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Empresa (
    ruc CHAR(13) PRIMARY KEY,
    empresa VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(14),
    email VARCHAR(50)
);

-- Insertar empresa
INSERT INTO Empresa (ruc, razon_social, direccion, telefono, email)
VALUES ('1452637890478', 'Salud Total SA', 'Av 10 de Agosto', '096154544', 'jose@gmail.com');

INSERT INTO Empresa (ruc, razon_social, direccion, telefono, email)
VALUES ('1423698502001', 'LIFE SA', 'Inaquito', '096154714', 'elche@gmail.com');

-------------------------------------------------
-- TABLAS DE FACTURACIÓN
-------------------------------------------------

-- Factura cabecera (con empresa_ruc añadido)
CREATE TABLE IF NOT EXISTS Factura (
    factura_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_cedula VARCHAR(13),
    empresa_ruc CHAR(13),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) DEFAULT 0,
    CONSTRAINT fk_factura_cliente FOREIGN KEY (cliente_cedula) REFERENCES Clientes(cedula),
    CONSTRAINT fk_factura_empresa FOREIGN KEY (empresa_ruc) REFERENCES Empresa(ruc)
);

-- Detalle factura
CREATE TABLE IF NOT EXISTS Detalle_Factura (
    detalle_id INT PRIMARY KEY AUTO_INCREMENT,
    factura_id INT,
    medicina_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    CONSTRAINT fk_detalle_factura FOREIGN KEY (factura_id) REFERENCES Factura(factura_id),
    CONSTRAINT fk_detalle_medicina FOREIGN KEY (medicina_id) REFERENCES Medicinas(id)
);

-- Pagos
CREATE TABLE IF NOT EXISTS Pagos (
    pago_id INT PRIMARY KEY AUTO_INCREMENT,
    factura_id INT,
    metodo_pago VARCHAR(50),
    monto DECIMAL(10,2),
    CONSTRAINT fk_pago_factura FOREIGN KEY (factura_id) REFERENCES Factura(factura_id)
);

-------------------------------------------------
-------------------------------------------------
-- INSERTAR FACTURAS
-------------------------------------------------
-- BORRAR TABLAS SI EXISTEN (para que no se dupliquen)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Pagos;
TRUNCATE TABLE Detalle_Factura;
TRUNCATE TABLE Factura;
SET FOREIGN_KEY_CHECKS = 1;

-------------------------------------------------
-- 1. Crear facturas
-------------------------------------------------
INSERT INTO Factura (cliente_cedula, empresa_ruc, total)
VALUES ('15464546553', '1452637890478', 0);  -- factura_id = 1

INSERT INTO Factura (cliente_cedula, empresa_ruc, total)
VALUES ('51505505', '1452637890478', 0);     -- factura_id = 2

INSERT INTO Factura (cliente_cedula, empresa_ruc, total)
VALUES ('1800000002', '1452637890478', 0);  -- factura_id = 3

INSERT INTO Factura (cliente_cedula, empresa_ruc, total)
VALUES ('1800000002', '1423698502001', 0);  -- factura_id = 4

-------------------------------------------------
-- 2. Insertar detalle de facturas
-------------------------------------------------
INSERT INTO Detalle_Factura (factura_id, medicina_id, cantidad, precio_unitario, subtotal)
VALUES (1, 1, 2, 1.50, 3.00);

INSERT INTO Detalle_Factura (factura_id, medicina_id, cantidad, precio_unitario, subtotal)
VALUES (1, 4, 2, 3.50, 7.00);

INSERT INTO Detalle_Factura (factura_id, medicina_id, cantidad, precio_unitario, subtotal)
VALUES (2, 2, 1, 2.60, 2.60);

INSERT INTO Detalle_Factura (factura_id, medicina_id, cantidad, precio_unitario, subtotal)
VALUES (3, 3, 3, 3.50, 10.50);

-- Si quieres que la factura 4 tenga detalles:
INSERT INTO Detalle_Factura (factura_id, medicina_id, cantidad, precio_unitario, subtotal)
VALUES (4, 1, 1, 1.50, 1.50);

-------------------------------------------------
-- 3. Insertar pagos
-------------------------------------------------
INSERT INTO Pagos (factura_id, metodo_pago, monto)
VALUES (1, 'EFECTIVO', 10.00);

INSERT INTO Pagos (factura_id, metodo_pago, monto)
VALUES (2, 'TARJETA', 2.60);

INSERT INTO Pagos (factura_id, metodo_pago, monto)
VALUES (3, 'TRANSFERENCIA', 10.50);

INSERT INTO Pagos (factura_id, metodo_pago, monto)
VALUES (4, 'EFECTIVO', 1.50); -- Ahora corresponde al detalle agregado

-------------------------------------------------
-- 4. Actualizar totales de facturas
-------------------------------------------------
UPDATE Factura f
SET total = (
    SELECT SUM(d.subtotal)
    FROM Detalle_Factura d
    WHERE d.factura_id = f.factura_id
);

-------------------------------------------------
-- VER RESULTADOS
-------------------------------------------------
SELECT * FROM Empresa;
SELECT * FROM Factura;
SELECT * FROM Detalle_Factura;
SELECT * FROM Pagos;
SELECT * FROM Proveedor;
SELECT * FROM Proveedor_Medicina;

---
-- ALTER TABLE Cliente_Medicina
-- ADD CONSTRAINT cliente_cedula_fk
-- FOREIGN KEY (cliente_cedula)
-- REFERENCES Clientes(cedula);

-- ALTER TABLE Cliente_Medicina
-- ADD CONSTRAINT medicina_id_fk
-- FOREIGN KEY (medicina_id)
-- REFERENCES Medicinas(id);
---ACTUALIZAR TOTALES DE FACTURAS
-------------------------------------------------
-- TABLA Proveedor 
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Proveedor (
    ruc CHAR(13) PRIMARY KEY,
    nombre VARCHAR(100),
    contacto VARCHAR(50),
    email VARCHAR(50)
);

----Inserciones Proveedor (ruc, nombre, contacto, email)
INSERT INTO Proveedor (ruc, nombre, contacto, email)
VALUES ('1799999999001', 'BAYER SA', 'Carlos Pérez', 'contacto@bayer.com');


-------------------------------------------------
-- TABLA Proveedor_Medicina
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Proveedor_Medicina (
    proveedor_ruc CHAR(13),
    medicina_id INT,
    proveedor_precio DECIMAL(10,2),
    lote INT,
    plazo VARCHAR(50),

    PRIMARY KEY (proveedor_ruc, medicina_id),

    CONSTRAINT fk_pm_proveedor
        FOREIGN KEY (proveedor_ruc) REFERENCES Proveedor(ruc),

    CONSTRAINT fk_pm_medicina
        FOREIGN KEY (medicina_id) REFERENCES Medicinas(id)
);

----INSERCIONES Proveedor_Medicina
INSERT INTO Proveedor_Medicina
(proveedor_ruc, medicina_id, proveedor_precio, lote, plazo)
VALUES
('1799999999001', 1, 0.25, 100, '15 días');




