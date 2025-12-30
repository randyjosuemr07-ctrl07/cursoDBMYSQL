USE SaludTotal;

--CASO: clientes que su nombre empieza por letra A 
SELECT
    cedula,
    nombre
from clientes
where nombre like 'A%';
--CASO: Id medicinas que su nombre empieza por letra f 
SELECT
    id,
    nombre
from medicinas
where nombre like 'F%';
--Buscar por Nombre
SELECT
    cedula,
    nombre
from clientes
where nombre like 'Juan%';
--Buscar por Nombre y Apellido en el mismo campo 
SELECT
    cedula,
    nombre
from clientes
where nombre like '%Herrera%';
--Buscar por Nombre y Apellido en el mismo campo y que tipo de persona es nat o jur 
SELECT cedula, nombre, persona_tipo
FROM clientes
WHERE nombre LIKE '%Francisco Herrera%'
    AND persona_tipo = 'NAT';
--Clientes cuyo email tenga dominio gmail y sea juridica jur
SELECT cedula, nombre, email
FROM clientes
WHERE email LIKE '%@gmail.com'
    AND persona_tipo = 'JUR';
--Medicinas busacar si es com  y si cuesta menos de 3 dolares operador de comparacion
SELECT id, nombre, tipo, precio, stock, fechacaducidad
FROM Medicinas
WHERE tipo = 'COM'
    AND precio < 3;
--y hagamos otra que busque que tenga un stock mayor a 5 y sea gen
SELECT id, nombre, tipo, precio, stock, fechacaducidad
FROM Medicinas
WHERE tipo = 'GEN'
    AND stock > 5;
--Verificar el numero de medicina frecuente
select count(*)
from Cliente_Medicina;
--Consultar pacinetes del plan medicina frecuente con suconsultas
----Consultar medicina frecuente
---Uso de Alias
select 
    cliente_cedula as cedula,
    (select nombre from clientes where cedula = cliente_cedula) as cliente,
    medicina_id as id,
    (select nombre from medicinas where id = medicina_id)as medicina,
    descuento
FROM Cliente_Medicina;
--Listar los clientes y medicinas que tienen un descuento menor 
--al descuento de cliente con cedula: 1138457210
select 
    cliente_cedula as cedula,
    (select nombre from clientes where cedula = cliente_cedula) as cliente,
    medicina_id as id,
    (select nombre from medicinas where id = medicina_id)as medicina,
    descuento
FROM 
    Cliente_Medicina
where descuento < (
                    select descuento 
                    from Cliente_Medicina
                    where cliente_cedula='1138457210'
                    );
---listado de medicina frecuente presente el precio final y el precio sin descuento
SELECT 
    medicina_id AS id,
    (SELECT nombre FROM Medicinas WHERE id = medicina_id) AS medicina,
    (SELECT precio FROM Medicinas WHERE id = medicina_id) AS precio_sin_descuento,
    descuento,
    (SELECT precio FROM Medicinas WHERE id = medicina_id) * (1 - descuento / 100) 
        AS precio_final
FROM Cliente_Medicina
WHERE medicina_id = 4;
--Medicinas comerciales puede ser reemplazadas por su correspondiente medicina generica
--Hacer un listado que compare precio de medicina comercial con
-- su equivalente generico
----Muestra ambos datos 
SELECT
    (SELECT nombre FROM Medicinas WHERE id = medicina_id_gen) AS nombre_generica,
    (SELECT precio FROM Medicinas WHERE id = medicina_id_gen) AS precio_generica,
    (SELECT nombre FROM Medicinas WHERE id = medicina_id_com) AS nombre_comercial,
    (SELECT precio FROM Medicinas WHERE id = medicina_id_com) AS precio_comercial
FROM Medicinas_Tipo_ID
WHERE 4 IN (medicina_id_gen, medicina_id_com);
---Lo mismo con el uso del join
SELECT
    gen.nombre   AS nombre_generica,
    gen.precio   AS precio_generica,
    com.nombre   AS nombre_comercial,
    com.precio   AS precio_comercial
FROM Medicinas_Tipo_ID mti
LEFT JOIN Medicinas gen ON gen.id = mti.medicina_id_gen
LEFT JOIN Medicinas com ON com.id = mti.medicina_id_com
WHERE 4 IN (mti.medicina_id_gen, mti.medicina_id_com);
--Crear combinaciones con todas las combinaciones entre 
--Tabla clientes y tabla medicina frefcuente
--Producto cartesiano
select *
FROM
    clientes,
    Cliente_Medicina
