SELECT TOP 10 * FROM Production.Product WHERE Color = 'Black' OR Color = 'Yellow'
SELECT ProductID, Color, Name+' / '+ ProductNumber AS "Ürün Tanýmý" FROM Production.Product WHERE Color = 'Multi' AND StandardCost > 6
SELECT TOP 10 percent * FROM Production.Product WHERE ListPrice > 0