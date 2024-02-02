use AdventureWorks2022

---------------------CONSULTAS ADVENTUREWORKS-----------------------------------------

--DEPARTAMENTO Y GRUPO DE TRABAJO.
--PRESENTE LOS DEPARTAMENTOS CUYA CANTIDAD DE EMPLEADOS SEA MAYOR 5
----OBTENER LA CANTIDAD DE EMPLEADOS QUE TRABAJAN POR CADA
-------------------------------------------------------------------------------------------------------

select gender as Genero, count (1) as cantidad----EMPLEADOS M = MASCULINOS
from HumanResources.Employee
where Gender = 'M'
group by Gender
-----------------------------------------------------
--empleados con el cargo de manager
select JobTitle, VacationHours
from HumanResources.Employee
where JobTitle like '%manager%'

---SUELDO POR EMPLEADO
select  Rate as mayor_a_100
from HumanResources.EmployeePayHistory
where Rate >100.00

-------LA SUMA DE LAS VENTAS HECHAS POR CADA EMPLEADO,Y AGRUPADAD POR AÑO
select * from HumanResources.EmployeePayHistory   ----- funciona, pero revisar de donde tomas unos datos

Select FirstName, sum(salesquota) AS [total ventas], year (quotaDate) as año
from sales.SalesPersonQuotaHistory A 
join person.Person B on A.BusinessEntityID = B.BusinessEntityID
GROUP BY B.BusinessEntityID, YEAR (QuotaDate), B.FirstName
order by B.BusinessEntityID ASC

SELECT p.*
FROM Production.Product AS p
ORDER BY ProductID ASC;
GO


USE AdventureWorks2022;
GO

------------------  productos en Linea, y el precio de 4 dias anterios
SELECT Name,
    ProductNumber,
    ListPrice AS Price
FROM Production.Product
WHERE ProductLine = 'R'
    AND DaysToManufacture < 4
ORDER BY Name ASC;
GO
---------------------------------------------------
/*devuelven las ventas totales y los descuentos de cada producto*/
Select p.Name AS ProductName,
   NonDiscountSales = (OrderQty * UnitPrice),
   Discounts = ((OrderQty * UnitPrice) * UnitPriceDiscount)
from Production.Product as p
Inner Join Sales.SalesOrderDetail as sod
   on p.ProductID = Sod.ProductID
Order By ProductName DESC;

----------------------------------------
CREATE PROCEDURE PS_VENTADESCUENTO-------------------------------INNER JOIN
AS
BEGIN
Select p.Name AS ProductName,
   NonDiscountSales = (OrderQty * UnitPrice),
   Discounts = ((OrderQty * UnitPrice) * UnitPriceDiscount)
from Production.Product as p
Inner Join Sales.SalesOrderDetail as sod
   on p.ProductID = Sod.ProductID
Order By ProductName DESC;
END;

EXEC PS_VENTADESCUENTO
----------------------------------------------------------------
/* para evitar la recuperación de títulos duplicados..*/
SELECT DISTINCT JobTitle
from HumanResources.Employee
order by JobTitle;

/*consultas  recuperan una instancia de cada nombre de producto cuyo modelo es un jersey de manga larga con logotipo y cuyos números de 
ProductModelID coinciden en las tablas Product y ProductModel.*/

SELECT DISTINCT Name
from Production.Product AS P
WHERE EXISTS (
   SELECT *
   FROM Production.ProductModel AS pm
   where p.ProductModelID = pm.ProductModelID
   and pm.Name like 'Long-Sleeve Logo Jersey%'
   );
/*una instancia del nombre y apellido de cada empleado cuya bonificación en la tabla SalesPerson sea de 5000.00 y cuyos números de identificación 
coincidan en las tablas Employee y SalesPerson.*/

/* En este ejemplo se buscan los modelos cuyo precio máximo es superior al doble de la media del modelo.*/
USE AdventureWorks2022

select p1.ProductModelID -------------------------------revisar
from Production.Product AS p1
group by p1.ProductModelID
having max(p1.ListPrice) >=
(
select avg(p2.ListPrice)*2
from Production.Product AS p2
where p1.ProductModelID = p2.ProductModelID
);

--------------------------------------------------------------------
select count (*)
 from
 sales.SalesOrderHeader AS soh
  inner join sales.CurrencyRate AS cr
    on soh.CurrencyRateID = cr.CurrencyRateID
  inner join sales.Currency AS c
    on cr.FromCurrencyCode = c.CurrencyCode
