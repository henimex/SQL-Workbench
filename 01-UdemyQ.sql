------------------------- TEMEL ANLATIM
use AdventureWorks2017
select * from Person.Person

select BusinessEntityID,PersonType,FirstName,LastName from Person.Person

select Name,ProductNumber,Color,ProductID from Production.Product

-----------------------------

select Title,FirstName,LastName from Person.Person
select Title as "Ünvan",Firstname + ' ' + LastName as "Ýsim Soyisim" from Person.Person -- " " yerine [ ] olabilir. ve as den sonra "" kullanmayada gerek yok tek kelime ise 



select top 10 * from Person.Person
select top 10 percent * from Person.Person --yüzdeyi getirme

------ DERS 2 ------

SELECT TOP 10 * FROM Production.Product WHERE Color = 'Black' OR Color = 'Yellow'
SELECT ProductID, Color, Name+' / '+ ProductNumber AS "Ürün Tanýmý" FROM Production.Product WHERE Color = 'Multi' AND StandardCost > 6
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

SELECT MAX(SafetyStockLevel) FROM Production.Product --MAX(SafetyStockLevel) FROM DimProduct

SELECT MIN(SafetyStockLevel) FROM Production.Product

---------------------------------------UPPER & LOWER-------------------------------

SELECT UPPER(Name) FROM Production.Product

SELECT LOWER(ProductNumber) FROM Production.Product

---------------------------------------LEN & DATALENGTH----------------------------
SELECT Name, LEN(Name) AS 'Karakter Sayýsý', DATALENGTH(Name) AS BYTE, DATALENGTH(NAME)/LEN(NAME) AS 'Karakter Baþýna BYTE Deðeri' FROM Production.Product order by BYTE DESC

-------------------------------KOLON BAGLAMA BÝRLEÞTÝRME & CONCAT------------------

SELECT ProductID, NAME, ProductNumber, CONCAT(ProductID,' - ',NAME,' [',ProductNumber,']') AS 'CONCAT ile Baglama' FROM Production.Product

----------------------------------------LEFT RIGHT SUBSTRING-----------------------

SELECT NAME, CONCAT(LEFT(NAME, 4),' ******** ',RIGHT(NAME,3)) AS 'Crypted' FROM Production.Product

SELECT NAME, CONCAT(SUBSTRING(NAME,1,2),' ******** ',SUBSTRING(NAME,11,2)) AS 'Crypted v2' FROM Production.Product

SELECT NAME, RIGHT(SUBSTRING(NAME,1,6),2) FROM Production.Product --ÝLK 6 HARFÝN SONDAN ÝKÝ HARFÝ


----------------------------------------DISTINCT-----------------------------------

SELECT DISTINCT Color FROM Production.Product

SELECT ProductID, ProductNumber,Name,Color FROM Production.Product
WHERE ProductID IN (SELECT DISTINCT ProductID from Sales.SalesOrderDetail)


SELECT Color, COUNT(ProductID) AS ADET  FROM Production.Product Group BY Color ORDER BY ADET DESC
SELECT * FROM Sales.SalesOrderDetail


----------------------------------------BETWEEN-----------------------------------
SELECT * FROM Production.Product WHERE ProductID BETWEEN 1 AND 500



--KULLANIM FORMATI                      ORTAK BÝR KOLON DEÐERÝ HER ÝKÝ TABLODA DA OLMASI GEREKLÝ ATIYORUM HK_ID ISLEM NO YADA TC GÝBÝ

--SELECT * FROM TABLO_1 INNER JOIN TABLO_2 ON TABLO_1.KOLON_ADI = TABLO_2.KOLON_ADI

SELECT * FROM HumanResources.Employee
SELECT * FROM Person.Person

SELECT * FROM Person.Person INNER JOIN HumanResources.Employee ON Person.BusinessEntityID = Employee.BusinessEntityID
--                1. TABLO                 2. TABLO               1.nin Uzantýsý            2.nin Uzantýsý
--                                                                        ortak alanlarý ise BusinessEntityID

--TAKMA ÝSÝMLE

SELECT * FROM Person.Person P INNER JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID

SELECT H.BusinessEntityID, P.FirstName,P.LastName, H.BirthDate, H.JobTitle, H.MaritalStatus,
/*DECODE(H.MaritalStatus, 'S', 'Single', 'M', 'Married', 'Dull') as "sadsa"*/  FROM Person.Person P INNER JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID

--------------

SELECT P.BusinessEntityID, P.FirstName, P.LastName,H.BirthDate, H.MaritalStatus FROM Person.Person P INNER JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID


-- Gereksiz Kullaným
SELECT BusinessEntityID, FirstName, LastName, 
(SELECT BirthDate from HumanResources.Employee WHERE BusinessEntityID = Person.BusinessEntityID) AS "Birthdate",
(SELECT MaritalStatus from HumanResources.Employee WHERE BusinessEntityID = Person.BusinessEntityID) AS "Maritial Status"
FROM Person.Person

