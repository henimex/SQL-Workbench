------------------------- TEMEL ANLATIM
use AdventureWorks2017
select * from Person.Person

select BusinessEntityID,PersonType,FirstName,LastName from Person.Person

select Name,ProductNumber,Color,ProductID from Production.Product

-----------------------------

select Title,FirstName,LastName from Person.Person
select Title as "�nvan",Firstname + ' ' + LastName as "�sim Soyisim" from Person.Person -- " " yerine [ ] olabilir. ve as den sonra "" kullanmayada gerek yok tek kelime ise 



select top 10 * from Person.Person
select top 10 percent * from Person.Person --y�zdeyi getirme

------ DERS 2 ------

SELECT TOP 10 * FROM Production.Product WHERE Color = 'Black' OR Color = 'Yellow'
SELECT ProductID, Color, Name+' / '+ ProductNumber AS "�r�n Tan�m�" FROM Production.Product WHERE Color = 'Multi' AND StandardCost > 6
SELECT TOP 10 percent * FROM Production.Product WHERE ListPrice > 0


----------------- SELECT WHERE 

SELECT * FROM Person.Person WHERE PersonType = 'EM'
SELECT * FROM Person.Person WHERE FirstName = 'Ken'

SELECT Name, ProductNumber,Color, SafetyStockLevel FROM Production.Product WHERE Color = 'Black' AND SafetyStockLevel = 500

SELECT * FROM Production.Product WHERE SafetyStockLevel > 500

SELECT * FROM Production.Product WHERE SafetyStockLevel >= 500

SELECT * FROM Production.Product WHERE SafetyStockLevel <= 500

SELECT * FROM Production.Product WHERE SafetyStockLevel != 500 AND ReorderPoint > 700


-------------SELECT DETAYLAR-----------------

select * from Production.Product where ProductNumber  LIKE '%1'

select * from Production.Product where ProductNumber  LIKE 'A%'

select * from Production.Product where ProductNumber  LIKE '%12%'

select * from Production.Product where ProductNumber  LIKE '__-3%'

----------------------------------------�DEV----------------------------------------
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

SELECT Color, SUM(SafetyStockLevel), AVG(ListPrice) FROM Production.Product GROUP BY Color HAVING Color IN ('RED', 'BLUE') --IS NOT NULL DA GELEB�L�R. WHERE YER�NE DE KULLANILIYOR YADA ��FT ARAMA YAPILAB�L�RYOR FAKAT WHERE DEN SONRA AND �LE �K�NC� KOSUL DAN FARKI NEY ?

SELECT MAX(SafetyStockLevel) FROM Production.Product --MAX(SafetyStockLevel) FROM DimProduct

SELECT MIN(SafetyStockLevel) FROM Production.Product

---------------------------------------UPPER & LOWER-------------------------------

SELECT UPPER(Name) FROM Production.Product

SELECT LOWER(ProductNumber) FROM Production.Product

---------------------------------------LEN & DATALENGTH----------------------------
SELECT Name, LEN(Name) AS 'Karakter Say�s�', DATALENGTH(Name) AS BYTE, DATALENGTH(NAME)/LEN(NAME) AS 'Karakter Ba��na BYTE De�eri' FROM Production.Product order by BYTE DESC

-------------------------------KOLON BAGLAMA B�RLE�T�RME & CONCAT------------------

SELECT ProductID, NAME, ProductNumber, CONCAT(ProductID,' - ',NAME,' [',ProductNumber,']') AS 'CONCAT ile Baglama' FROM Production.Product

----------------------------------------LEFT RIGHT SUBSTRING-----------------------

SELECT NAME, CONCAT(LEFT(NAME, 4),' ******** ',RIGHT(NAME,3)) AS 'Crypted' FROM Production.Product

SELECT NAME, CONCAT(SUBSTRING(NAME,1,2),' ******** ',SUBSTRING(NAME,11,2)) AS 'Crypted v2' FROM Production.Product

SELECT NAME, RIGHT(SUBSTRING(NAME,1,6),2) FROM Production.Product --�LK 6 HARF�N SONDAN �K� HARF�


