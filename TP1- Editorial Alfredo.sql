/* Trabajo Practico Seminario 2020*/

/* 1 - Listar los cargos*/
use editorial
select cargo_descripcion from cargos

/*2-Listar todas las columnas de empleados y la descripci�n del cargo que tienen.*/
select E.*, C.cargo_descripcion 
from empleados as E INNER JOIN cargos as C on E.cargo_id = C.cargo_id

/*1.3. Listar la tabla empleados y reemplazar los nombres de columnas que tengan guion
bajo por espacio*/

Select *
from editorial_info as "editorial info",titulo_autor as "titulo_autor", plan_regalias as "plan_regalias"

/*1.5. Mostrar por cada t�tulo su nombre y cuanto corresponde de regal�as por cada 1000
t�tulos vendidos. Esta columna se debe mostrar como �Regal�as x cada 1000
unidades�. Titulo.regal�as es un porcentaje.*/

Select titulo,(regalias* 1000) as 'Regalias x cada 1000 unidades' 
from titulos

/*1.6. Listar los nombres de autores sin repetirlos.*/
select DISTINCT(autor_nombre) 
from autores

/*1.7. Listar los pa�ses de las editoriales sin repetirlos.*/
select distinct(pais) as "Pa�s editorial"
from editoriales


/*1.8. Listar los nombres de almac�n que hayan tenido ventas sin repetirlos.*/
select DISTINCT(almacen_nombre) from almacenes 
inner join ventas on almacenes.almacen_id = ventas.almacen_id

/*1.9. Listar las primeras 5 ventas*/
select TOP 5 * FROM VENTAS

/*Consultas b�sicas con Where
2.1. Listar los t�tulos pertenecientes al editor 1389. Por cada fila, listar el t�tulo, el tipo y la
fecha de publicaci�n.*/
go
select T.titulo,T.genero,T.fecha_publicacion 
from titulos as T inner join editoriales as E on 
T.editorial_id = e.editorial_id 
WHERE T.editorial_id = '1389'

/*2.2. Tomando las ventas mostrar el id de t�tulo, el t�tulo y el total de ventas que se obtiene
de multiplicar la cantidad por precio. Renombrar a la columna calculada como �Total
de venta�.*/

select t.titulo_id,t.titulo,(v.cantidad * t.precio) as 'Total venta' 
from titulos as T inner join ventas as V
on T.titulo_id = v.titulo_id

/*2.3. Listar los id de almac�n, n�meros de orden y la cantidad para las ventas que realizo el
t�tulo �Prolonged Data Deprivation: Four Case Studies� el d�a 29 de mayo de 2013.*/

select V.fecha_orden,V.titulo_id,V.almacen_id,V.numero_orden,V.cantidad from ventas as V INNER JOIN almacenes as A on V.almacen_id = A.almacen_id
INNER JOIN titulos as T on V.titulo_id = T.titulo_id
WHERE T.titulo = 'Prolonged Data Deprivation: Four Case Studies'
AND V.fecha_orden = '20130529'


/*
2.4. Listar el nombre, la inicial del segundo nombre y el apellido de los empleados de las
editoriales �Lucerne Publishing� y �New Moon Books�
*/
SELECT EM.nombre,EM.inicial_segundo_nombre,EM.apellido
FROM empleados as EM inner join editoriales as ED on EM.editorial_id = ED.editorial_id 
WHERE ED.editorial_nombre = 'Lucerne Publishing' OR ED.editorial_nombre = 'New Moon Books'

/*
2.5. Mostrar los t�tulos que no sean de la editorial �Algodata Infosystems�. Informar titulo
y Editorial.*/

SELECT T.titulo,E.editorial_nombre FROM titulos as T inner join editoriales as E
ON T.editorial_id = E.editorial_id
where E.editorial_nombre <> 'Algodata Infosystems'

/*2.6. Listar los t�tulos que tengan m�s regal�as que cualquier otro t�tulo.*/

SELECT MAX(titulos.regalias) FROM titulos

/*2.7. Informar los empleados contratados en febrero, junio y agosto de cualquier a�o.
Mostrar apellido, nombre y fecha de contrataci�n y ordenar por mes empezando por
los de febrero.*/

/*como ordeno por mes?*/
SELECT * FROM empleados
WHERE MONTH(fecha_contratacion) ='2' or MONTH(fecha_contratacion) ='6' or MONTH(fecha_contratacion) ='8' 
ORDER BY MONTH(fecha_contratacion)

/*2.8. Informar las ventas de los siguientes t�tulos: 'Cooking with Computers: Surreptitious
Balance Sheets', 'The Psychology of Computer Cooking', 'Emotional Security: A New
Algorithm'. Mostrar titulo, nombre de almac�n, fecha de orden, n�mero de orden y
cantidad. Ordenar por t�tulos.*/

