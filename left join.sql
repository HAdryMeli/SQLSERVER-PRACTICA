-----------------------------------------LEFT JOIN------------------------------------------------
                    /*SE UTILIZA PARA CAMBINAR LOS DATOS DE UNA SOLA TABLA EN SI MISMA*/ 
SELECT             
	* 
FROM 
	[Production].[Product] AS [p]
	LEFT JOIN [Production].[ProductCategory] AS [pc]
		ON [p].[ProductSubcategoryID] = [pc].[ProductCategoryID]
-------------------------------------------------------------------------------------------------
---HumamResource.Employee =

USE AdventureWorks2022; -- Asegúrate de estar usando la base de datos AdventureWorks
select * from dbo.ErrorLog



SELECT * FROM ProductiON.Product
SELECT *FROM Production.ProductCategory
----------------------------------------------------------------------------------------------
SELECT 
	* 
FROM 
	[Production].[Product] AS [p]
	OUTER APPLY
		(
			SELECT * 
			FROM [Production].[ProductCategory] AS [pc]
			WHERE [p].[ProductSubcategoryID] = [pc].[ProductCategoryID]
		) AS [o1]