where
cr.ToCurrencyCode= 'EUR'

--------------------------------------------------------------------------- 31/01/2024
SELECT 
     [soh].[CustomerID], [soh].Comment                 -----------------------CROSS APPLY---------------
FROM
   [sales].[SalesOrderHeader] AS [soh]
   cross apply 
   (
    select cr.ToCurrencyCode
	from [sales].[CurrencyRate] AS [cr]
	  inner join [sales].[Currency] AS [C]
	     on [cr].[FromCurrencyCode] = [c].[CurrencyCode]
	where
	[soh].[CurrencyRateID] = [cr].[CurrencyRateID]
   ) AS [c1]
where
 [c1].[ToCurrencyCode] ='EUR'
 ----------------------------------------------------------------------------------------------
     --------------------ORDENES DE VENTA   with cte
with CTE_CURRENCY
 AS (
	 select distinct       ------EL WITH CTE, se tiene que ejecutar siempre con el otro select
	 top 6
	 [CurrencyRateID],
	 [FromCurrencyCode],
	 [ToCurrencyCode],
	 [ModifiedDate]
from [sales].[CurrencyRate]
order by [ModifiedDate] desc
)
select [soh].*
from [Sales].[SalesOrderHeader] AS [soh]
inner join CTE_CURRENCY AS [CTE]
  on [soh].[CurrencyRateID] = [CTE].[CurrencyRateID]
-----------------------------------------------------------------------------------------------------

---- Sales.SalesOrderHeader = pedido ventas
----Sales.CurrencyRate = ventas. taza de cambios
select * from [sales].[SalesOrderHeader]

select * from  sales.CurrencyRate

SELECT [soh].[SalesOrderID], [soh].[RevisionNumber], [soh].[AccountNumber], [soh].[SubTotal]
--SELECT [soh].*
FROM [sales].[SalesOrderHeader] as [soh]
cross apply ---
 (
 select distinct
    top 5
   [CurrencyRateID], --	ID de tasa de moneda
   [FromCurrencyCode],-- Desde código de moneda
   [ToCurrencyCode],-- 	A código de moneda
   [ModifiedDate]--- 	Fecha de modificación
 from
    [sales].[CurrencyRate] AS[cr]
 order by
     [ModifiedDate] asc
 ) AS [CrossAp]
 where [soh].[CurrencyRateID] = [CrossAp].[CurrencyRateID]
 ----------------------------------------------------------------------------
 ------UTILIZAR NULL EN SUB CONSULTA PARA SEGUIR DEVOLVIENDO UN CONJUNTO DE RESULTADO

 SELECT [hrd].[DepartmentID],[hrd].[Name], [hrd].[GroupName]
 from [HumanResources].[Department] AS [hrd]
 where exists (select null)
 order by [Name] ASC;
 ---------------------------------------------------------------------------------
 ----------comparar consultas mediante exists 
                           ------------------BusinessEntityID = ID de entidad empresarial
 select p.[FirstName], p.[LastName]
 from [Person].[Person] AS p
 WHERE EXISTS
 (
  select he.[VacationHours]
  from [HumanResources].[Employee] AS [he]
   where p.[BusinessEntityID] = he.[BusinessEntityID]
   and p.[LastName] = 'Johnson'
 );
 ------------------------------------------------------------------------------------------
  --------- SUB CONSULTAS USAR ANY
  --para buscar tiendas cuyo nombre sea el mismo que el de un proveedor
  -----Purchasing.Vendor = Proveedor de productos

select [s].[BusinessEntityID],[s].[Name], p.[Name]
from [Sales].[Store] as [s] 
inner join [Purchasing].[Vendor] as [p] on [s].[BusinessEntityID] = [p].[BusinessEntityID];

--select ProductID,ProductName, CategoryName  /* muestra idproducto_productoName,CategorName*/
--from Products
--inner join Categories ON Products.CategoryID= Categories.CategoryID;



--SELECT Orders.OrderID, Customers.CustomerID, Shippers.CompanyName
--FROM ((Orders
--INNER JOIN Customers ON  Orders.CustomerID = Customers.CustomerID)
--INNER JOIN Shippers ON Orders.ShipName = Shippers.ShipperID);  ---- revisar
----------------------------------------------------------