SELECT T.titulo,A.almacen_nombre,V.fecha_orden,V.numero_orden,V.cantidad
FROM titulos AS T INNER JOIN ventas AS V on T.titulo_id = V.titulo_id INNER JOIN almacenes as A on V.almacen_id = A.almacen_id 
WHERE T.titulo = 'Cooking with Computers: Surreptitious Balance Sheets' OR T.titulo = 'The Psychology of Computer Cooking'
OR T.titulo ='Emotional Security: A New Algorithm'
ORDER BY T.titulo


/*2.9. Informar las publicaciones del a�o 2011 exceptuando las de los g�neros business,
psychology y trad_cook. Mostrar titulo y g�nero. Ordenar por g�nero y titulo.*/

SELECT titulo,genero,fecha_publicacion FROM titulos
WHERE YEAR(titulos.fecha_publicacion)='2011'
AND genero <> 'business' AND genero <> 'trad_cook' AND genero <> 'psychology'

/* 3. Manejo de valores nulos
3.1. Mostrar aquellos libros que tienen el precio en nulo. Mostrar id de t�tulo, nombre y
nombre del editor.*/

select titulos.titulo_id, precio
from titulos
where titulos.precio IS NULL


/*3.2. Mostrar todos los libros. Mostrar id de t�tulo, nombre y nombre del editor y el precio.
Aquellos que tienen el precio en nulo cambiarlo por 0.*/


select titulo,E.editorial_nombre,ISNULL(T.precio,0)
from titulos as T inner join editoriales AS E 
on T.editorial_id = E.editorial_id 


/*3.3. Mostrar los descuentos que tengan una cantidad m�nima establecida. Informar tipo
descuento, cantidad m�nima y descuento*/

select D.tipo_descuento,D.cantidad_minima,D.descuento 
from descuentos as D 
where D.cantidad_minima > 0

/*/3.4. Mostrar los t�tulos y el adelanto que le corresponde a cada uno, si este valor fuera
nulo informar le valor predeterminado de 1000 pesos.*/

select T.titulo,ISNULL(T.adelanto,0)
from titulos as T


/*4. Operaciones con cadenas
4.1. Mostrar los nombres de los autores que empiecen con �L�*/

Select *
from autores
where autores.autor_nombre LIKE 'L%'

/* 4.2. Mostrar los nombres de los autores que tengan una �A� en su nombre.*/

Select *
from autores
where autor_nombre LIKE '%A%'

/*
4.3. Mostrar los nombres de los autores que empiecen con letras que van de la T a la Y.*/

Select *
from autores
where autor_nombre LIKE '[T-Y]%'

/*4.4. Mostrar los t�tulos que no tengan un �Computer� en su titulo.*/

select *
from titulos
where titulos.titulo NOT LIKE '%Computer%'

/*5. Ordenaci�n
5.1. Listar los empleados ordenados por apellido, por nombre y por inicial del segundo
nombre.*/
select *
from empleados as E
order by E.apellido,E.nombre,E.inicial_segundo_nombre

/*5.2. Listar los t�tulos pertenecientes al g�nero �business�. Por cada fila, listar el id, el t�tulo
y el precio. Ordenar los datos por precio en forma descendente e id de art�culo en
forma ascendente.*/

select T.editorial_id,T.titulo,T.precio
from titulos as T
where T.genero = 'business'
order by T.precio DESC,T.editorial_id ASC

/*5.3. Informar la venta m�s importante con forma de pago a 60 d�as. Mostrar el almac�n, el
n�mero de orden, la fecha de la factura y el t�tulo.*/

SELECT TOP 1 T.venta_anual,A.almacen_nombre,V.numero_orden,V.fecha_orden,T.titulo 
from ventas as V inner join titulos as T on V.titulo_id = T.titulo_id
inner join almacenes as A on V.almacen_id = A.almacen_id 
where V.forma_pago = '60 d�as'
ORDER BY T.venta_anual DESC 

/*6. Funciones agregadas. No olvidar renombrar las columnas obtenidas por funci�n agregada.*/
/*6.1. Mostrar el promedio de venta anual de todos los t�tulos*/
select AVG(titulos.venta_anual) as 'Promedio de venta anual'
from titulos

/*6.2. Mostrar el m�ximo de adelanto de todos los t�tulos*/

select MAX(T.adelanto) AS 'T�tulo con m�ximo de adelanto'
from titulos as T

/*6.3. Informar cuantos planes de regal�as tiene el t�tulo MC3021*/

select COUNT(PR.titulo_id) AS 'CANTIDAD DE TITULO MC3021' from plan_regalias as PR
WHERE PR.titulo_id = 'MC3021'

/*6.4. Obtener el total de ventas realizadas a 30 d�as en el a�o 2014*/

select COUNT(V.almacen_id) AS 'Ventas realizadas a 30 d�as en el 2014' from ventas as V
where YEAR(v.fecha_orden) = '2014' AND
V.forma_pago = '30 d�as'

/*6.5. Informar cuantas formas de pago existen*/
select COUNT(DISTINCT(V.forma_pago)) AS 'Formas de pago existentes'
from ventas as V

/*7. Funciones agregadas con agrupaci�n. Renombrar las columnas obtenidas por funci�n agregada.*/