WHERE
    clientes.cedula = Cliente_Medicina.cliente_cedula;
--Crear combinaciones con todas las combinaciones entre 
--Tabla medicina y tabla medicina frefcuente
--Producto cartesiano
select *
FROM
    medicinas,
    Cliente_Medicina
WHERE
    Medicinas.id = Cliente_Medicina.medicina_id;
---Ejemplo
---
select 
    c.cedula,
    c.nombre,
    m.nombre,
    mf.descuento,
    m.tipo
FROM
    cliente_medicina mf
JOIN clientes c on c.cedula = mf.cliente_cedula
JOIN medicinas m on m.id = mf.medicina_id
WHERE
    m.tipo = 'COM';
----Para VER VERIFICAR LA MEDICINA Y SU TIPO 
----
SELECT 
    mcom.id,
    mcom.nombre,
    mt.medicina_id_gen
FROM 
    Medicinas_Tipo_ID mt
JOIN Medicinas mcom ON mcom.id = mt.medicina_id_com
JOIN Medicinas mgen ON mgen.id = mt.medicina_id_gen;
--Presentar una factura y su detalle que incluye 
--Datos de Farcmacia:nombre, ruc , correo 
--Datos de cliente: 
--Datos de cabecera de factura: #, fecha
--Medicinas vendidas: nombre, id, cantidad, precio, calculo subtotal
--Al final: total y forma de pago
--Usar datos ya existenetes
--1.Cargar datos en facturas cabecera y detalle 
--Datos del cliente + empresa + factura
SELECT
    f.factura_id,
    f.fecha,
    c.cedula,
    c.nombre AS cliente,
    e.ruc,
    e.razon_social AS empresa
FROM Factura f
JOIN Clientes c ON c.cedula = f.cliente_cedula
JOIN Empresa e ON e.ruc = f.empresa_ruc
WHERE f.factura_id = 1;
--2️.SELECT — Detalle de factura
SELECT
    m.id AS medicina_id,
    m.nombre AS medicina,
    d.cantidad,
    d.precio_unitario,
    d.subtotal
FROM Detalle_Factura d
JOIN Medicinas m ON m.id = d.medicina_id
WHERE d.factura_id = 1;
--3.SELECT — Pie de factura
SELECT
    f.factura_id,
    f.total,
    p.metodo_pago,
    p.monto
FROM Factura f
JOIN Pagos p ON p.factura_id = f.factura_id
WHERE f.factura_id = 6;
--Medicina GEN más cara
SELECT
    id,
    nombre,
    tipo,
    precio
FROM Medicinas
WHERE tipo = 'GEN'
ORDER BY precio DESC
LIMIT 1;
--Medicina COM más barata
SELECT
    id,
    nombre,
    tipo,
    precio
FROM Medicinas
WHERE tipo = 'COM'
ORDER BY precio ASC
LIMIT 1;
--5 medicinas con menor descuento
SELECT
    medicina_id AS id,
    (SELECT nombre FROM Medicinas WHERE id = medicina_id) AS medicina,
    descuento
FROM Cliente_Medicina
ORDER BY descuento ASC
LIMIT 5;
--Busqueda medicinas
SELECT DISTINCT
    m.id,
    m.nombre,
    cm.descuento
FROM Medicinas m
JOIN Cliente_Medicina cm ON cm.medicina_id = m.id
WHERE 
    m.tipo = 'COM'
ORDER BY 
    cm.descuento ASC
LIMIT 5;
--
SELECT *
FROM Medicinas
WHERE nombre LIKE '%paracetamol%';
---
select 
    tipo,
    sum(precio * stock)
from medicinas 
GROUP BY
    tipo;
--Factura detalle valor monetario x medicina vendida
SELECT
    medicina_id,
    SUM(cantidad * precio_unitario) AS total_vendido
FROM Detalle_Factura
GROUP BY 
    medicina_id
ORDER BY 
    medicina_id;
--El mejor cliente 
SELECT
    c.cedula,
    c.nombre,
    SUM(df.cantidad * df.precio_unitario) AS total_gastado
FROM Factura f
JOIN Clientes c ON c.cedula = f.cliente_cedula
JOIN Detalle_Factura df ON df.factura_id = f.factura_id
GROUP BY
    c.cedula,
    c.nombre