-- Çevreleyen sorgu!!! Sorgumuzu tablo olarak kullanarak tekrar tablo iöçerisinde sorgu alabilmek için kullanmamýz gereken sorgu.

SELECT * FROM (SELECT * FROM Person.Person p where p.FirstName LIKE '%FER%' ) AS "Sonuc" WHERE Sonuc.EmailPromotion BETWEEN 2 AND 3
--------------
SELECT * FROM Production.Product
SELECT * FROM Sales.SalesOrderDetail

-- LEFT JOIN in Farký : Ýki tabloyu birleþtirirken sonradan eklenen tabloda baglanan ortak alana ait herhangi bir kayýt ikinci tabloda yoksada kayýtlar gelir fakat Null olarak görünür. Aþaðýdaki örnekte Product ID üzerinden birleþtirme yapýlmýþtýr. Burada Product ID 1,2,3,4 vs olan ürünler 
-- hiç siparis gecilmedigi gibi 707 vs gibi ürünlerde birden cok siparis cekilmistir bu ekrandan hangi üründen ne kadar siparis edildiðinini sayýsal degeri hesaplanabilir ve siparislerin detaylarý tek ekranda görüntülenebilir.


SELECT P.ProductID, P.Name, P.Color, S.* FROM Production.Product P LEFT JOIN
			  Sales.SalesOrderDetail S ON
			  P.ProductID = S.ProductID ORDER BY P.ProductID



SELECT P.Name, SUM(S.UnitPrice) AS "Toplam Satýþ Fiyatý" FROM Production.Product P LEFT JOIN
			  Sales.SalesOrderDetail S ON
			  P.ProductID = S.ProductID GROUP BY P.Name ORDER BY [Toplam Satýþ Fiyatý] 
	
--RIGHT JOIN   Ayný iþlem sanki Left Joinlede yapýlýyor gibi ama ben aradaki farký açýkcasý pek anlamadým. daha fazla örnekleme iþlemi ve dataylý anlatýmda net oturabilir. yada gerçek seneryolarda ihtiyaç duyabiliriz.

SELECT * FROM Sales.SalesPerson S RIGHT JOIN Person.Person P
	ON S.BusinessEntityID = P.BusinessEntityID

	-- FULL JOIN

SELECT * FROM Person.Person
SELECT * FROM Sales.SalesPerson

SELECT * FROM Person.Person FULL JOIN Sales.SalesPerson ON Person.BusinessEntityID = SalesPerson.BusinessEntityID




-- ÖNEMLÝ ÝÇ ÝÇE SORGULAR LEFT VE INNER JOIN KULLANIMI HEPSÝNE YER VERÝDLÝ BURDA VIDEO 306

SELECT * FROM Production.Product
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.ProductCategory


SELECT P.ProductID, P.Name AS 'Product Name', P.Color, C.Name AS 'Category Name', S.Name AS 'Sub Category Name', P.ListPrice AS 'List Price'
		FROM Production.Product P	
	LEFT JOIN Production.ProductSubcategory S					--INNER JOIN Kullanýldýðýnda sadece tam eþleþme olan tablolar gelir Ama ödevde eþleþen eþleþmeyen tüm kayýtlarýn listelenmesi istendiði için Left Join kullanýldý.
		ON P.ProductSubcategoryID = S.ProductSubcategoryID 
	INNER JOIN Production.ProductCategory C						--Sub Category nin Ana geliþ noktasý Category olduðu için SubCat de bulunan Category ID tablosunda boþ alan yok bu yüzden Null deger zaten dönmeyeceði için INNER JOIN Kullanýlabilir. Ayný zamanda hangi category eþleþmeiþ kontrolunu bu sorguda ile yapýlaiblir.
		ON S.ProductCategoryID = C.ProductCategoryID			--Örnek Olarak : Category (1) Monitor					Category (2) Ekran Kartý            gibi				
																--Sub Categorysi              (1)VA(2)IPS(3)TN			(1)NVIDIA (2)AMD (3)INTEL


SELECT C.Name, COUNT(S.Name) AS "Tür Sayýsý"
		FROM Production.Product P	
	LEFT JOIN Production.ProductSubcategory S
		ON P.ProductSubcategoryID = S.ProductSubcategoryID
	INNER JOIN Production.ProductCategory C	
		ON S.ProductCategoryID = C.ProductCategoryID
	GROUP BY C.Name


SELECT S.Name, SUM(P.ListPrice) AS "Fiyat Toplamý"
		FROM Production.Product P	
	LEFT JOIN Production.ProductSubcategory S
		ON P.ProductSubcategoryID = S.ProductSubcategoryID
	INNER JOIN Production.ProductCategory C	
		ON S.ProductCategoryID = C.ProductCategoryID
	GROUP BY S.Name ORDER BY [Fiyat Toplamý] DESC

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

	------------------------------- SORGULAR BÝTTÝ VERÝTABANI OLUSTURMA KOMUTLARI DÝÐER DOSYADA -------------------------------