/*7.1. Informar cuantos t�tulos tiene cada autor. Mostrar c�digo de autor y cantidad de libros.*/
SELECT A.autor_id,COUNT(DISTINCT(TA.titulo_id)) AS 'Titulos por autor'
FROM autores as A inner join titulo_autor as TA
ON A.autor_id = TA.autor_id
GROUP BY A.autor_id

/*7.2. Informar el total de unidades vendidas por n�mero de orden del almac�n 7131. Mostrar n�mero de orden y total vendido.*/
select V.numero_orden,SUM(V.cantidad)
from ventas as V inner join almacenes as A
on V.almacen_id = A.almacen_id
WHERE A.almacen_id = '7131'
group by v.numero_orden

/*7.3. Informar la �ltima orden generada por cada almac�n con forma de pago a 30 d�as y 60
d�as. Mostrar c�digo de almac�n, fecha de la orden y forma de pago. Ordenar por
fecha de orden.*/

select  A.almacen_id,MAX(V.fecha_orden) AS '�ltima orden generada',V.forma_pago
from ventas as V inner join almacenes as A
on V.almacen_id = A.almacen_id
where V.forma_pago = '60 d�as' or V.forma_pago = '30 d�as'
GROUP BY A.almacen_id,V.forma_pago
ORDER BY '�ltima orden generada'

/*7.4. Informar el nivel de cargo m�s alto alcanzado por alg�n empleado de cada editorial.
Mostrar Nombre de la editorial y nivel de cargo. Ordenar por nivel de cargo m�ximo
empezando por el mayor*/

select ED.editorial_nombre,MAX(EM.nivel_cargo) AS 'Nivel de cargo mas alto'
from empleados AS EM inner join editoriales AS ED 
on EM.editorial_id = ED.editorial_id
GROUP BY ED.editorial_nombre
ORDER BY 'Nivel de cargo mas alto' DESC

/*7.5. Mostrar los tres primeros g�neros m�s vendidos. Mostrar g�nero y total de ventas
ordenado por mayor total de venta.*/

select TOP 3 T.genero,SUM(V.cantidad * T.precio) AS 'CANTIDAD DE VENTAS'
from ventas as V  inner join titulos as T
on V.titulo_id = T.titulo_id
group by t.genero
order by 'CANTIDAD DE VENTAS' DESC


/*7.6. Informar aquellos t�tulos que tengan m�s de un autor. Mostrar c�digo de t�tulo y
cantidad de autores.*/
SELECT COUNT(A.autor_id) AS 'Autores',T.titulo
FROM autores as A inner join titulo_autor as TA
on A.autor_id = TA.autor_id inner join titulos as T
on TA.titulo_id = T.titulo_id
group by T.titulo
having COUNT(A.autor_id)>1

/*7.7. Informar el total de regal�as obtenidas por cada t�tulo que haya tenido 40 o m�s
unidades vendidas. Mostrar el t�tulo y el monto en pesos de las regal�as y ordenar por
mayor regal�a primero.*/

select T.titulo,SUM(T.precio * V.cantidad) as 'Precio',SUM(T.regalias * V.cantidad) AS 'Total Regalias'
from titulos as T
inner join ventas as V
on T.titulo_id = V.titulo_id
group by T.titulo,T.precio
having SUM(V.cantidad) > 40
order by 'Total Regalias' DESC

/*7.8. Informar los autores que hayan escrito varios g�neros de t�tulos. Mostrar nombre y
cantidad de g�neros ordenados por esta �ltima columna empezando por el mayor.*/

/*AGRUPAR POR GENERO*/
SELECT  A.autor_nombre,COUNT(T.genero) AS 'Generos escritos'
FROM titulos as T inner join titulo_autor as TA
on T.titulo_id = TA.titulo_id inner join autores as A
on TA.autor_id = A.autor_id
GROUP BY A.autor_nombre
HAVING COUNT(T.genero) > 1
ORDER BY 'Generos escritos' DESC


/*8. Juntas
8.1. Mostrar los tres primeros g�neros m�s vendidos. Mostrar g�nero y total de ventas
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


/*8.2. Informar las ventas a 60 d�as. Mostrar el id de t�tulo, el t�tulo y el total de ventas
(cantidad por precio). Renombrar a la columna calculada.*/

select T.titulo_id,SUM(T.precio * V.cantidad) as 'Total de Ventas'
from ventas as V inner join titulos as T
on V.titulo_id = T.titulo_id
where V.forma_pago = '60 d�as'
group by T.titulo_id

/*8.3. Informar los autores que hayan escrito varios g�neros de libros. Mostrar nombre y
cantidad de g�neros ordenados por esta �ltima columna empezando por el mayor.*/

select A.autor_nombre,COUNT(T.genero) as 'Generos escritos'
from autores as A
inner join titulo_autor as TA
on A.autor_id = TA.autor_id inner join
titulos as T on TA.titulo_id = T.titulo_id
GROUP BY A.autor_nombre
HAVING COUNT(T.genero) > 1