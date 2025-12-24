-- BORRAR SI YA EXISTE
DROP DATABASE IF EXISTS SaludTotal;
CREATE DATABASE SaludTotal;
USE SaludTotal;
-------------------------------------------------
-- TABLA Medicinas
SELECT * FROM Medicinas;
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Medicinas (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo CHAR(3),   -- GEN o COM
    precio DECIMAL(15,2),
    stock INT,
    fechacaducidad DATETIME
);
--Uso de not null 
alter table Medicinas
Modify column nombre varchar (100) NOT NULL;
---Añadir default
ALTER TABLE Medicinas
MODIFY tipo CHAR(3) DEFAULT 'GEN';
--Verificacion solo se ingresan los valores que usamos GEN Y COM
alter table Medicinas
add constraint medicinas_tipo_val
check (
    tipo in ('GEN', 'COM')
);
---Nombre unico usando Unique 
alter table Medicinas
add constraint nombre_uq
UNIQUE (nombre);
--Comprobacion del uso default
INSERT INTO Medicinas (id, nombre, precio, stock, fechacaducidad)
VALUES
(5, 'aspirina', 1.80, 25, '2027-06-15 00:00:00');
-------------------------------------------------
-- INSERTAR MEDICINAS
-------------------------------------------------
INSERT INTO Medicinas (id, nombre, tipo, precio, stock, fechacaducidad)
VALUES
(1, 'paracetamol', 'GEN', 1.50, 12, '2026-12-24 00:00:00'),
(2, 'amoxicilina', 'GEN', 2.60, 30, '2026-11-24 00:00:00'),
(3, 'penicilina',  'GEN', 3.50, 12, '2026-08-24 00:00:00'),
(4, 'ibuprofeno',  'COM', 2.20, 40, '2027-01-01 00:00:00');
------
-- INSERTAR MEDICINAS 
-------------------------------------------------
INSERT INTO Medicinas (id, nombre, tipo, precio, stock, fechacaducidad)
VALUES
(6,  'azitromicina',     'GEN', 4.80,  35, '2027-03-10 00:00:00'),
(7,  'diclofenaco',      'GEN', 2.10,  60, '2026-12-30 00:00:00'),
(8,  'naproxeno',        'GEN', 2.40,  45, '2027-05-01 00:00:00'),
(9,  'loratadina',       'COM', 1.90,  80, '2027-06-20 00:00:00'),
(10, 'cetirizina',       'GEN', 2.00,  70, '2027-07-25 00:00:00'),
(11, 'metformina',       'GEN', 3.00,  100,'2028-01-10 00:00:00'),
(12, 'losartan',         'GEN', 3.50,  90, '2028-03-05 00:00:00'),
(13, 'amlodipino',       'GEN', 3.40,  85, '2028-04-12 00:00:00'),
(14, 'atorvastatina',    'COM', 6.20,  60, '2028-06-18 00:00:00'),
(15, 'simvastatina',     'GEN', 4.90,  55, '2028-07-30 00:00:00'),
(16, 'dexametasona',     'GEN', 2.80,  40, '2026-11-15 00:00:00'),
(17, 'prednisona',       'GEN', 2.70,  40, '2027-01-28 00:00:00'),
(18, 'hidrocortisona',   'GEN', 3.10,  35, '2027-02-28 00:00:00'),
(19, 'ketorolaco',       'GEN', 2.60,  50, '2026-10-31 00:00:00'),
(20, 'salbutamol',       'COM', 3.80,  75, '2027-03-22 00:00:00'),
(21, 'ambroxol',         'GEN', 2.30,  65, '2027-04-14 00:00:00'),
(22, 'bromhexina',       'GEN', 2.10,  60, '2027-05-26 00:00:00'),
(23, 'acetaminofen',     'GEN', 1.60,  90, '2026-12-24 00:00:00'),
(24, 'clotrimazol',      'GEN', 2.50,  55, '2027-06-10 00:00:00'),
(25, 'nistatina',        'GEN', 2.40,  45, '2027-07-08 00:00:00'),
(26, 'fluconazol',       'GEN', 3.90,  40, '2027-08-20 00:00:00'),
(27, 'omeprazol 20mg',   'COM', 4.10,  60, '2028-01-15 00:00:00'),
(28, 'ranitidina',       'GEN', 2.20,  30, '2026-09-30 00:00:00'),
(29, 'suero oral',       'GEN', 1.30,  120,'2026-08-15 00:00:00'),
(30, 'vitamina c',       'COM', 1.80,  200,'2027-02-01 00:00:00'),
(31, 'multivitaminico',  'COM', 4.50,  150,'2027-03-01 00:00:00'),
(32, 'omeprazol 40mg',   'GEN', 4.60,  40, '2028-02-10 00:00:00'),
(33, 'cefadroxilo',      'COM', 3.30,  75, '2027-09-12 00:00:00'),
(34, 'ceftriaxona',      'GEN', 5.50,  30, '2027-10-05 00:00:00'),
(35, 'metronidazol',     'GEN', 2.90,  70, '2027-11-11 00:00:00'),
(36, 'buscapina',        'COM', 3.20,  60, '2027-12-20 00:00:00'),
(37, 'omeprazol caps',   'COM', 3.90,  50, '2028-03-12 00:00:00'),
(38, 'meloxicam',        'COM', 3.10,  65, '2027-04-18 00:00:00'),
(39, 'dipirona',         'COM', 2.10,  110,'2027-05-22 00:00:00'),
(40, 'naproxeno sodico', 'GEN', 2.50,  70, '2027-06-30 00:00:00'),
(41, 'diclofenaco gel',  'COM', 3.60,  40, '2027-07-15 00:00:00'),
(42, 'omeprazol susp',   'COM', 4.00,  30, '2028-04-05 00:00:00'),
(43, 'lorazepam',        'GEN', 6.80,  25, '2028-05-20 00:00:00'),
(44, 'diazepam',         'GEN', 5.70,  25, '2028-06-18 00:00:00'),
(45, 'mirtazapina',      'GEN', 7.20,  20, '2028-07-25 00:00:00'),
(46, 'sertralina',       'GEN', 6.50,  35, '2028-08-10 00:00:00'),
(47, 'omeprazol tbl',    'COM', 3.80,  60, '2028-09-22 00:00:00'),
(48, 'hidroclorotiazida','GEN', 3.10,  70, '2028-10-30 00:00:00'),
(49, 'enalapril',        'GEN', 3.20,  90, '2028-11-15 00:00:00'),
(50, 'furosemida',       'GEN', 2.80,  80, '2028-12-01 00:00:00');
-- INSERTAR MEDICINAS (50 filas nuevas
-------------------------------------------------
INSERT INTO Medicinas (id, nombre, tipo, precio, stock, fechacaducidad)
VALUES
(51,  'pantoprazol',        'GEN', 4.30,  60, '2029-01-20 00:00:00'),
(52,  'esomeprazol',        'COM', 5.10,  55, '2029-02-10 00:00:00'),
(53,  'lansoprazol',        'GEN', 4.00,  50, '2029-03-15 00:00:00'),
(54,  'rabeprazol',         'COM', 5.40,  45, '2029-04-05 00:00:00'),
(55,  'sucralfato',         'GEN', 3.10,  70, '2029-05-10 00:00:00'),
(56,  'misoprostol',        'COM', 6.80,  25, '2029-06-22 00:00:00'),
(57,  'famotidina',         'GEN', 2.60,  80, '2029-07-12 00:00:00'),
(58,  'nizatidina',         'GEN', 2.90,  60, '2029-08-08 00:00:00'),
(59,  'montelukast',        'COM', 4.20,  75, '2029-09-01 00:00:00'),
(60,  'tiotropio',          'COM', 7.30,  40, '2029-10-10 00:00:00'),
(61,  'budesonida',         'COM', 6.50,  50, '2029-01-05 00:00:00'),
(62,  'formoterol',         'COM', 5.90,  45, '2029-02-18 00:00:00'),
(63,  'fluticasona',        'COM', 6.70,  45, '2029-03-22 00:00:00'),
(64,  'beclometasona',      'GEN', 5.10,  55, '2029-04-28 00:00:00'),
(65,  'celecoxib',          'COM', 5.80,  60, '2029-05-30 00:00:00'),
(66,  'piroxicam',          'GEN', 3.40,  70, '2029-06-19 00:00:00'),
(67,  'tramadol',           'GEN', 4.90,  50, '2029-07-07 00:00:00'),
(68,  'morfina',            'COM', 12.50, 20, '2029-08-25 00:00:00'),
(69,  'codeina',            'GEN', 6.20,  35, '2029-09-14 00:00:00'),
(70,  'aciclovir',          'GEN', 3.80,  65, '2029-10-02 00:00:00'),
(71,  'oseltamivir',        'COM', 7.90,  30, '2029-11-11 00:00:00'),
(72,  'terbinafina',        'GEN', 4.40,  60, '2029-12-08 00:00:00'),
(73,  'itraconazol',        'COM', 6.10,  40, '2029-12-20 00:00:00'),
(74,  'clindamicina',       'GEN', 4.40,  40, '2029-01-15 00:00:00'),
(75,  'gentamicina',        'GEN', 5.20,  35, '2029-02-12 00:00:00'),
(76,  'tobramicina',        'COM', 5.60,  35, '2029-03-10 00:00:00'),
(77,  'amikacina',          'GEN', 6.00,  30, '2029-04-06 00:00:00'),
(78,  'neomicina',          'GEN', 3.30,  50, '2029-05-04 00:00:00'),
(79,  'cefepime',           'COM', 7.40,  28, '2029-06-01 00:00:00'),
(80,  'ceftazidima',        'COM', 7.60,  28, '2029-06-20 00:00:00'),
(81,  'meropenem',          'COM', 10.90, 22, '2029-07-18 00:00:00'),
(82,  'imipenem',           'COM', 11.20, 20, '2029-08-08 00:00:00'),
(83,  'ertapenem',          'COM', 9.80,  24, '2029-09-09 00:00:00'),
(84,  'tigeciclina',        'COM', 12.30, 18, '2029-10-15 00:00:00'),
(85,  'linezolid',          'COM', 12.50, 15, '2029-11-05 00:00:00'),
(86,  'daptomicina',        'COM', 13.20, 14, '2029-12-02 00:00:00'),
(87,  'warfarina',          'GEN', 4.80,  40, '2029-01-09 00:00:00'),
(88,  'clopidogrel',        'COM', 6.90,  45, '2029-02-03 00:00:00'),
(89,  'enoxaparina',        'COM', 9.20,  30, '2029-03-06 00:00:00'),
(90,  'heparina',           'GEN', 8.10,  30, '2029-04-09 00:00:00'),
(91,  'aspirinag',           'GEN', 1.60,  200,'2029-05-12 00:00:00'),
(92,  'carvedilol',         'GEN', 3.70,  60, '2029-06-14 00:00:00'),
(93,  'bisoprolol',         'GEN', 3.80,  60, '2029-07-16 00:00:00'),
(94,  'propranolol',        'GEN', 3.20,  70, '2029-08-18 00:00:00'),
(95,  'atenolol',           'GEN', 3.10,  70, '2029-09-20 00:00:00'),
(96,  'verapamilo',         'GEN', 3.90,  55, '2029-10-22 00:00:00'),
(97,  'diltiazem',          'COM', 4.20,  50, '2029-11-24 00:00:00'),
(98,  'indapamida',         'GEN', 3.30,  65, '2029-12-26 00:00:00'),
(99,  'espironolactona',    'GEN', 2.90,  80, '2029-01-28 00:00:00'),
(100, 'clortalidona',       'GEN', 3.00,  85, '2029-02-15 00:00:00');
----------------------------------
-- TABLA CLIENTES
SELECT * FROM Clientes;
-------------------------------------------------
CREATE TABLE IF NOT EXISTS Clientes (
    cedula VARCHAR(13) PRIMARY KEY,
    nombre VARCHAR(100),
    fecha_nacimiento CHAR(10), 
    persona_tipo CHAR(3)       -- NAT o JUR
);
---Add email
ALTER TABLE Clientes
ADD email VARCHAR(100);
-- Datos de ejemplo clientes 
INSERT INTO Clientes (cedula, nombre, fecha_nacimiento, persona_tipo)
VALUES
('15464546553', 'Jose', '1985-06-14', 'NAT'),
('51505505', 'Mario', '1995-08-04', 'NAT'),
('1800000002', 'Paul', '2005-06-22', 'NAT');
--Actualizar Registros 
UPDATE Clientes
SET email = 'jose@gmail.com'
WHERE cedula = '15464546553';
UPDATE Clientes
SET email = 'mario@gmail.com'
WHERE cedula = '51505505';
UPDATE Clientes
SET email = 'paul@gmail.com'
WHERE cedula = '1800000002';
---Atributo Email unico en tabla cliente
alter table Clientes
add constraint cliente_emailuq
unique (email);
-- Inserciones con la columna email añadida
INSERT INTO Clientes (cedula, nombre, fecha_nacimiento, persona_tipo, email) VALUES
('4254475496', 'Marco Silva', '1999-07-17', 'NAT', 'marco.silva@gmail.com'),
('7892586064', 'Camila García', '2003-06-05', 'JUR', 'camila.garcia@gmail.com'),
('7213424104', 'Santiago Núñez', '1990-01-18', 'NAT', 'santiago.nunez@gmail.com'),
('9783197330', 'Santiago Silva', '2003-08-19', 'JUR', 'santiago.silva@gmail.com'),
('7903762770', 'Patricia Molina', '2001-08-06', 'NAT', 'patricia.molina@gmail.com'),
('1754110338', 'Liliana Gómez', '2004-11-05', 'JUR', 'liliana.gomez@gmail.com'),
('1936002916', 'Carolina Navarro', '1997-12-26', 'NAT', 'carolina.navarro@gmail.com'),
('4353090950', 'Rosa Reyes', '2003-02-10', 'JUR', 'rosa.reyes@gmail.com'),
('6591304842', 'Patricia Castro', '1991-05-24', 'NAT', 'patricia.castro@gmail.com'),
('6828641798', 'Luisa Suárez', '2007-08-29', 'JUR', 'luisa.suarez@gmail.com'),
('4626348989', 'Andrés Navarro', '2008-08-31', 'NAT', 'andres.navarro@gmail.com'),
('1138457210', 'Ana Fuentes', '2001-04-15', 'JUR', 'ana.fuentes@gmail.com'),
('6529067996', 'Ana Ramos', '2010-11-03', 'NAT', 'ana.ramos@gmail.com'),
('7059150369', 'Santiago Silva', '1991-03-28', 'JUR', 'santiago.silva2@gmail.com'),
('6166332414', 'María Reyes', '1994-03-04', 'NAT', 'maria.reyes@gmail.com'),
('8021379270', 'Mónica Ibarra', '2002-11-07', 'JUR', 'monica.ibarra@gmail.com'),
('5158849661', 'Víctor López', '1991-09-16', 'NAT', 'victor.lopez@gmail.com'),
('4491293600', 'Diego Villalba', '2005-01-23', 'JUR', 'diego.villalba@gmail.com'),
('4397883234', 'Arturo Suárez', '2002-02-07', 'NAT', 'arturo.suarez@gmail.com'),
('5077312137', 'Isabel Ortega', '1994-05-10', 'JUR', 'isabel.ortega@gmail.com'),
('4458155431', 'Arturo Ramos', '2003-06-28', 'NAT', 'arturo.ramos@gmail.com'),
('3791111884', 'José Ibarra', '2004-05-20', 'JUR', 'jose.ibarra@gmail.com'),
('7164437424', 'Paula Carrillo', '1993-03-28', 'NAT', 'paula.carrillo@gmail.com'),
('7197177304', 'Juan Pineda', '1990-03-05', 'JUR', 'juan.pineda@gmail.com'),
('5734768979', 'Valeria Pineda', '2003-08-03', 'NAT', 'valeria.pineda@gmail.com'),
('5785524334', 'Liliana Martínez', '2009-10-26', 'JUR', 'liliana.martinez@gmail.com'),
('9979102292', 'Arturo Peña', '1996-05-20', 'NAT', 'arturo.pena@gmail.com'),
('6570550426', 'Andrés Martínez', '2008-02-08', 'JUR', 'andres.martinez@gmail.com'),
('6709151644', 'Alejandra Herrera', '1992-08-02', 'NAT', 'alejandra.herrera@gmail.com'),
('3903959333', 'Ricardo Espinoza', '1996-05-09', 'JUR', 'ricardo.espinoza@gmail.com'),
('6435079973', 'Santiago Pérez', '1997-01-17', 'NAT', 'santiago.perez@gmail.com'),
('8256156392', 'Diego Vázquez', '1992-09-17', 'JUR', 'diego.vazquez@gmail.com'),
('4687393968', 'Gabriela Delgado', '1999-07-20', 'NAT', 'gabriela.delgado@gmail.com'),
('7462018978', 'Andrés Flores', '2007-10-09', 'JUR', 'andres.flores@gmail.com'),
('1328910130', 'Patricia Torres', '1994-02-24', 'NAT', 'patricia.torres@gmail.com'),
('2184948256', 'Andrea Aguilar', '1990-03-14', 'JUR', 'andrea.aguilar@gmail.com'),
('3686086080', 'Alejandra Álvarez', '1996-12-02', 'NAT', 'alejandra.alvarez@gmail.com'),
('8196415424', 'Diego Ramos', '2010-02-20', 'JUR', 'diego.ramos@gmail.com'),
('2197812876', 'Andrea Vázquez', '1996-02-12', 'NAT', 'andrea.vazquez@gmail.com'),
('4487934153', 'Víctor Mendoza', '2004-10-25', 'JUR', 'victor.mendoza@gmail.com'),
('8452260877', 'Ricardo Suárez', '2010-11-28', 'NAT', 'ricardo.suarez@gmail.com'),
('8169723952', 'Marco García', '2007-09-09', 'JUR', 'marco.garcia@gmail.com'),
('4076588972', 'Paula García', '1992-09-02', 'NAT', 'paula.garcia@gmail.com'),
('8064007774', 'Raúl Guerrero', '1996-05-26', 'JUR', 'raul.guerrero@gmail.com'),
('9115691003', 'Pedro Ibarra', '2009-08-21', 'NAT', 'pedro.ibarra@gmail.com'),
('1545092175', 'Alejandra Espinoza', '1995-11-30', 'JUR', 'alejandra.espinoza@gmail.com'),
('8729551629', 'Luisa Molina', '1990-06-22', 'NAT', 'luisa.molina@gmail.com'),
('1859270323', 'Lorena Ramos', '2000-09-25', 'JUR', 'lorena.ramos@gmail.com'),
('3849036457', 'Francisco Herrera', '2006-06-03', 'NAT', 'francisco.herrera@gmail.com'),
('2549378583', 'Santiago García', '1994-12-28', 'JUR', 'santiago.garcia@gmail.com');

-------------------------------------------------
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
--INSERTS MEDICINA FRECUENTE
INSERT INTO Cliente_Medicina (cliente_cedula, medicina_id, condicion, frecuencia, descuento)
VALUES ('15464546553', 1, 'diabetes', 'SEM', 0.25);

INSERT INTO Cliente_Medicina (cliente_cedula, medicina_id, condicion, frecuencia, descuento) VALUES
('4254475496', 11, 'diabetes', 'DIA', 0.25),        -- metformina
('7892586064', 12, 'hipertensión', 'DIA', 0.20),    -- losartan
('7213424104', 13, 'hipertensión', 'DIA', 0.22),    -- amlodipino
('9783197330', 14, 'colesterol alto', 'DIA', 0.18), -- atorvastatina
('7903762770', 15, 'colesterol alto', 'DIA', 0.17), -- simvastatina
('1754110338', 20, 'asma', 'DIA', 0.15),            -- salbutamol
('1936002916', 9,  'alergias', 'DIA', 0.10),        -- loratadina
('4353090950', 10, 'alergias', 'DIA', 0.10),        -- cetirizina
('6591304842', 27, 'gastritis/reflujo', 'DIA', 0.16), -- omeprazol 20mg
('6828641798', 28, 'gastritis', 'DIA', 0.12),       -- ranitidina
('4626348989', 32, 'gastritis/reflujo', 'DIA', 0.18), -- omeprazol 40mg
('1138457210', 51, 'gastritis/reflujo', 'DIA', 0.20), -- pantoprazol
('6529067996', 52, 'gastritis/reflujo', 'DIA', 0.19), -- esomeprazol
('7059150369', 16, 'inflamación', 'SEM', 0.12),     -- dexametasona
('6166332414', 43, 'ansiedad', 'DIA', 0.15),        -- lorazepam
('8021379270', 46, 'depresión', 'DIA', 0.20),       -- sertralina
('5158849661', 44, 'ansiedad', 'DIA', 0.14),        -- diazepam
('4491293600', 21, 'tos', 'DIA', 0.08),             -- ambroxol
('4397883234', 22, 'tos', 'DIA', 0.08),             -- bromhexina
('5077312137', 33, 'infección', 'DIA', 0.12),       -- cefadroxilo
('4458155431', 34, 'infección', 'DIA', 0.15),       -- ceftriaxona
('3791111884', 35, 'infección', 'DIA', 0.11),       -- metronidazol
('7164437424', 7,  'dolor/inflamación', 'DIA', 0.10), -- diclofenaco
('7197177304', 8,  'dolor/inflamación', 'DIA', 0.10), -- naproxeno
('5734768979', 19, 'dolor agudo', 'DIA', 0.12),     -- ketorolaco
('5785524334', 1,  'fiebre/dolor', 'DIA', 0.08),    -- paracetamol
('9979102292', 4,  'dolor/inflamación', 'DIA', 0.09), -- ibuprofeno
('6570550426', 12, 'hipertensión', 'DIA', 0.21),    -- losartan
('6709151644', 11, 'diabetes', 'DIA', 0.25),        -- metformina
('3903959333', 14, 'colesterol alto', 'DIA', 0.18), -- atorvastatina
('6435079973', 15, 'colesterol alto', 'DIA', 0.17), -- simvastatina
('8256156392', 29, 'deshidratación', 'DIA', 0.06),  -- suero oral
('4687393968', 30, 'inmunidad', 'DIA', 0.05),       -- vitamina c
('7462018978', 31, 'fatiga', 'DIA', 0.07),          -- multivitamínico
('1328910130', 41, 'dolor muscular', 'SEM', 0.10),  -- diclofenaco gel
('2184948256', 47, 'gastritis/reflujo', 'DIA', 0.16), -- omeprazol tbl
('3686086080', 37, 'gastritis/reflujo', 'DIA', 0.15), -- omeprazol caps
('8196415424', 42, 'gastritis/reflujo', 'DIA', 0.15), -- omeprazol susp
('2197812876', 48, 'hipertensión', 'DIA', 0.18),    -- hidroclorotiazida
('4487934153', 49, 'hipertensión', 'DIA', 0.19),    -- enalapril
('8452260877', 50, 'retención de líquidos', 'DIA', 0.14), -- furosemida
('8169723952', 91, 'dolor/fiebre', 'DIA', 0.08),    -- aspirinag (aspirina)
('4076588972', 92, 'hipertensión', 'DIA', 0.18),    -- carvedilol
('8064007774', 93, 'hipertensión', 'DIA', 0.18),    -- bisoprolol
('9115691003', 94, 'taquicardia', 'DIA', 0.17),     -- propranolol
('1545092175', 95, 'hipertensión', 'DIA', 0.17),    -- atenolol
('8729551629', 96, 'arritmia', 'DIA', 0.16),        -- verapamilo
('1859270323', 97, 'arritmia', 'DIA', 0.16),        -- diltiazem
('3849036457', 99, 'hipertensión', 'DIA', 0.15),    -- espironolactona
('2549378583', 100,'hipertensión', 'DIA', 0);

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

INSERT INTO Medicinas_Tipo_ID (medicina_id_gen, medicina_id_com)
VALUES
(23, 30),  -- acetaminofen GEN ↔ vitamina C COM
(7, 4),    -- diclofenaco GEN ↔ ibuprofeno COM
(11, 14);  -- metformina GEN ↔ atorvastatina COM

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

INSERT INTO Empresa (ruc, razon_social, direccion, telefono, email)
VALUES
('0999999999001', 'Farmacia Central',    'La Carolina',         '0987456321', 'central@gmail.com'),
('0999999999002', 'Medisalud Cia Ltda',  'Chillogallo',         '0974563214', 'medisalud@gmail.com'),
('0999999999003', 'Vida Sana SA',        'El Inca',             '0963214785', 'vidasana@gmail.com'),
('0999999999004', 'Pharma Plus',         'La Mariscal',         '0958741236', 'pharmaplus@gmail.com'),
('0999999999005', 'Clinifarma',          'Carcelén',            '0945612387', 'clinifarma@gmail.com'),
('0999999999006', 'Salud y Vida',        'Cotocollao',          '0932145879', 'saludyvida@gmail.com'),
('0999999999007', 'Medic Farma',         'San Carlos',          '0921458796', 'medicfarma@gmail.com'),
('0999999999008', 'Farmared SA',         'Ponceano',            '0912547896', 'farmared@gmail.com');

-------------------------------------------------
-- TABLAS DE FACTURACIÓN
-------------------------------------------------
select * from factura;
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
INSERT INTO Factura (cliente_cedula, empresa_ruc, total) VALUES
('15464546553', '1452637890478', 0), -- 
('51505505',     '1452637890478', 0), -- 
('1800000002',   '1452637890478', 0), -- 
('1800000002',   '1423698502001', 0), -- 
('15464546553', '1423698502001', 0), -- 
('51505505',     '1452637890478', 0), -- 
('1800000002',   '1452637890478', 0), -- 
('15464546553', '1452637890478', 0), -- 
('51505505',     '1423698502001', 0), -- 
('1800000002',   '1423698502001', 0); -- 

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
INSERT INTO Detalle_Factura (factura_id, medicina_id, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 2, 1.50, 3.00),
(1, 4, 1, 3.50, 3.50),
(2, 2, 1, 2.60, 2.60),
(3, 3, 3, 3.50, 10.50),
(4, 1, 1, 1.50, 1.50),
(5, 4, 2, 3.50, 7.00),
(6, 2, 2, 2.60, 5.20),
(7, 3, 1, 3.50, 3.50),
(8, 1, 4, 1.50, 6.00),
(9, 4, 1, 3.50, 3.50);
INSERT INTO Detalle_Factura (factura_id, medicina_id, cantidad, precio_unitario, subtotal)
VALUES
(10, 1, 2, 1.50, 3.00),
(10, 4, 1, 3.50, 3.50),
(11, 2, 1, 2.60, 2.60),
(11, 7, 2, 2.10, 4.20),
(12, 3, 3, 3.50, 10.50),
-- Factura 13
(13, 11, 1, 3.00, 3.00),
(13, 12, 1, 3.50, 3.50),
-- Factura 14
(14, 1, 2, 1.50, 3.00),
(14, 4, 1, 3.50, 3.50);

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

INSERT INTO Pagos (factura_id, metodo_pago, monto) VALUES
(1, 'EFECTIVO', 6.50),
(2, 'TARJETA', 2.60),
(3, 'TRANSFERENCIA', 10.50),
(4, 'EFECTIVO', 1.50),
(5, 'EFECTIVO', 7.00),
(6, 'TARJETA', 5.20),
(7, 'EFECTIVO', 3.50),
(8, 'TRANSFERENCIA', 6.00),
(9, 'EFECTIVO', 3.50),
(10, 'TARJETA', 0.00);

INSERT INTO Pagos (factura_id, metodo_pago, monto)
VALUES
(10, 'EFECTIVO', 6.50),
(11, 'TARJETA', 6.80),
(12, 'TRANSFERENCIA', 10.50),
(13, 'EFECTIVO', 6.50),
(14, 'EFECTIVO', 6.50);

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
SELECT * FROM Cliente_Medicina;

---
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