----------------------------------------DISTINCT-----------------------------------

SELECT DISTINCT Color FROM Production.Product

SELECT ProductID, ProductNumber,Name,Color FROM Production.Product
WHERE ProductID IN (SELECT DISTINCT ProductID from Sales.SalesOrderDetail)


SELECT Color, COUNT(ProductID) AS ADET  FROM Production.Product Group BY Color ORDER BY ADET DESC
SELECT * FROM Sales.SalesOrderDetail


----------------------------------------BETWEEN-----------------------------------
SELECT * FROM Production.Product WHERE ProductID BETWEEN 1 AND 500



--KULLANIM FORMATI                      ORTAK B�R KOLON DE�ER� HER �K� TABLODA DA OLMASI GEREKL� ATIYORUM HK_ID ISLEM NO YADA TC G�B�

--SELECT * FROM TABLO_1 INNER JOIN TABLO_2 ON TABLO_1.KOLON_ADI = TABLO_2.KOLON_ADI

SELECT * FROM HumanResources.Employee
SELECT * FROM Person.Person

SELECT * FROM Person.Person INNER JOIN HumanResources.Employee ON Person.BusinessEntityID = Employee.BusinessEntityID
--                1. TABLO                 2. TABLO               1.nin Uzant�s�            2.nin Uzant�s�
--                                                                        ortak alanlar� ise BusinessEntityID

--TAKMA �S�MLE

SELECT * FROM Person.Person P INNER JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID

SELECT H.BusinessEntityID, P.FirstName,P.LastName, H.BirthDate, H.JobTitle, H.MaritalStatus,
/*DECODE(H.MaritalStatus, 'S', 'Single', 'M', 'Married', 'Dull') as "sadsa"*/  FROM Person.Person P INNER JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID

--------------

SELECT P.BusinessEntityID, P.FirstName, P.LastName,H.BirthDate, H.MaritalStatus FROM Person.Person P INNER JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID


-- Gereksiz Kullan�m
SELECT BusinessEntityID, FirstName, LastName, 
(SELECT BirthDate from HumanResources.Employee WHERE BusinessEntityID = Person.BusinessEntityID) AS "Birthdate",
(SELECT MaritalStatus from HumanResources.Employee WHERE BusinessEntityID = Person.BusinessEntityID) AS "Maritial Status"
FROM Person.Person

-- �evreleyen sorgu!!! Sorgumuzu tablo olarak kullanarak tekrar tablo i��erisinde sorgu alabilmek i�in kullanmam�z gereken sorgu.

SELECT * FROM (SELECT * FROM Person.Person p where p.FirstName LIKE '%FER%' ) AS "Sonuc" WHERE Sonuc.EmailPromotion BETWEEN 2 AND 3
--------------
SELECT * FROM Production.Product
SELECT * FROM Sales.SalesOrderDetail

-- LEFT JOIN in Fark� : �ki tabloyu birle�tirirken sonradan eklenen tabloda baglanan ortak alana ait herhangi bir kay�t ikinci tabloda yoksada kay�tlar gelir fakat Null olarak g�r�n�r. A�a��daki �rnekte Product ID �zerinden birle�tirme yap�lm��t�r. Burada Product ID 1,2,3,4 vs olan �r�nler 
-- hi� siparis gecilmedigi gibi 707 vs gibi �r�nlerde birden cok siparis cekilmistir bu ekrandan hangi �r�nden ne kadar siparis edildi�inini say�sal degeri hesaplanabilir ve siparislerin detaylar� tek ekranda g�r�nt�lenebilir.


SELECT P.ProductID, P.Name, P.Color, S.* FROM Production.Product P LEFT JOIN
			  Sales.SalesOrderDetail S ON
			  P.ProductID = S.ProductID ORDER BY P.ProductID



SELECT P.Name, SUM(S.UnitPrice) AS "Toplam Sat�� Fiyat�" FROM Production.Product P LEFT JOIN
			  Sales.SalesOrderDetail S ON
			  P.ProductID = S.ProductID GROUP BY P.Name ORDER BY [Toplam Sat�� Fiyat�] 
	
