---MERGE SQL statement 

MERGE Demo_DW.dbo.Products AS TARGET
USING ADW.dbo.UpdatedProducts AS SOURCE 
ON (TARGET.ProductID = SOURCE.ProductID) 

WHEN MATCHED AND TARGET.ProductName <> SOURCE.ProductName 
OR TARGET.Rate <> SOURCE.Rate THEN 
UPDATE SET TARGET.ProductName = SOURCE.ProductName, 
TARGET.Rate = SOURCE.Rate 

WHEN NOT MATCHED BY TARGET THEN 
INSERT (ProductID, ProductName, Rate) 
VALUES (SOURCE.ProductID, SOURCE.ProductName, SOURCE.Rate)

WHEN NOT MATCHED BY SOURCE THEN 
DELETE

OUTPUT $action, 
DELETED.ProductID AS TargetProductID, 
DELETED.ProductName AS TargetProductName, 
DELETED.Rate AS TargetRate, 
INSERTED.ProductID AS SourceProductID, 
INSERTED.ProductName AS SourceProductName, 
INSERTED.Rate AS SourceRate; 

SELECT @@ROWCOUNT;
GO