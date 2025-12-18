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

