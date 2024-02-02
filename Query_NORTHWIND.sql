USE Northwind

SELECT * FROM Categories
-------------------------------CONSULTAS BD. NORTHWIND------------------------------------------------------------
/*Uniremos la tabla Productos con la tabla Categorías, utilizando el CategoryIDcampo de ambas tablas:*/

select ProductID,ProductName, CategoryName  /* muestra idproducto_productoName,CategorName*/
from Products
inner join Categories ON Products.CategoryID= Categories.CategoryID;

CREATE PROCEDURE PS_UnionTCat -------------------------- STORED PROCEDURE   ----INNER JOIN 
AS
BEGIN 
select ProductID,ProductName, CategoryName
from Products
inner join Categories ON Products.CategoryID= Categories.CategoryID

END;


EXEC PS_UnionTCat
-------------------------------------------------------------------------

/*selecciona todos los pedidos con información del cliente y del remitente:*/

SELECT * FROM Shippers

SELECT Orders.OrderID, Customers.CustomerID, Shippers.CompanyName
FROM ((Orders
INNER JOIN Customers ON  Orders.CustomerID = Customers.CustomerID)
INNER JOIN Shippers ON Orders.ShipName = Shippers.ShipperID);  ---- revisar

------------------------------------------------------------------------------------
SELECT * FROM Orders
select * from Customers

------seleccionará todos los clientes y cualquier pedido que puedan tener:

SELECT  Customers.CompanyName, Orders.OrderID  --------------------- LEFT JOIN  ---Muestra el nombre del cliente y cada pedido
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CompanyName

CREATE PROCEDURE PS_ClientePedido  ----------------------------------------------------------------store procedure   
AS
BEGIN
SELECT  Customers.CompanyName, Orders.OrderID  --------------------- LEFT JOIN
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CompanyName
END;

EXEC PS_ClientePedido
-----------------------------------------------------------------

select Customers.CustomerID, Customers.CompanyName, count (Orders.OrderID) as [Pedidos Cliente]   ---muestra solo los totales de los pedidos segun sea el cliente
from Customers
left join  Orders on Customers.CustomerID = Orders.CustomerID
group by Customers.CustomerID, Customers.CompanyName

--------------------------------------
/* TABLA Employees , TABLA Orders*/

select * from Employees
select * from Orders
---------------Muestra el id del empleado, nombre y las ventas realizadas
select Employees.EmployeeID, Employees.FirstName, count (Orders.OrderID) as [Ventas por Empleado] 
FROM Employees
RIGHT JOIN Orders on Employees.EmployeeID = Orders.EmployeeID
group by Employees.EmployeeID, Employees.FirstName
ORDER BY [Ventas por Empleado] DESC
----------------------------------------------------------------------------------
CREATE PROCEDURE PS_EMPLEVENTA_CLIENTE   ------------------------------------------------------------------------------ STORE PROCEDURE   RIGHT join
AS
BEGIN
SELECT Employees.EmployeeID,Employees.FirstName,  count (Orders.OrderID) as [total Ventas empleado]
from Employees
right join Orders on Employees.EmployeeID = Orders.EmployeeID
group by Employees.EmployeeID, Employees.FirstName
ORDER BY [total Ventas empleado] DESC
end;

exec PS_EMPLEVENTA_CLIENTE
-----------------------------------------------------------------------------------------------

drop procedure PS_EMPLEVENTA_CLIENTE

-----------------------------------------------------------------------------------------------------------------
select * from Suppliers
select * from Territories
------------------------------------------------------------------------------------------------------------------
select * from [Order Details]

select Orders.OrderID, Products.ProductName, [Order Details].Quantity, [Order Details].UnitPrice ----------------MUESTRA EL DETALLE DEL PRODUCTO 
from Orders																								-----TABLE ORDER DETAILS   TABLE PRODUCTS
right join [Order Details] on Orders.OrderID = [Order Details].OrderID
right join Products on  [Order Details].ProductID = Products.ProductID


CREATE PROCEDURE PS_DETALLEPRODUC
AS
BEGIN 
select Orders.OrderID, Products.ProductName, [Order Details].Quantity, [Order Details].UnitPrice  
from Orders																								
right join [Order Details] on Orders.OrderID = [Order Details].OrderID
right join Products on  [Order Details].ProductID = Products.ProductID
END;

EXEC PS_DETALLEPRODUC
---------------------------------------------------------------------------------------------------
-----------------------------------------------------------------LISTAR PRODUCTO CON MENOS CANTIDAD EN STOK

SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT 
    Products.ProductID,
    Products.ProductName,
    Products.UnitsInStock,
    Categories.CategoryName,
    Suppliers.CompanyName
FROM 
    Products
JOIN 
    Categories ON Products.CategoryID = Categories.CategoryID
JOIN 
    Suppliers ON Products.SupplierID = Suppliers.SupplierID
WHERE 
    Products.UnitsInStock <10;
------------------------------------------------------------------------------------
select * from Products
select * from [Order Details]


------------------------------------------------------
-- Identificar productos en los pedidos y sus cantidades
SELECT 
    [Order Details].ProductID,
    SUM([Order Details].Quantity) AS TotalQuantity
INTO ---
    #TempStockUpdate
FROM 
    [Order Details]
GROUP BY 
    [Order Details].ProductID;

-- Actualizar el stock en la tabla Products
UPDATE 
    Products
SET 
    UnitsInStock = UnitsInStock - #TempStockUpdate.TotalQuantity
FROM 
    Products
JOIN 
    #TempStockUpdate ON Products.ProductID = #TempStockUpdate.ProductID;

-- Limpiar la tabla temporal
DROP TABLE #TempStockUpdate;

select * from Products
select * from #TempStockUpdate

---------------------------------------------------------------------------------
--Obtener todos los productos y las órdenes asociadas (si las hay):
select Products.ProductID, Products.ProductName, count ([Order Details].OrderID) as [ordenes Asociadas]
from Products
right join [Order Details] on Products.ProductID = [Order Details].ProductID
group by Products.ProductID, Products.ProductName
ORDER BY ProductID ASC


create procedure PS_ORDENASOS----------------------------------PROCEDIMIENTO ALMACENMADO RIGHT JOIN 
AS
BEGIN
select Products.ProductID, Products.ProductName, count ([Order Details].OrderID) as [ordenes Asociadas]
from Products
right join [Order Details] on Products.ProductID = [Order Details].ProductID
group by Products.ProductID, Products.ProductName
ORDER BY ProductID ASC
END;
EXEC PS_ORDENASOS
--------------------------------------------------------
--Listar todos los empleados y sus informes directos (si los hay):
SELECT e1.EmployeeID, e1.FirstName, e1.LastName, e2.ReportsTo
FROM Employees e1
RIGHT JOIN Employees e2 ON e1.EmployeeID = e2.ReportsTo;
----------------------------------------------------------------------------------

--Procedimiento almacenado para obtener información de clientes y sus pedidos:
CREATE PROCEDURE SP_INFORMAPEDIOS
AS
BEGIN
SELECT Customers.CustomerID, Customers.CompanyName, Orders.OrderID
FROM Customers
FULL JOIN  Orders on Customers.CustomerID = Orders.CustomerID
end;

exec SP_INFORMAPEDIOS
-------------------------------------------------------------------------------------------
--Procedimiento almacenado para obtener información de proveedores y los productos que suministran:
select *
from Suppliers
full join Products on Suppliers.SupplierID =Products.SupplierID

