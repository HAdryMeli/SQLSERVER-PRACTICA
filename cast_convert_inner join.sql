use Northwind----------SELT JOIN
select * from Employees

select EmployeeID,FirstName +''+LastName,ReportsTo
from Employees

------------------------------------SELF JOIN-------------JOIN
select e1.FirstName +''+e1.LastName as Jefe, e2.FirstName +''+e2.LastName as Empleado
from Employees as e1  join Employees as e2 
on e1.EmployeeID =e2.ReportsTo

--------------------------------------------------------------------------------- CAST
SELECT 'El cliente ha realizado la siguiente orden'+ CAST (OrderID AS VARCHAR)
FROM Orders
WHERE CustomerID = 'ALFKI'
-----------------------------------------------------------  CONVERT
select OrderID,OrderDate from Orders 

SELECT Orders.OrderDate, CONVERT(varchar(12),Orders.OrderDate,111) as Convertido
from Orders where OrderID = OrderID --- oh especificar la fecha 

-----------------------------------------------------------------TABLA TEMPORAL
if OBJECT_ID('temdbo..##location_temp') is not null
begin
   drop table ##location_temp
end


CREATE TABLE ##location_temp
(
LocationID   smallint  NOT NULL,
Name         Nvarchar(50)  NOT NULL,
CostRate     smallmoney NOT NULL,    --costo de taza
Availability decimal(8, 2) NOT NULL,  --disponibilidad
ModifiedDate datetime NOT NULL,

);

----------------------------------------------------------- VIEW---VISTACREATE VIEW Cate
create view vistacat as
SELECT CategoryID, CategoryName, Description
from dbo.Categories 

select * from vistacat ---vista
select * from  #TempCategories--- tabla temporal
select * from Region
---------------------------------------------- tabla temporal

SELECT 
    CategoryID,
    CategoryName,
    Description
INTO 
    #TempCategories -- Nombre de la tabla temporal (comienza con #)
FROM 
    dbo.Categories;

---------------------------------------------------
select  CategoryID, CategoryName,Description
from Categories
where CategoryID = 1

delete from #TempCategories
where CategoryID =4
-------------------------------------TryCatch
DECLARE @Number TINYINT,
@Result TINYINT   --variables
BEGIN TRY --bloque
SET @Number = 255;
SET @Result = @Number + 1;
SELECT @Number AS Número, @Result AS Resultado;
END TRY
BEGIN CATCH -- anuncia el error encontrado en el begin try
PRINT N'Error Mensage = ' + ERROR_MESSAGE()
PRINT N'Número Error = ' + CAST(ERROR_NUMBER() AS VARCHAR)
PRINT N'Línea de error = ' + CAST(ERROR_LINE() AS VARCHAR)
PRINT N'Error_Severidad = ' + CAST(ERROR_SEVERITY() AS VARCHAR)
PRINT N'Error_Estado = ' + CAST(ERROR_STATE() AS VARCHAR)
END CATCH
------------------------------------------------------------------------

use Library
select * from Book

insert into Author(id,author_name)
values ('8','Adriana'),('9','Melisa'),('10','Ana')

begin try
insert into Book (id,book_name,price,author_id)
values ('7',null,'550','8')
end try
begin catch
print 'ERROR, NO SE PUEDE USAR EL VALOR NULL'
end catch
---------------------------------------------------------
use AdventureWorks2022

select * from HumanResources.Employee as hre  where hre.BirthDate = '1969-01-29' - '1969-12-29';

SELECT * FROM HumanResources.Employee WHERE BirthDate BETWEEN '1978-01-29' AND '1978-03-06'; 

--------------------------------------------------------------------