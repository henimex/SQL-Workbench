select * from Production.Product where ProductNumber  LIKE '%1'

select * from Production.Product where ProductNumber  LIKE 'A%'

select * from Production.Product where ProductNumber  LIKE '%12%'

select * from Production.Product where ProductNumber  LIKE '__-3%'

----------------------------------------ÖDEV----------------------------------------
SELECT * FROM HumanResources.Employee WHERE NationalIDNumber LIKE '%96%' AND JobTitle LIKE 'Research%' AND Gender = 'M'

SELECT * FROM Sales.SalesOrderDetail WHERE ProductID > 100 AND ProductID < 1000 AND CarrierTrackingNumber LIKE '%AE'

SELECT * FROM Sales.SalesOrderDetail WHERE ProductID BETWEEN 100 AND 1000 AND CarrierTrackingNumber LIKE '%AE'

----------------------------------------IN NOT IN KULLANIMI----------------------------------------

select * from Production.Product where ProductNumber NOT IN ( 
'AR-5381', 'BA-8327', 'BE-2349', 'BE-2908', 'BL-2036', 'CA-5965', 'CA-6738', 'CA-7457', 'CB-2903', 'CN-6137', 'CR-7833', 'CR-9981', 'CS-2812', 'DC-8732', 'DC-9824', 'DT-2377', 'EC-M092', 'EC-R098', 'EC-T209', 'FE-3760', 'FH-2981', 'FW-1000' )

----------------------------------------ORDER BY----------------------------------------

SELECT * FROM Production.Product WHERE ProductNumber LIKE '%20%' ORDER BY ProductID DESC --ASC DEFAULT

----------------------------------------GROUP BY-----VE GROUP BY HAVING-----------------------------------
SELECT * FROM Production.Product WHERE Color IS NOT NULL

SELECT Color, SUM(SafetyStockLevel) AS STOK, AVG(ListPrice) AS PRICE FROM Production.Product WHERE COLOR IS NOT NULL GROUP BY Color 

SELECT Color, SUM(SafetyStockLevel), AVG(ListPrice) FROM Production.Product GROUP BY Color HAVING Color IN ('RED', 'BLUE') --IS NOT NULL DA GELEBÝLÝR. WHERE YERÝNE DE KULLANILIYOR YADA ÇÝFT ARAMA YAPILABÝLÝRYOR FAKAT WHERE DEN SONRA AND ÝLE ÝKÝNCÝ KOSUL DAN FARKI NEY ?

----------------------------------------DISTINCT-----------------------------------

SELECT DISTINCT Color FROM Production.Product

SELECT ProductID, ProductNumber,Name,Color FROM Production.Product
WHERE ProductID IN (SELECT DISTINCT ProductID from Sales.SalesOrderDetail)


SELECT Color, COUNT(ProductID) AS ADET  FROM Production.Product Group BY Color ORDER BY ADET DESC
SELECT * FROM Sales.SalesOrderDetail


----------------------------------------BETWEEN-----------------------------------
SELECT * FROM Production.Product WHERE ProductID BETWEEN 1 AND 500
