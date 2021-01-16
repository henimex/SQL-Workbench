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
DECODE(H.MaritalStatus, 'S', 'Single', 'M', 'Married', 'Dull') as "sadsa"  FROM Person.Person P INNER JOIN HumanResources.Employee H ON P.BusinessEntityID = H.BusinessEntityID
