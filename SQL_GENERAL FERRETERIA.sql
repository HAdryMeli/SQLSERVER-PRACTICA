
use dbo_Ferreteria

create table T_Factura
(
   Id_Factura int identity (101,01) primary key,
   Id_Detalle int,
   Cantidad int,
   Total int,
   Id_Vendedor int,
   Id_Cliente int,
   Fecha_Entrega datetime, 
   --FOREIGN KEY (Id_Detalle) REFERENCES T_DetalleFac(Id_Detalle),
   --FOREIGN KEY (Id_Vendedor) REFERENCES T_Vendedor(Id_Vendedor),
   --FOREIGN KEY (Id_Cliente) REFERENCES T_Cliente(Id_Clliente)

)---LISTO

create table T_Cliente( --LISTO
   Id_Cliente int identity (201,01) primary key,
   Nombre Varchar (80),
   Apellido Varchar (80),
   telefono int,
   Direccion Varchar (80)
)

create table T_Vendedor(--LISTO
   Id_Vendedor int identity (301,01) primary key,
   Nombre Varchar (80),
   Cargo Varchar (80),
   telefono int,
   Id_Sucursal int
)

create table T_Sucursal(--LISTO
   Id_Sucursal int identity (401,01) primary key,
   Nombre_Sucursal Varchar (80),
   Direccion Varchar (80),
   telefono int,
)

create table T_Proveedores(
   Id_Proveedor int identity (501,01) primary key,
   Nombre_Proveedor Varchar (80),
   Direccion Varchar (80),
   telefono int,
   Correo Varchar (80),
   Categoria Varchar (80)
)---lISTO


create table T_Empleado(
   Id_Empleado int identity (701,01) primary key,
   Rtn bigint,
   Nombre_Empleado Varchar (80),
   Apellido varchar (80),
   Direccion varchar (80),
   Telefono int,
   Fecha_Inicio Datetime,
   Depto_Asignado varchar (80),
   Correo Varchar (80),
   Salario_Mensual numeric (18,2)
)---listo

select * from T_Empleado

drop table T_Empleado
create table T_DetalleFac(
   Id_Detalle int identity (601,01) primary key,
   Nproducto Varchar (80),
   stock Varchar (80),
   precio int,
   Id_Proveedores int 
)---lISTO

-----------------insertar datos  -------------------------
--INSERTAR DATOS
Insert Into T_Empleado(Rtn,Nombre_Empleado,Apellido,Direccion,Telefono,Fecha_Inicio,Depto_Asignado,Correo,Salario_Mensual)
values  ('100120000456321','Melisa','Hernandez','Barrio Lempira,Intibuca','99825412','25/11/2024','Depto Sistemas','hmelisa@.com','200500.00'),
		('100119950005677','Ana','Lopez','Barrio Delicias,Intibuca','99866412','08/11/2023','Depto Compras','analopez@.com','20000.00'),
		('105017890045623','Juana','Dominguez','Yamaranguila,Intibuca','998252','2/10/2023','Depto Contabilidad','junadomin@.com','5500.00'),
		('100619781456789','Enrique','Gomez','Barrio Santa Catarina','99825488','25/05/2020','Depto Ventas','enrique@.com','2500.00'),
		('100820020088890','Guillermo','Garcia','Barrio Lempira,Intibuca','9977258','5/06/2021','Depto Sistemas','hgillermo@.com','13000.00'),
		('100620550468714','Elam','Sanchez','Barrio El Way,Intibuca','99825400','25/11/2020','Depto Compras','helamsanz@.com','17000.00'),
		('100648148617745','Saul','Madrid','Marcala,La Paz','99825401','15/09/2024','Almacen','madrid@.com','18000.00'),
		('101017895264176','Yajaira','Arauz','Barrio Delicias,Intibuca','99825418','17/07/2019','RRHH','arauz@.com','16500.00')



Insert into T_Proveedores(Nombre_Proveedor,Direccion,telefono,Correo,Categoria)
Values  ('Gimbel Mexicana','Avenida las Granjas,Col. San Sebastian','55852659','gimbel_mexicana@CORREO','Herramientas Electricas'),
		('Felisa:','Col. Indígena, San Juan,Intibuca','27832495','felisa@.com','Material Electrico'),
		('Clavos Nacionales','San pedro Sula','27833823','cn_company@.com','Iluminacionn'),
		('EL Faro Ferretero','Col. C.D Mendoza, Orizaba, Veracruz México.','27832105','SIN@CORREO','Tuberias PVC'),
		('Impulsadora Ferretera','Choluteca, Choluteca','27835566','imferre@.com','Pinturas'),
		('Impulsadora Matusa','Valle Nacaome,Juticalpa','27837814','impmatusa@.com','Producto DeAcero'),
		('Pysesa','Tegucigalpa D.C','27833334','pysesa@.com','Malla Ciclon')

	select *from T_Proveedores   

