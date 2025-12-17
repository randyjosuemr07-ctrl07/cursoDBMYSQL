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
