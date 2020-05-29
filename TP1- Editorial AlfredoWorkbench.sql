use editorial;
select cargo_descripcion from cargos;

/*2-Listar todas las columnas de empleados y la descripción del cargo que tienen.*/

select E.*, C.cargo_descripcion 
from empleados as E INNER JOIN cargos as C on E.cargo_id = C.cargo_id;

/*1.3. Listar la tabla empleados y reemplazar los nombres de columnas que tengan guion
bajo por espacio*/

select * from editorial_info as 'editorial info',titulo_autor as 'titulo_autor', plan_regalias as 'plan_regalias';

/*1.5. Mostrar por cada título su nombre y cuanto corresponde de regalías por cada 1000
títulos vendidos. Esta columna se debe mostrar como “Regalías x cada 1000
unidades”. Titulo.regalías es un porcentaje.*/

Select titulo,(regalias* 1000) as 'Regalias x cada 1000 unidades' 
from titulos;


/*1.6. Listar los nombres de autores sin repetirlos.*/
select DISTINCT(autor_nombre) 
from autores;

/*1.7. Listar los países de las editoriales sin repetirlos.*/
select distinct(pais) as "País editorial"
from editoriales;

/*1.8. Listar los nombres de almacén que hayan tenido ventas sin repetirlos.*/
select DISTINCT(almacen_nombre) from almacenes 
inner join ventas on almacenes.almacen_id = ventas.almacen_id;

/*1.9. Listar las primeras 5 ventas*/
select TOP 5 * FROM VENTAS;

/*Consultas básicas con Where
2.1. Listar los títulos pertenecientes al editor 1389. Por cada fila, listar el título, el tipo y la
fecha de publicación.*/

select T.titulo,T.genero,T.fecha_publicacion 
from titulos as T inner join editoriales as E on 
T.editorial_id = e.editorial_id 
WHERE T.editorial_id = '1389';

/*2.2. Tomando las ventas mostrar el id de título, el título y el total de ventas que se obtiene
de multiplicar la cantidad por precio. Renombrar a la columna calculada como “Total
de venta”.*/

select t.titulo_id,t.titulo,(v.cantidad * t.precio) as 'Total venta' 
from titulos as T inner join ventas as V
on T.titulo_id = v.titulo_id;

/*2.3. Listar los id de almacén, números de orden y la cantidad para las ventas que realizo el
título “Prolonged Data Deprivation: Four Case Studies” el día 29 de mayo de 2013.*/

select V.fecha_orden,V.titulo_id,V.almacen_id,V.numero_orden,V.cantidad from ventas as V INNER JOIN almacenes as A on V.almacen_id = A.almacen_id
INNER JOIN titulos as T on V.titulo_id = T.titulo_id
WHERE T.titulo = 'Prolonged Data Deprivation: Four Case Studies'
AND V.fecha_orden = '20130529';


/*
2.4. Listar el nombre, la inicial del segundo nombre y el apellido de los empleados de las
editoriales “Lucerne Publishing” y “New Moon Books”
*/
SELECT EM.nombre,EM.inicial_segundo_nombre,EM.apellido
FROM empleados as EM inner join editoriales as ED on EM.editorial_id = ED.editorial_id 
WHERE ED.editorial_nombre = 'Lucerne Publishing' OR ED.editorial_nombre = 'New Moon Books';

/*
2.5. Mostrar los títulos que no sean de la editorial “Algodata Infosystems”. Informar titulo
y Editorial.*/

SELECT T.titulo,E.editorial_nombre FROM titulos as T inner join editoriales as E
ON T.editorial_id = E.editorial_id
where E.editorial_nombre <> 'Algodata Infosystems';

/*2.6. Listar los títulos que tengan más regalías que cualquier otro título.*/

SELECT MAX(titulos.regalias) FROM titulos;

/*2.7. Informar los empleados contratados en febrero, junio y agosto de cualquier año.
Mostrar apellido, nombre y fecha de contratación y ordenar por mes empezando por
los de febrero.*/

/*como ordeno por mes?*/
SELECT * FROM empleados
WHERE MONTH(fecha_contratacion) ='2' or MONTH(fecha_contratacion) ='6' or MONTH(fecha_contratacion) ='8' 
ORDER BY MONTH(fecha_contratacion);

/*2.8. Informar las ventas de los siguientes títulos: 'Cooking with Computers: Surreptitious
Balance Sheets', 'The Psychology of Computer Cooking', 'Emotional Security: A New
Algorithm'. Mostrar titulo, nombre de almacén, fecha de orden, número de orden y
cantidad. Ordenar por títulos.*/

SELECT T.titulo,A.almacen_nombre,V.fecha_orden,V.numero_orden,V.cantidad
FROM titulos AS T INNER JOIN ventas AS V on T.titulo_id = V.titulo_id INNER JOIN almacenes as A on V.almacen_id = A.almacen_id 
WHERE T.titulo = 'Cooking with Computers: Surreptitious Balance Sheets' OR T.titulo = 'The Psychology of Computer Cooking'
OR T.titulo ='Emotional Security: A New Algorithm'
ORDER BY T.titulo;


