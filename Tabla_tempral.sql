
-------------------------TABLAS TEMPORALES-------------------------------------------------------------

-- tabla temporal global ##
--tabla local #
USE AdventureWorks2022
--CREATE TABLE dbo.Employee (
--    [EmployeeID] INT NOT NULL PRIMARY KEY CLUSTERED,
--    [Name] NVARCHAR(100) NOT NULL,
--    [Position] VARCHAR(100) NOT NULL,
--    [Department] VARCHAR(100) NOT NULL,
--    [Address] NVARCHAR(1024) NOT NULL,
--    [AnnualSalary] DECIMAL(10, 2) NOT NULL,
--    [ValidFrom] DATETIME2 GENERATED ALWAYS AS ROW START,
--    [ValidTo] DATETIME2 GENERATED ALWAYS AS ROW END,
--    PERIOD FOR SYSTEM_TIME(ValidFrom, ValidTo)
--)
--WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.EmployeeHistory

SELECT * FROM Production.Location
--------------------------------------------------Tabla temporal---
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

select LocationID,Name,CostRate,Availability,ModifiedDate 
from Production.Location
where CostRate = 0

drop table  ##location_temp

SELECT * FROM Production.Location
select * from ##location_temp


delete from ##location_temp
where LocationID =4

update ##location_temp
set CostRate =5
where LocationID in(6,7)

-------------------------------------------------------









