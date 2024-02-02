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

 
 ------------------------------------------ROW NUMBER----------------------------------------------------------
 
 select  ROW_NUMBER() over(order by SC.CurrencyRateID,SC.ModifiedDate desc) AS Nuevo_id,sc.CurrencyRateID, SC.ToCurrencyCode,sc.ModifiedDate
 from sales.CurrencyRate AS SC
 ---------------------------------------------------------------------------------- revisar

select distinct  top 5 ROW_NUMBER() over(order by ModifiedDate desc ) AS Nuevo_id, 

   [CurrencyRateID], --	ID de tasa de moneda
   [FromCurrencyCode],-- Desde código de moneda
   [ToCurrencyCode],-- 	A código de moneda
   [ModifiedDate]--- 	Fecha de modificación

 from
    [sales].[CurrencyRate] AS[cr] 
  --order by
  --[ModifiedDate] desc

  select * from sales.CurrencyRate
 --------------------------------------------------------------------------------

 --------------------------------------------------------------------------------
--SELECT 
--    ROW_NUMBER() OVER (ORDER BY [ModifiedDate] desc) AS RowNumber,
--    [CurrencyRateID],
--    [FromCurrencyCode],
--    [ToCurrencyCode],
--    [ModifiedDate]
--FROM
--    [sales].[CurrencyRate] AS [cr]
--ORDER BY
--    [ModifiedDate] DESC
--OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-------------------------TABLAS TEMPORALES-------------------------------------------------------


  
