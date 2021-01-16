-- FULL JOIN

SELECT * FROM Person.Person
SELECT * FROM Sales.SalesPerson

SELECT * FROM Person.Person FULL JOIN Sales.SalesPerson ON Person.BusinessEntityID = SalesPerson.BusinessEntityID