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