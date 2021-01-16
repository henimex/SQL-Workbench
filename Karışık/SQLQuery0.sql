SELECT * FROM Person.Person WHERE PersonType = 'EM'
SELECT * FROM Person.Person WHERE FirstName = 'Ken'

SELECT Name, ProductNumber,Color, SafetyStockLevel FROM Production.Product WHERE Color = 'Black' AND SafetyStockLevel = 500

SELECT * FROM Production.Product WHERE SafetyStockLevel > 500

SELECT * FROM Production.Product WHERE SafetyStockLevel >= 500

SELECT * FROM Production.Product WHERE SafetyStockLevel <= 500

SELECT * FROM Production.Product WHERE SafetyStockLevel != 500 AND ReorderPoint > 700