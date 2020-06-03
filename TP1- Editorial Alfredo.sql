/* Trabajo Practico Seminario 2020*/

/* 1 - Listar los cargos*/
use editorial
select cargo_descripcion from cargos

/*2-Listar todas las columnas de empleados y la descripción del cargo que tienen.*/
select E.*, C.cargo_descripcion 
from empleados as E INNER JOIN cargos as C on E.cargo_id = C.cargo_id

/*1.3. Listar la tabla empleados y reemplazar los nombres de columnas que tengan guion
bajo por espacio*/

Select *
from editorial_info as "editorial info",titulo_autor as "titulo_autor", plan_regalias as "plan_regalias"

/*1.5. Mostrar por cada título su nombre y cuanto corresponde de regalías por cada 1000
títulos vendidos. Esta columna se debe mostrar como Regalías x cada 1000
unidades. Titulo.regalías es un porcentaje.*/

Select titulo,(regalias* 1000) as 'Regalias x cada 1000 unidades' 
from titulos

/*1.6. Listar los nombres de autores sin repetirlos.*/
select DISTINCT(autor_nombre) 
from autores

/*1.7. Listar los países de las editoriales sin repetirlos.*/
select distinct(pais) as "País editorial"
from editoriales


/*1.8. Listar los nombres de almacén que hayan tenido ventas sin repetirlos.*/
select DISTINCT(almacen_nombre) from almacenes 
inner join ventas on almacenes.almacen_id = ventas.almacen_id

/*1.9. Listar las primeras 5 ventas*/
select TOP 5 * FROM VENTAS
