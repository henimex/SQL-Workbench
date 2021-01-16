/*
use AdventureWorks2017
select * from Person.Person

select BusinessEntityID,PersonType,FirstName,LastName from Person.Person

select Name,ProductNumber,Color,ProductID from Production.Product

-----------------------------

select Title,FirstName,LastName from Person.Person
select Title as "Ünvan",Firstname + ' ' + LastName as "Ýsim Soyisim" from Person.Person -- " " yerine [ ] olabilir. ve as den sonra "" kullanmayada gerek yok tek kelime ise 

*/

select top 10 * from Person.Person
select top 10 percent * from Person.Person --yüzdeyi getirme

