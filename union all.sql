--------------------------------------LEFT JOIN -------------------------------

SELECT 
    e.BusinessEntityID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    d.Name AS DepartmentName
FROM 
    Person.Person e
LEFT JOIN 
    HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
LEFT JOIN 
    HumanResources.Department d ON edh.DepartmentID = d.DepartmentID;
----------------------------------------------------------------------------------------------------------

create procedure PS_EmpleDepto--------------------------------------------------------------STORE PROCEDURE
as
begin
SELECT 
    e.BusinessEntityID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    d.Name AS DepartmentName
FROM 
    Person.Person e
LEFT JOIN 
    HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
LEFT JOIN 
    HumanResources.Department d ON edh.DepartmentID = d.DepartmentID;
	end;

	exec PS_EmpleDepto
-----------------------------------------------------------------------------------------------------------
	select * from Person.Person
	select * from HumanResources.EmployeeDepartmentHistory
	select * from HumanResources.Department
-----------------------------------------------------
use AdventureWorks2022
------------------sub consulta INNER JOIN
SELECT
	e1.BusinessEntityID,
	e1.LoginID,				---- solo una tabla
	e1.JobTitle,
	e1.VacationHours,
   Sub.AverageVacation  ---Columna derivada de la subconsulta que representa el promedio de horas de vacaciones para cada título de trabajo.
FROM 
	HumanResources.Employee AS e1
	INNER JOIN 
		(
		SELECT
			e2.JobTitle
			,AVG(e2.VacationHours) AS AverageVacation --PROMEDIO DE HORAS DE VACACIONES
		FROM 
			HumanResources.Employee AS e2
		GROUP BY 
			e2.JobTitle
		) AS sub
	ON e1.JobTitle = sub.JobTitle
WHERE 
	e1.VacationHours > sub.AverageVacation
ORDER BY 
	e1.JobTitle


--	CREATE PROCEDURE PS
--	AS
--	BEGIN
--	SELECT
--	e1.BusinessEntityID,
--	e1.LoginID,				---- solo una tabla
--	e1.JobTitle,
--	e1.VacationHours,
--   Sub.AverageVacation  ---Columna derivada de la subconsulta que representa el promedio de horas de vacaciones para cada título de trabajo.
--FROM 
--	HumanResources.Employee AS e1
--	INNER JOIN 
--		(
--		SELECT
--			e2.JobTitle
--			,AVG(e2.VacationHours) AS AverageVacation 
--		FROM 
--			HumanResources.Employee AS e2
--		GROUP BY 
--			e2.JobTitle
--		) AS sub
--	ON e1.JobTitle = sub.JobTitle
--WHERE 
--	e1.VacationHours > sub.AverageVacation
--ORDER BY 
--	e1.JobTitle
--	END;

USE AdventureWorks2022;  
GO  
SELECT DaysToManufacture, AVG(StandardCost) AS AverageCost   
FROM Production.Product  
GROUP BY DaysToManufacture; 

SELECT * FROM Production.Product
-------------------------------------------------------------
-- tabla dinámica con una fila y cinco columnas
SELECT 'AVG_PROMEDIO' AS [Costo dia productor],
 [0],[1],[2],[3],[4]
 from (
 select DaysToManufacture, StandardCost
 from Production.Product
 ) as SourceTable
 pivot
 (
 avg (StandardCost)
 for DaysToManufacture in  ([0],[1],[2],[3],[4])
 ) as PivoteTable;
 -------------------------------------------------------------- UNION ALL
 /*obtener una lista de empleados y departamentos, mostrando tanto 
 los empleados que tienen un departamento como aquellos departamentos
 que no tienen empleados.*/
 SELECT
    e.BusinessEntityID,						/* HumanResources.Employee*/ --/*HumanResources.EmployeeDepartmenteHistory*/
    e.FirstName + ' ' + e.LastName AS EmployeeName,			/**/
    d.DepartmentID,
    d.Name AS DepartmentName
FROM
    Person.Person e
LEFT JOIN
    HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
LEFT JOIN
    HumanResources.Department d ON edh.DepartmentID = d.DepartmentID

UNION all

SELECT
    e.BusinessEntityID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    d.DepartmentID,
    d.Name AS DepartmentName
FROM
    Person.Person e
RIGHT JOIN
    HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
RIGHT JOIN
    HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
WHERE
    e.BusinessEntityID IS NULL;
---------------------------------------------------------------------------- UNION ALL
-- Subconsulta para obtener productos vendidos en pedidos
 Select p.ProductID, p.Name as ProductName, sod.SalesOrderID         --primer consulta
 from Production.Product as p
 left join sales.SalesOrderDetail as sod on p.ProductID= sod.ProductID
 UNION ALL
 Select p1.ProductID, p1.Name as ProdName , null as salesOrderID      --segunda consulta
 from Production.Product as p1
 where
 not exists(
 select 1
 from sales.SalesOrderDetail sod
 where p1.ProductID = sod.SalesOrderID);

 SELECT 
    CASE 
        WHEN 1 > 0 THEN 'Verdadero'
        ELSE 'Falso'
    END AS Resultado;


