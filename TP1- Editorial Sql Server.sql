/* Trabajo Practico Seminario 2020*/

/* 1 - Listar los cargos*/
use editorial
select cargo_descripcion from cargos

/*2-Listar todas las columnas de empleados y la descripción del cargo que tienen.*/
select E.*, C.cargo_descripcion 
from empleados as E, cargos as C WHERE E.cargo_id = C.cargo_id

/*1.3. Listar la tabla empleados y reemplazar los nombres de columnas que tengan guion
bajo por espacio*/

select apellido,empleado_id as 'empleado id', inicial_segundo_nombre as 'inicial segundo nombre',cargo_id as 'cargo id',nivel_cargo as 'nivel cargo',
editorial_id as 'editorial id', fecha_contratacion as 'fecha contratacion'
from empleados;

/*1.4. Calcular pi  =  donde pi r^2 = 10 y la función Pi() para pi */
select pi()*(POWER(10,2)) as A;

/*1.5. Mostrar por cada título su nombre y cuanto corresponde de regalías por cada 1000
títulos vendidos. Esta columna se debe mostrar como Regalías x cada 1000
unidades. Titulo.regalías es un porcentaje.*/

select titulo, (precio*regalias/100.0) * 1000 as 'Regalias x cada 1000 unidades'
from titulos;

/*1.6. Listar los nombres de autores sin repetirlos.*/
select DISTINCT(autor_nombre) 
from autores

/*1.7. Listar los países de las editoriales sin repetirlos.*/
select distinct(pais) as "País editorial"
from editoriales


/*1.8. Listar los nombres de almacén que hayan tenido ventas sin repetirlos.*/
select DISTINCT(almacen_nombre) from almacenes,ventas
Where almacenes.almacen_id = ventas.almacen_id;

/*1.9. Listar las primeras 5 ventas*/
select TOP 5 * FROM VENTAS
