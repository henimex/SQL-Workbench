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
	