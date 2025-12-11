create DATABASE SaludTotal;
show databases;
use SaludTotal;

create table Medicinas
(
    id int primary key,
    nombre VARCHAR(100),
    tipo char(3), ---GEN O COM
    precio decimal (15,2),
    stock int,
    fechacaducidad DATETIME
);
desc medicinas;
CREATE TABLE Clientes
(
    cedula CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_nacimiento CHAR(100),
    persona_tipo CHAR(3)   -- NAT o JUR
);
---CLIENTES
insert into clientes 
values ('15464546553', 'Jose', '14-06-1985', 'NAT');

insert into clientes 
values ('51505505', 'Mario', '04-08-1995', 'NAT');

insert into clientes 
values ('1800000002', 'Paul', '22-06-2005', 'NAT');

select * FROM clientes;

show tables;

----MEDICINAS
insert into medicinas 
values (1, 'paracetamol', 'GEN', 1.50, 12, '2026-12-24 00:00:00');

insert into medicinas 
values (2, 'amoxiCilina ', 'GEN', 2.60, 30, '2026-11-24 00:00:00');

insert into medicinas 
values (3, 'penicilina ', 'GEN', 3.50, 12, '2026-08-24 00:00:00');

SELECT * FROM medicinas;

-- Crear tabla de descuentos
CREATE TABLE Descuentos
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_cliente CHAR(3),           -- NAT = Natural, JUR = Jurídica
    tipo_medicina CHAR(3),          -- GEN, ETC
    descuento_porcentaje DECIMAL(5,2),  -- Ej: 10 = 10%
    descripcion VARCHAR(200)
);

INSERT INTO Descuentos (tipo_cliente, tipo_medicina, descuento_porcentaje, descripcion)
VALUES ('NAT', 'DBT', 8.00, 'Descuento para gente con diabetes tipo 2 que usa Metformina');

INSERT INTO Descuentos (tipo_cliente, tipo_medicina, descuento_porcentaje, descripcion)
VALUES ('JUR', 'DBT', 12.00, 'Descuento para gente con diabetes tipo 1 que necesita Insulina');

INSERT INTO Descuentos (tipo_cliente, tipo_medicina, descuento_porcentaje, descripcion)
VALUES ('NAT', 'DBT', 6.00, 'Descuento para gente con diabetes que utiliza Glibenclamida');
SELECT * FROM Descuentos;

--------CLIENTES medicina

CREATE TABLE Cliente_Medicina
(
    cliente_cedula CHAR(10),
    medicina_id INT,
    condicion VARCHAR(100),
    frecuencia CHAR(3),
    descuento DECIMAL(5,2)
);
desc Cliente_Medicina;
--validacion clave foranea cedula cliente
alter table Cliente_Medicina
add CONSTRAINT cliente_cedula_fk  
FOREIGN key (cliente_cedula)
REFERENCES clientes(cliente_cedula);
--Validacion de la clave foranea medicina id 
ALTER Table Clente_Medicina
ADD constraint medicina_id_fk
Foreign Key (medicina_id)
REFERENCES medicina(id);
--
alter table Cliente_Medicina
add PRIMARY KEY medicina_id
---

INSERT INTO Cliente_Medicina
VALUES ('1248563954', 12, 'diabetes', 'SEM', 0.25);

select * FROM Cliente_Medicina;
---TIPO MEDICINAS
CREATE TABLE Medicinas_Tipo_ID
(
    medicina_id_gen INT,
    medicina_id_com INT
);
---INSERCION MEDICINAS 
INSERT INTO Medicinas_Tipo_ID (medicina_id_gen)
SELECT id FROM Medicinas WHERE tipo = 'GEN';
INSERT INTO Medicinas_Tipo_ID (medicina_id_com)
SELECT id FROM Medicinas WHERE tipo = 'COM';

SELECT * FROM Medicinas_Tipo_ID;