/*2.9. Informar las publicaciones del año 2011 exceptuando las de los géneros business,
psychology y trad_cook. Mostrar titulo y género. Ordenar por género y titulo.*/

SELECT titulo,genero,fecha_publicacion FROM titulos
WHERE YEAR(titulos.fecha_publicacion)='2011'
AND genero <> 'business' AND genero <> 'trad_cook' AND genero <> 'psychology';

/* 3. Manejo de valores nulos
3.1. Mostrar aquellos libros que tienen el precio en nulo. Mostrar id de título, nombre y
nombre del editor.*/

select titulos.titulo_id, precio
from titulos
where titulos.precio IS NULL;


/*3.2. Mostrar todos los libros. Mostrar id de título, nombre y nombre del editor y el precio.
Aquellos que tienen el precio en nulo cambiarlo por 0.*/


select titulo,E.editorial_nombre,ISNULL(T.precio,0)
from titulos as T inner join editoriales AS E 
on T.editorial_id = E.editorial_id ;


/*3.3. Mostrar los descuentos que tengan una cantidad mínima establecida. Informar tipo
descuento, cantidad mínima y descuento*/

select D.tipo_descuento,D.cantidad_minima,D.descuento 
from descuentos as D 
where D.cantidad_minima > 0;

/*/3.4. Mostrar los títulos y el adelanto que le corresponde a cada uno, si este valor fuera
nulo informar le valor predeterminado de 1000 pesos.*/

select T.titulo,ISNULL(T.adelanto,0)
from titulos as T;


/*4. Operaciones con cadenas
4.1. Mostrar los nombres de los autores que empiecen con “L”*/

Select *
from autores
where autores.autor_nombre LIKE 'L%';

/* 4.2. Mostrar los nombres de los autores que tengan una “A” en su nombre.*/

Select *
from autores
where autor_nombre LIKE '%A%'

/*
4.3. Mostrar los nombres de los autores que empiecen con letras que van de la T a la Y.*/

Select *
from autores
where autor_nombre LIKE '[T-Y]%'

/*4.4. Mostrar los títulos que no tengan un “Computer” en su titulo.*/

select *
from titulos
where titulos.titulo NOT LIKE '%Computer%'

/*5. Ordenación
5.1. Listar los empleados ordenados por apellido, por nombre y por inicial del segundo
nombre.*/
select *
from empleados as E
order by E.apellido,E.nombre,E.inicial_segundo_nombre

/*5.2. Listar los títulos pertenecientes al género ‘business’. Por cada fila, listar el id, el título
y el precio. Ordenar los datos por precio en forma descendente e id de artículo en
forma ascendente.*/

select T.editorial_id,T.titulo,T.precio
from titulos as T
where T.genero = 'business'
order by T.precio DESC,T.editorial_id ASC

/*5.3. Informar la venta más importante con forma de pago a 60 días. Mostrar el almacén, el
número de orden, la fecha de la factura y el título.*/

SELECT TOP 1 T.venta_anual,A.almacen_nombre,V.numero_orden,V.fecha_orden,T.titulo 
from ventas as V inner join titulos as T on V.titulo_id = T.titulo_id
inner join almacenes as A on V.almacen_id = A.almacen_id 
where V.forma_pago = '60 días'
ORDER BY T.venta_anual DESC 

/*6. Funciones agregadas. No olvidar renombrar las columnas obtenidas por función agregada.*/
/*6.1. Mostrar el promedio de venta anual de todos los títulos*/
select AVG(titulos.venta_anual) as 'Promedio de venta anual'
from titulos

/*6.2. Mostrar el máximo de adelanto de todos los títulos*/

select MAX(T.adelanto) AS 'Título con máximo de adelanto'
from titulos as T

/*6.3. Informar cuantos planes de regalías tiene el título MC3021*/

select COUNT(PR.titulo_id) AS 'CANTIDAD DE TITULO MC3021' from plan_regalias as PR
WHERE PR.titulo_id = 'MC3021'

/*6.4. Obtener el total de ventas realizadas a 30 días en el año 2014*/

select COUNT(V.almacen_id) AS 'Ventas realizadas a 30 días en el 2014' from ventas as V
where YEAR(v.fecha_orden) = '2014' AND
V.forma_pago = '30 días'

/*6.5. Informar cuantas formas de pago existen*/
select COUNT(DISTINCT(V.forma_pago)) AS 'Formas de pago existentes'
from ventas as V

/*7. Funciones agregadas con agrupación. Renombrar las columnas obtenidas por función agregada.*/

/*7.1. Informar cuantos títulos tiene cada autor. Mostrar código de autor y cantidad de libros.*/
SELECT A.autor_id,COUNT(DISTINCT(TA.titulo_id)) AS 'Titulos por autor'
FROM autores as A inner join titulo_autor as TA
ON A.autor_id = TA.autor_id
GROUP BY A.autor_id