ORDER BY
    total_gastado DESC
LIMIT 1;
---------Union de consultas
CREATE VIEW v_proyeccion_ventas AS
SELECT            -- Medicinas con descuento
    mf.medicina_id,
    m.nombre,
    m.precio,
    m.stock,
    mf.descuento,         
    m.precio * (1 - mf.descuento / 100) AS nuevo_precio
FROM Cliente_Medicina mf
JOIN Medicinas m 
    ON m.id = mf.medicina_id

UNION

SELECT          -- Medicinas sin descuento
    m.id AS medicina_id,
    m.nombre,
    m.precio,
    m.stock,
    0 AS descuento,
    m.precio AS nuevo_precio
FROM Medicinas m
LEFT JOIN Cliente_Medicina mf
    ON m.id = mf.medicina_id
WHERE mf.medicina_id IS NULL;
--- proyeccion del create view
SELECT  
    sum(precio * stock)
FROM
    v_proyeccion_ventas;
--================
--Averiguar que medicinas vencen en el proximo mes 
SELECT
    id,
    nombre,
    fechacaducidad
FROM Medicinas
WHERE fechacaducidad >= CURDATE()
    AND fechacaducidad < DATE_ADD(CURDATE(), INTERVAL 1 MONTH)

UNION ALL

SELECT
    NULL AS id,
    'NO HAY MEDICINAS QUE VENCAN EL PRÓXIMO MES' AS nombre,
    NULL AS fechacaducidad
WHERE NOT EXISTS (
    SELECT 1
    FROM Medicinas
    WHERE fechacaducidad >= CURDATE()
        AND fechacaducidad < DATE_ADD(CURDATE(), INTERVAL 1 MONTH)
);

--Ver fechas de vencimiento
SELECT id, nombre, fechacaducidad
FROM Medicinas;
--Verificar cuantos años para llegar a esa fecha de caducidad
SELECT
    id,
    nombre,
    fechacaducidad
FROM Medicinas
WHERE fechacaducidad BETWEEN CURDATE()
    AND DATE_ADD(CURDATE(), INTERVAL 2 YEAR);
--Cronograma de medicina a 3 meses vista 
SELECT
    id,
    nombre,
    fechacaducidad
FROM Medicinas
WHERE fechacaducidad >= CURDATE()
    AND fechacaducidad < DATE_ADD(CURDATE(), INTERVAL 3 MONTH)

UNION ALL

SELECT
    NULL AS id,
    'NO HAY MEDICINAS QUE VENCAN EN LOS PRÓXIMOS 3 MESES' AS nombre,
    NULL AS fechacaducidad
WHERE NOT EXISTS (
    SELECT 1
    FROM Medicinas
    WHERE fechacaducidad >= CURDATE()
        AND fechacaducidad < DATE_ADD(CURDATE(), INTERVAL 3 MONTH)
)
ORDER BY fechacaducidad;
--Caso: Kardex de la farmacia 
    --Movimientos de entrada y salida por medicina
    --Stock inicial por periodo
    --Compras, alta por inventario, donaciones, etc
    --Ventas, bajas por inventario, vencimiento, etc
--Resultado stock final
--Metodo para valorar: promedio, fifo y lifo
-- Ya NO creamos proveedor, asumimos que ya existe

-- Crear ordencompra
CREATE TABLE ordencompra(
    numero INT PRIMARY KEY,
    proveedor_ruc CHAR(13),
    fecha DATE
);

-- Relación con la tabla proveedor existente
ALTER TABLE ordencompra
ADD CONSTRAINT ordencompra_proveedor_fk
FOREIGN KEY (proveedor_ruc)
REFERENCES proveedor(ruc);
--INSERTS


-- Crear detalle de orden de compra
CREATE TABLE ordencompra_detalle(
    ordennumero INT,
    medicamento_id INT,
    cantidad DECIMAL(15,2),
    costo DECIMAL(15,2)
);
--INSERTS

-- Primary Key compuesta
ALTER TABLE ordencompra_detalle
ADD PRIMARY KEY (ordennumero, medicamento_id);

-- Relación con ordencompra
ALTER TABLE ordencompra_detalle
ADD CONSTRAINT ordencompra_detalle_orden_fk
FOREIGN KEY (ordennumero)
REFERENCES ordencompra(numero);

