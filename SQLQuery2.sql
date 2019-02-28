
MERGE DEMO_DW.[dbo].[Products] AS T
USING ADW.[dbo].Products AS S
ON T.ProductID = S.ProductID

WHEN MATCHED THEN
UPDATE SET T.ProductName = S.ProductName, T.Rate = S.Rate

WHEN NOT MATCHED  BY TARGET THEN
INSERT(productID, ProductName, Rate, Update_Date, Comments) VALUES (S.ProductID, S.ProductName, S.Rate, 
GetDate(), 'current rate or/and name');

SELECT * FROM ADW.[dbo].[Products]
SELECT * FROM DEMO_DW.[dbo].Products
TRUNCATE TABLE DEMO_DW.[dbo].Products
GO
update  ADW.[dbo].[Products]
set rate = 25 WHERE ProductID = 3