Insert into T_DetalleFac(Nproducto,stock,Id_Proveedores,Precio,Marca_Poroducto)
Values ('Taladro', 50, '503', 15.99, 'Enar'),
	  ('Destornillador', ' 100', '503', '5.99', 'Sima'),
	  ('Sierra Circular', '20', '501', '89.99', 'Bellota'),
	  ('Llave Inglesa',   '75', '501', '8.99', 'Bellota'),
	  ('Taladro Eléctrico',  '30', '506', '59.99', 'Hikoki'),
	  ('Cinta Métrica', '200',   '507',' 3.99', 'Evans'),
	  ('Clavos', '500', '511', '1.99', 'Solter'),
	  ('Tornillos', '800', '511', '2.99', 'Facom'),
	  ('Pintura',' 40', '510', '24.99', 'Corona Dura'),
	  ('Cautín',' 15', '507', '12.99', 'Imcas'),
	  ('Brochas', '50', '510', '4.99', 'Corona Dura'),
	  ('Alicates',' 70', '502', '7.99', 'Dolamar'),
	  ('Lijadora Orbital', '501', '1', '39.99', 'Bellota'),
	  ('Nivel de Burbuja',' 502', '2', '9.99', 'Makita'),
	  ('Cerraduras', '60', '503', '19.99', 'Enar');

	  select * From T_DetalleFac
	
Insert into T_Sucursal(Nombre_Sucursal,Direccion,telefono)
Values ('Sucursal1','La Esperanza','27839632'),
       ('Sucursal2','Siguatepeque','27837734'),
       ('Sucursal3','Jesus de Otoro','27839651')

Insert into T_Cliente(Nombre,Apellido,telefono,Direccion,Rtn,Correo)
Values
	  ('Luis', 'Rodríguez', '98765432', 'Avenida 2, Pueblo B', '987654321', 'luis@example.com'),
	  ('Marta', 'López', '45678901', 'Calle 3, Villa C', '456789012', 'marta@example.com'),
	  ('Roberto', 'Pérez', '78901234', 'Avenida 4, Poblado D', '789012345', 'roberto@example.com'),
	  ('Carmen', 'Hernández', '23456781', 'Calle 5, Urbanización E', '234567890', 'carmen@example.com'),
	  ('Carlos', 'Sánchez', '56789234', 'Avenida 6, Residencial F', '567890123', 'carlos@example.com'),
	  ('Laura', 'Martínez', '90123478', 'Calle 7, Colonia G', '901234567', 'laura@example.com'),
	  ('Javier', 'González', '34567812', 'Avenida 8, Aldea H', '345678901', 'javier@example.com'),
	  ('Rosa', 'Ramírez', '67890145', 'Calle 9, Barrio I', '678901234', 'rosa@example.com'),
	  ('Francisco', 'Díaz', '01234589', 'Avenida 10, Sector J', '012345678', 'francisco@example.com'),
	  ('Mariana', 'Torres', '89012567', 'Calle 11, Comunidad K', '890123456', 'mariana@example.com'),
	  ('José', 'Jiménez', '23456901', 'Avenida 12, Conjunto L', '234567890', 'jose@example.com'),
	  ('Isabel', 'Flores', '56789014', 'Calle 13, Zona M', '567890123', 'isabel@example.com'),
	  ('Alejandro', 'Ortega', '90123678', 'Avenida 14, Barriada N', '901234567', 'alejandro@example.com'),
	  ('Patricia', 'Castro', '34567012', 'Calle 15, Residencial O', '345678901', 'patricia@example.com')

select *from T_Cliente

     
Insert into T_Vendedor(Nombre,Cargo,telefono,Id_Sucursal)
Values ('Zioina','Vaca','27839632','403'),
       ('Issis','Lopez','27835631','401'),
	   ('Leonel','Meza','278396632','403')
select * from T_Vendedor


Insert into T_Factura(Id_Detalle,Cantidad,Total,Id_Vendedor,Id_Cliente,Fecha_Entrega)
Values ('603','56','2000','303','201','26/07/2023'),
       ('601','6','250','301','203','15/01/2023'),
	   ('601','75','345','302','201','26/02/2024')


---------------------------------------------------------------------
drop table  T_Factura---- borrar tabla

---- CONSULTAS-------

---- UTILIZANDO UNION ALL, MUESTRA TODOS LOS id de la base de datos

 SELECT 'Vendedor' AS Tipo,Id_Vendedor
    FROM T_Vendedor
    UNION
SELECT 'Cliente' AS Tipo,Id_Cliente
    FROM T_Cliente
    UNION

select Id_Detalle as ID,Nombre from T_DetalleFac
Union All
Select Id_Proveedor as ID from T_Proveedores
union all
Select Id_Cliente from T_Cliente
union all
Select Id_Sucursal from T_Sucursal
union all
Select Id_Vendedor from T_Vendedor;

------------CONSULTAS GENERADAS----------------------
 
SELECT Id_Detalle,Nproducto AS Detalle
FROM T_DetalleFac;

select * from T_DetalleFac

SELECT Id_Vendedor, Nombre, Nombre_Sucursal
FROM T_Vendedor  --INNER JOIN UNE DOS TABLAS RELACIONADAS AL MOMENTO DE REALIZAR LA CONSULTA
INNER JOIN T_Sucursal ON T_Vendedor.Id_Sucursal = T_Sucursal.Id_Sucursal;

SELECT TOP 1* FROM T_Cliente  --- Solo genera los primeros ingresos a la consuta

SELECT TOP 5 * FROM T_Vendedor
WHERE Id_Sucursal='403';

select top  7 * from T_Vendedor   --- UNIMOSEL SELECT TOP CON EL ORDER BY,para selecionar cierta cantidad de registros y de que manera alfabeticamente
order by Nombre asc;




DROP PROCEDURE SP_NombreGeneral;--- PARA ELIMINAR UN PROCEDIMIENTO ALMACENADO
GO

select *from T_Cliente--- PARA SELECCIONAR TODA UNA TABLA