-- Relación con medicinas (PARA VINCULAR EL KARDEX CON STOCK)
ALTER TABLE ordencompra_detalle
ADD CONSTRAINT ordencompra_detalle_medicina_fk
FOREIGN KEY (medicamento_id)
REFERENCES medicinas(id);
-- Pruebas
SELECT * FROM proveedor;
SELECT * FROM ordencompra;
SELECT * FROM ordencompra_detalle;
---========
CREATE TABLE IF NOT EXISTS Compras_Medicinas (
    compra_id INT AUTO_INCREMENT PRIMARY KEY,
    medicina_id INT,
    fecha DATE,
    cantidad INT,
    costo_unitario DECIMAL(10,2),
    FOREIGN KEY (medicina_id) REFERENCES Medicinas(id)
);
--==========
--INSERTS
-- Insertar proveedores (si no los tienes aún)
INSERT INTO proveedor (ruc, nombre) VALUES
('0999999999999', 'Proveedor A'),
('0888888888888', 'Proveedor B');

UPDATE proveedor
SET ruc = '1799999999001'
WHERE nombre = 'Bayer S.A.';
UPDATE proveedor
SET contacto = 'Ana López', email = 'contacto@proveedorb.com'
WHERE ruc = '0888888888888';
UPDATE proveedor
SET contacto = 'Juan Pérez', email = 'contacto@bayersa.com'
WHERE ruc = '0777777777777';
SELECT * FROM proveedor;
--=================
CREATE OR REPLACE VIEW v_mov_ventas AS
SELECT
    d.medicina_id,
    m.nombre AS medicina,
    f.fecha,
    d.cantidad AS salida,
    0 AS entrada,              -- porque es venta
    'VENTA' AS tipo_movimiento
FROM Detalle_Factura d
JOIN Factura f ON f.factura_id = d.factura_id
JOIN Medicinas m ON m.id = d.medicina_id;

CREATE OR REPLACE VIEW v_mov_compras AS
SELECT
    od.medicamento_id AS medicina_id,
    m.nombre AS medicina,
    oc.fecha,
    0 AS salida,
    od.cantidad AS entrada,
    'COMPRA' AS tipo_movimiento
FROM ordencompra_detalle od
JOIN ordencompra oc ON oc.numero = od.ordennumero
JOIN Medicinas m ON m.id = od.medicamento_id;

SELECT 
    od.medicamento_id AS medicina_id,
    m.nombre AS medicina,
    oc.fecha,
    od.cantidad AS entrada,
    0 AS salida,
    'COMPRA' AS tipo_movimiento
FROM ordencompra_detalle od
JOIN ordencompra oc ON oc.numero = od.ordennumero
JOIN medicinas m ON m.id = od.medicamento_id

UNION ALL

SELECT
    d.medicina_id,
    m.nombre AS medicina,
    f.fecha,
    0 AS entrada,
    d.cantidad AS salida,
    'VENTA' AS tipo_movimiento
FROM detalle_factura d
JOIN factura f ON f.factura_id = d.factura_id
JOIN medicinas m ON m.id = d.medicina_id

ORDER BY medicina_id, fecha;

CREATE OR REPLACE VIEW v_kardex AS
SELECT * FROM v_mov_compras
UNION ALL
SELECT * FROM v_mov_ventas
ORDER BY medicina_id, fecha;
SELECT * FROM v_kardex;
----
SELECT
    tipo,
    count (*)
FROM
    medicinas
WHERE
    precio < 5
GROUP BY tipo;

SELECT * from medicinas where precio < 5;
--Caso: stock minimo
--Stock de seguridad    
--Dar disponibilidad
create table control_stock(
    medicina_id int,
    stock_minimo int
);

alter table control_stock
add PRIMARY KEY (medicina_id);

alter table control_stock
add constraint control_stok_medicina_id_fk
FOREIGN KEY (medicina_id) 
REFERENCES medicinas(id);

insert into control_stock
values(36,6);
--
SELECT
*
FROM
v_kardex k
join control_stock on cs.medicina_id = k.medicamento_id
WHERE
medicina_id=36
and saldo < stock_minimo;

SELECT  
    count(*)
FROM    
    v_kardex
group by medicina_id
order by count (*) desc;

select * from v_kardex where medicina_id=64

update medicinas set stock =12 where id = 64;
insert into control_stock values (64,15)