
SELECT P.BusinessEntityID, P.FirstName, P.LastName,H.BirthDate, H.MaritalStatus FROM Person.Person P INNER JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID


-- Gereksiz Kullaným
SELECT BusinessEntityID, FirstName, LastName, 
(SELECT BirthDate from HumanResources.Employee WHERE BusinessEntityID = Person.BusinessEntityID) AS "Birthdate",
(SELECT MaritalStatus from HumanResources.Employee WHERE BusinessEntityID = Person.BusinessEntityID) AS "Maritial Status"
FROM Person.Person

-- Çevreleyen sorgu!!! Sorgumuzu tablo olarak kullanarak tekrar tablo iöçerisinde sorgu alabilmek için kullanmamýz gereken sorgu.

SELECT * FROM (SELECT * FROM Person.Person p where p.FirstName LIKE '%FER%' ) AS "Sonuc" WHERE Sonuc.EmailPromotion BETWEEN 2 AND 3