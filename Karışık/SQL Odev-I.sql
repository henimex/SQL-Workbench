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