--RIGHT JOIN   Ayn� i�lem sanki Left Joinlede yap�l�yor gibi ama ben aradaki fark� a��kcas� pek anlamad�m. daha fazla �rnekleme i�lemi ve datayl� anlat�mda net oturabilir. yada ger�ek seneryolarda ihtiya� duyabiliriz.

SELECT * FROM Sales.SalesPerson S RIGHT JOIN Person.Person P
	ON S.BusinessEntityID = P.BusinessEntityID

	-- FULL JOIN

SELECT * FROM Person.Person
SELECT * FROM Sales.SalesPerson

SELECT * FROM Person.Person FULL JOIN Sales.SalesPerson ON Person.BusinessEntityID = SalesPerson.BusinessEntityID




-- �NEML� �� ��E SORGULAR LEFT VE INNER JOIN KULLANIMI HEPS�NE YER VER�DL� BURDA VIDEO 306

SELECT * FROM Production.Product
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.ProductCategory


SELECT P.ProductID, P.Name AS 'Product Name', P.Color, C.Name AS 'Category Name', S.Name AS 'Sub Category Name', P.ListPrice AS 'List Price'
		FROM Production.Product P	
	LEFT JOIN Production.ProductSubcategory S					--INNER JOIN Kullan�ld���nda sadece tam e�le�me olan tablolar gelir Ama �devde e�le�en e�le�meyen t�m kay�tlar�n listelenmesi istendi�i i�in Left Join kullan�ld�.
		ON P.ProductSubcategoryID = S.ProductSubcategoryID 
	INNER JOIN Production.ProductCategory C						--Sub Category nin Ana geli� noktas� Category oldu�u i�in SubCat de bulunan Category ID tablosunda bo� alan yok bu y�zden Null deger zaten d�nmeyece�i i�in INNER JOIN Kullan�labilir. Ayn� zamanda hangi category e�le�mei� kontrolunu bu sorguda ile yap�laiblir.
		ON S.ProductCategoryID = C.ProductCategoryID			--�rnek Olarak : Category (1) Monitor					Category (2) Ekran Kart�            gibi				
																--Sub Categorysi              (1)VA(2)IPS(3)TN			(1)NVIDIA (2)AMD (3)INTEL


SELECT C.Name, COUNT(S.Name) AS "T�r Say�s�"
		FROM Production.Product P	
	LEFT JOIN Production.ProductSubcategory S
		ON P.ProductSubcategoryID = S.ProductSubcategoryID
	INNER JOIN Production.ProductCategory C	
		ON S.ProductCategoryID = C.ProductCategoryID
	GROUP BY C.Name


SELECT S.Name, SUM(P.ListPrice) AS "Fiyat Toplam�"
		FROM Production.Product P	
	LEFT JOIN Production.ProductSubcategory S
		ON P.ProductSubcategoryID = S.ProductSubcategoryID
	INNER JOIN Production.ProductCategory C	
		ON S.ProductCategoryID = C.ProductCategoryID
	GROUP BY S.Name ORDER BY [Fiyat Toplam�] DESC

-------------------------------------------------------------------------

SELECT [Category Name],[Sub Category Name], COUNT(ProductID) AS 'Total Product', SUM([List Price]) AS 'Price Total' FROM
(
SELECT P.ProductID, P.Name AS 'Product Name', P.Color, C.Name AS 'Category Name', S.Name AS 'Sub Category Name', P.ListPrice AS 'List Price'
		FROM Production.Product P	
	LEFT JOIN Production.ProductSubcategory S
		ON P.ProductSubcategoryID = S.ProductSubcategoryID
	INNER JOIN Production.ProductCategory C	
		ON S.ProductCategoryID = C.ProductCategoryID
) ResulTable
	GROUP BY [Category Name], [Sub Category Name]
	HAVING [Category Name] IS NOT NULL
	ORDER BY [Category Name] ASC, [Price Total] DESC

	------------------------------- SORGULAR B�TT� VER�TABANI OLUSTURMA KOMUTLARI D��ER DOSYADA -------------------------------