/*7.2. Informar el total de unidades vendidas por número de orden del almacén 7131. Mostrar número de orden y total vendido.*/
select V.numero_orden,SUM(V.cantidad)
from ventas as V inner join almacenes as A
on V.almacen_id = A.almacen_id
WHERE A.almacen_id = '7131'
group by v.numero_orden

/*7.3. Informar la última orden generada por cada almacén con forma de pago a 30 días y 60
días. Mostrar código de almacén, fecha de la orden y forma de pago. Ordenar por
fecha de orden.*/

select  A.almacen_id,MAX(V.fecha_orden) AS 'Última orden generada',V.forma_pago
from ventas as V inner join almacenes as A
on V.almacen_id = A.almacen_id
where V.forma_pago = '60 días' or V.forma_pago = '30 días'
GROUP BY A.almacen_id,V.forma_pago
ORDER BY 'Última orden generada'

/*7.4. Informar el nivel de cargo más alto alcanzado por algún empleado de cada editorial.
Mostrar Nombre de la editorial y nivel de cargo. Ordenar por nivel de cargo máximo
empezando por el mayor*/

select ED.editorial_nombre,MAX(EM.nivel_cargo) AS 'Nivel de cargo mas alto'
from empleados AS EM inner join editoriales AS ED 
on EM.editorial_id = ED.editorial_id
GROUP BY ED.editorial_nombre
ORDER BY 'Nivel de cargo mas alto' DESC

/*7.5. Mostrar los tres primeros géneros más vendidos. Mostrar género y total de ventas
ordenado por mayor total de venta.*/

select TOP 3 T.genero,SUM(V.cantidad * T.precio) AS 'CANTIDAD DE VENTAS'
from ventas as V  inner join titulos as T
on V.titulo_id = T.titulo_id
group by t.genero
order by 'CANTIDAD DE VENTAS' DESC


/*7.6. Informar aquellos títulos que tengan más de un autor. Mostrar código de título y
cantidad de autores.*/
SELECT COUNT(A.autor_id) AS 'Autores',T.titulo
FROM autores as A inner join titulo_autor as TA
on A.autor_id = TA.autor_id inner join titulos as T
on TA.titulo_id = T.titulo_id
group by T.titulo
having COUNT(A.autor_id)>1

/*7.7. Informar el total de regalías obtenidas por cada título que haya tenido 40 o más
unidades vendidas. Mostrar el título y el monto en pesos de las regalías y ordenar por
mayor regalía primero.*/

select T.titulo,SUM(T.precio * V.cantidad) as 'Precio',SUM(T.regalias * V.cantidad) AS 'Total Regalias'
from titulos as T
inner join ventas as V
on T.titulo_id = V.titulo_id
group by T.titulo,T.precio
having SUM(V.cantidad) > 40
order by 'Total Regalias' DESC

/*7.8. Informar los autores que hayan escrito varios géneros de títulos. Mostrar nombre y
cantidad de géneros ordenados por esta última columna empezando por el mayor.*/

/*AGRUPAR POR GENERO*/
SELECT  A.autor_nombre,COUNT(T.genero) AS 'Generos escritos'
FROM titulos as T inner join titulo_autor as TA
on T.titulo_id = TA.titulo_id inner join autores as A
on TA.autor_id = A.autor_id
GROUP BY A.autor_nombre
HAVING COUNT(T.genero) > 1
ORDER BY 'Generos escritos' DESC


/*8. Juntas
8.1. Mostrar los tres primeros géneros más vendidos. Mostrar género y total de ventas
ordenado por mayor total de venta.*/

select TOP 3 T.genero,COUNT(T.genero) AS 'Genero mas vendido', SUM(T.precio * V.cantidad) AS 'Total ventas'
from ventas as V inner join titulos as T
on V.titulo_id = T.titulo_id
group by T.genero
/*order by 'Total ventas' DESC*/
ORDER BY 'Genero mas vendido' DESC, 'Total ventas' DESC

/*genero mas vendido*/
select T.genero,COUNT(T.genero) as 'Cantidad de titulos por el genero',SUM(T.precio * V.cantidad )
from titulos as T inner join ventas as V
on T.titulo_id = V.titulo_id
WHERE T.genero = 'business'
GROUP BY T.genero


/*8.2. Informar las ventas a 60 días. Mostrar el id de título, el título y el total de ventas
(cantidad por precio). Renombrar a la columna calculada.*/

select T.titulo_id,SUM(T.precio * V.cantidad) as 'Total de Ventas'
from ventas as V inner join titulos as T
on V.titulo_id = T.titulo_id
where V.forma_pago = '60 días'
group by T.titulo_id

/*8.3. Informar los autores que hayan escrito varios géneros de libros. Mostrar nombre y
cantidad de géneros ordenados por esta última columna empezando por el mayor.*/

select A.autor_nombre,COUNT(T.genero) as 'Generos escritos'
from autores as A
inner join titulo_autor as TA
on A.autor_id = TA.autor_id inner join
titulos as T on TA.titulo_id = T.titulo_id
GROUP BY A.autor_nombre
HAVING COUNT(T.genero) > 1
