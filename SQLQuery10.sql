
create table T_Prueba( --LISTO
   Id_Cliente int identity (201,01) primary key,
   Nombre Varchar (80),
   Precio money ,
   cantidad int 
)

select *from T_Prueba

select * from T_DetalleFac


INSERT INTO T_Prueba (Nombre,Precio,Cantidad)
values ('Clavos',5.00,45),
		('Madera',100.50,100),
		('Pinturas',250.00,10),
		('Martillo',150.10,5)
-----------------------------------------------------------
-------------PROCEDIMIENTOS ALMACENADOS--------------------------
CREATE PROCEDURE SelectAllCliente 
AS
SELECT * FROM T_Cliente --MANDA A LLAMAR TODOS LOS REGISTROS DE LA TABLA
GO;

EXEC SelectAllCliente
---------------------------------------------------------------
CREATE PROCEDURE CP_Factura ----  LLAMA SOLO LOS ID de la tabla FACTURA
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id_Factura,Id_Detalle,Id_Vendedor, Id_Cliente
    FROM T_Factura;
END;

exec CP_Factura
--------------------------------------------------
CREATE PROCEDURE SP_NombreGeneral -- Llama los solo los nombres de los vendedores y solo los nombres de los clientes de diferentes tablas
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 'Vendedor' AS Tipo, Nombre
    FROM T_Vendedor
    UNION
    SELECT 'Cliente' AS Tipo, Nombre
    FROM T_Cliente;
END;

exec SP_NombreGeneral
---------------------------------------------------

CREATE PROCEDURE SP_TotalFacturas------- SUMA TODOS LOS TOTALES DE LA TABLA FACTURA
AS
BEGIN
DECLARE @total  DECIMAL (10,2);

select @total= SUM(Total)
from T_Factura;

select @total as TotalFacturacion
END;

exec SP_TotalFacturas
------------------------------------------------------
CREATE PROCEDURE CP_Proveedor ----  
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Nombre_Proveedor,Categoria
    FROM T_Proveedores;
END;

exec CP_Proveedor

SELECT * FROM T_Factura
-------------------------------------------------

CREATE PROCEDURE SP_AnualxEmple------- Pago ANULA POR EMPLEADO
AS
BEGIN 
   SELECT 
    Id_Empleado,
    Nombre_Empleado,
    Salario_Mensual,
    Salario_Mensual * 12 AS SalarioAnual
FROM 
    T_Empleado;
	end

exec SP_AnualxEmple
----------------------------------------------------------------

CREATE PROCEDURE SP_SalarioMayor------- SALARIO MAYOR
AS
BEGIN 
   SELECT 
    Id_Empleado, Nombre_Empleado, Salario_Mensual
FROM 
    T_Empleado where Salario_Mensual >20000;
	end

exec SP_SalarioMayor
----------------------------------------------------------------
create procedure PS_SalarioDiario
AS
BEGIN
    select Id_Empleado,Nombre_Empleado,Salario_Mensual / 30 AS Salario_Diario
 from T_Empleado;
end;

exec PS_SalarioDiario
-------------------------------------------------------------
create procedure Sp_StockProducto     ----STOCK DE PRODUCTO, TABLA T_DETALLE Y T_FACTURA
@Id_Factura Int,
@Id_Detalle Int,
@Cantidad int,
@Total int,
@Id_Vendedor int,
@Id_Cliente int,
@Fecha_Entrega datetime,
@Mensaje varchar (50) OUTPUT -- SE DECLARA @MENSAJE PARA VERIFICAR SI SE REALIZO CORRECTAMENRE LA FACTURA/COMPRA
AS
BEGIN 
insert into T_Factura values (@Id_Detalle,@Cantidad,@Total,@Id_Vendedor,@Id_Cliente,@Fecha_Entrega)
update T_DetalleFac set stock = stock - @Cantidad where Id_Detalle = @Id_Detalle
set @Mensaje = 'FACTURA REALIZADA CORRECTAMENTE'
END
GO

DECLARE @Mensaje varchar (50)
exec Sp_StockProducto '','602','400','2000','301','202','29/01/2024', @Mensaje OUTPUT
select @Mensaje

select * from T_DetalleFac
select * from T_Factura

DROP PROCEDURE Sp_StockProducto
---------------------------------------------------------------------------------------------------
SELECT * FROM T_DetalleFac

CREATE PROCEDURE SP_CRUDDETALLE-------------------- PRODEDURE PROBARSE EN UNA APLICACION PARA COMPROBAR 
@Id_Detalle int,
@Nproducto varchar (50),
@stock int,
@Id_Proveedores int,
@Precio int,
@Marca_Producto varchar (50),
@Modo char (1)

AS
   IF  @Modo='I'
   begin
       insert T_DetalleFac values (@Nproducto,@stock ,@Id_Proveedores,@Precio,@Marca_Producto)
   end

   IF @Modo= 'U'
   begin
         update T_DetalleFac SET Nproducto=@Nproducto,stock=@stock ,Id_Proveedores=@Id_Proveedores,Precio=@Precio,Marca_Producto=@Marca_Producto where Id_Detalle = @Id_Detalle
   end

   If @Modo='D'
   begin
         delete from T_DetalleFac where Id_Detalle=@Id_Detalle

   end;
   go
   EXEC  SP_CRUDDETALLE --- LISTO
------------------------------------------------------------------------------------------------------------

SELECT UPPER ('mI bASE dato')

