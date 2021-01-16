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
	