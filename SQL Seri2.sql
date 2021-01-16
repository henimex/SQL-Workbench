CREATE TABLE Customer
(
ID INT PRIMARY KEY,
NAME NVARCHAR(30),
SURNAME NVARCHAR(30),
EMAIL NVARCHAR(40),
TARIH DATETIME DEFAULT GETDATE()
)

CREATE TABLE Login
(
MID int PRIMARY KEY,
USERNAME nvarchar(20) unique not null,
PASSWORD nvarchar(12) check(len(PASSWORD)>6),
SECRETQ nvarchar(40),
SECRETA nvarchar(40),
FOREIGN KEY (MID) references Customer(ID)
)

CREATE TABLE Product
(
ProductID INT PRIMARY KEY,
DESCRIPTION NVARCHAR(50) NOT NULL,
STOCK INT CHECK (STOCK>0)
)

CREATE TABLE Sales
(
SalesID INT PRIMARY KEY,
MID INT NOT NULL,
UID INT NOT NULL,
SOLD INT CHECK(SOLD>0)
)

ALTER PROCEDURE SP_Customer_New --OLUSTURURKEN CREATE DUZENLEME YAPILACAGI ZAMAN ALTER
(
@ID INT,
@NAME NVARCHAR(30),
@SURNAME NVARCHAR(30),
@EMAIL NVARCHAR(40),
@USERNAME nvarchar(20),
@PASSWORD nvarchar(12),
@SECRETQ nvarchar(40),
@SECRETA nvarchar(40)
)
AS
BEGIN
INSERT INTO Customer (ID, NAME, SURNAME, EMAIL) VALUES (@ID, @NAME, @SURNAME, @EMAIL)
	IF(@@ROWCOUNT>0)
	BEGIN
	INSERT INTO Login (MID, USERNAME,PASSWORD,SECRETQ,SECRETA) VALUES (@ID, @USERNAME,@PASSWORD,@SECRETQ,@SECRETA)
	END
END

CREATE PROC SP_New_Product
(
@ProductID INT,
@DESCRIPTION NVARCHAR(50),
@STOCK INT
)
AS
BEGIN
INSERT INTO Product (ProductID, DESCRIPTION, STOCK) VALUES (@ProductID, @DESCRIPTION, @STOCK)
END


CREATE PROC SP_Edit_Product
(
@ProductID INT,
@DESCRIPTION NVARCHAR(50),
@STOCK INT
)
AS
BEGIN
UPDATE Product SET ProductID = @ProductID, DESCRIPTION = @DESCRIPTION, STOCK = @STOCK WHERE ProductID = @ProductID
END


CREATE PROC SP_Delete_Product
(
@ProductID INT
)
AS
BEGIN
DELETE Product WHERE ProductID = @ProductID
END


CREATE PROC SP_List_Product
AS
BEGIN
SELECT * FROM Product
END

CREATE PROC SP_List_Single_Product
(
@ProductID INT
)
AS
BEGIN
SELECT * FROM Product WHERE ProductID = @ProductID
END

CREATE PROC Sell_Product
(
@SalesID INT,
@MID INT,
@UID INT,
@SOLD INT
)
AS
BEGIN
INSERT INTO SALES (SalesID, MID, UID, SOLD) VALUES (@SalesID, @MID, @UID, @SOLD)
END

CREATE PROC SP_Edit_Sale
(
@SalesID INT,
@MID INT,
@UID INT,
@SOLD INT
)
AS
BEGIN
UPDATE Sales SET MID = @MID, UID = @UID, SOLD = @SOLD WHERE SalesID = @SalesID
END

CREATE PROC SP_Delete_Sale
(
@SalesID INT
)
AS
BEGIN
DELETE Sales WHERE SalesID = @SalesID
END

CREATE PROC SP_Edit_Customer
(
@ID INT,
@NAME NVARCHAR(30),
@SURNAME NVARCHAR(30),
@EMAIL NVARCHAR(40),
@PASSWORD nvarchar(12),
@SECRETQ nvarchar(40),
@SECRETA nvarchar(40)
)
AS
BEGIN
UPDATE Customer SET NAME = @NAME, SURNAME = @SURNAME, EMAIL = EMAIL WHERE ID = @ID
	IF(@@ROWCOUNT>0)
	BEGIN
	UPDATE Login SET PASSWORD = @PASSWORD, SECRETQ = @SECRETQ, SECRETA = @SECRETA
	END
END

CREATE PROC SP_Delete_Customer
(
@ID INT
)
AS
BEGIN
DELETE Customer WHERE ID = @ID
	IF(@@ROWCOUNT>0)
	BEGIN
	DELETE Login WHERE MID = @ID
	END
END

CREATE PROC SP_List_Customers
(
@ID INT
)
AS
BEGIN
SELECT * FROM Customer WHERE ID = @ID
END

ALTER PROC SP_List_Sales
(
@SalesID INT
)
WITH ENCRYPTION --��FRELEMEK ���N KULLANILIYOR
AS
BEGIN
SELECT * FROM Sales WHERE SalesID = @SalesID
END

SELECT * FROM Sales;
SELECT * FROM Product;
SELECT * FROM Customer;

---- BUNA SONRA BAKILACAK ----
/*
CREATE PROC SP_List_Detailed_Sales
(
@ProductID INT,
@DESCRIPTION VARCHAR(50),
@STOCK INT,
@ID INT,
@NAME VARCHAR(30),
@SURNAME VARCHAR(30),
@SOLD INT,
@UID INT,
@MID INT

SELECT P.@DESCRIPTION AS '�r�n Ad�', P.@STOCK AS 'Stok Adeti', S.@SOLD AS 'Satilan Adet', P.STOCK - S.SOLD AS 'Kalan', C.@NAME +' '+ C.@SURNAME AS 'M��teri Ad�' FROM Sales S LEFT JOIN Product P ON S.UID = P.ProductID
					  LEFT JOIN Customer C ON S.MID = C.ID

SELECT P.DESCRIPTION AS '�r�n Ad�', P.STOCK AS 'Stok Adeti', S.SOLD AS 'Satilan Adet', P.STOCK - S.SOLD AS 'Kalan', C.NAME +' '+ C.SURNAME AS 'M��teri Ad�' FROM Sales S LEFT JOIN Product P ON S.UID = P.ProductID
					  LEFT JOIN Customer C ON S.MID = C.ID

*/

----------------------------------------DECLARE------------------------------------
DECLARE @FULLNAME NVARCHAR(30)
SET @FULLNAME = 'Ferhat OYGUR'
PRINT @FULLNAME

DECLARE @FULLNAME2 NVARCHAR(30) = 'Ferhat OYGUR V2'
PRINT @FULLNAME2

DECLARE @ProductCount INT
SELECT @ProductCount = COUNT(*) FROM Production.Product

DECLARE @RENK NVARCHAR(10) = 'Black'
SELECT * FROM Production.Product WHERE Color = @RENK

DECLARE @Personel TABLE
(
ID INT,
NAME NVARCHAR(20)
)

INSERT INTO @Personel (ID, NAME) VALUES (1, 'Ferhat')
SELECT * FROM @Personel

-------------------------------------IF-------------------------------------------

DECLARE @KULLANICI NVARCHAR(20), @SIFRE NVARCHAR(20)
SET @KULLANICI = 'Demo'
SET @SIFRE = 'Demo'

IF @KULLANICI = 'Demo1' AND @SIFRE='Demo'
BEGIN
PRINT 'Giri� Ba�ar�l�'
END
ELSE
BEGIN
PRINT 'Giri� Ba�ar�s�z'
END

DECLARE @STOK INT
SELECT @STOK = COUNT(*) FROM Production.Product P WHERE P.Color = 'Red' -- Black -- Yellow
	
	IF @STOK >= 550
	BEGIN
	PRINT 'Stok Seviyesi Maximum S�n�rlar ��erisindedir'
	PRINT @STOK
	END
	ELSE IF @STOK >= 200 AND @STOK <= 549
	BEGIN
	PRINT 'Stok Seviyesi Normal Durumdad�r'
	PRINT @STOK
	END
	ELSE IF @STOK >=50 AND @STOK <=199
	BEGIN
	PRINT 'Stok Seviyesi Minimum D�zeydedir.'
	PRINT @STOK
	END
	ELSE IF @STOK >=2 AND @STOK <=49
	BEGIN
	PRINT 'Stok Seviyesi Kritik D�zeydedir.'
	PRINT @STOK
	END
	ELSE 
	BEGIN
	PRINT 'Stok Seviye Rapor Hatas�'
	PRINT @STOK
	END

-------------------------------------CASE WHEN-------------------------------------------

SELECT DISTINCT COLOR FROM Production.Product
SELECT * FROM Production.Product

SELECT NAME, (CASE Color 
			  WHEN 'Black' THEN 'K�rm�z�'
			  WHEN 'Blue' THEN 'Mavi'
			  WHEN 'Grey' THEN 'Gri'
			  WHEN 'Multi' THEN '�ok Renkli'
			  WHEN 'Red' THEN 'K�rm�z�'
			  WHEN 'Silver' THEN 'G�m��'
			  WHEN 'Silver/Black' THEN 'G�m��/Siyah'
			  WHEN 'White' THEN 'Beyaz'
			  WHEN 'Yellow' THEN 'Sar�'
			  ELSE 'Renksiz' END) AS 'Renk' FROM Production.Product

-------------------------------------WHILE----------------------------------------------

DECLARE @ISIM NVARCHAR(20) = 'FERHAT OYGUR'
DECLARE @SAYAC INT = 0

WHILE @SAYAC <= LEN(@ISIM)
BEGIN
PRINT SUBSTRING(@ISIM, 1, @SAYAC)
SET @SAYAC = @SAYAC + 1
END
PRINT 'WHILE SONLANDIRILDI'

-------------------------------------TEMP TABLE-----------------------------------------

CREATE TABLE #Login
(
MID int PRIMARY KEY,
USERNAME nvarchar(20) unique not null,
PASSWORD nvarchar(12) check(len(PASSWORD)>6),
SECRETQ nvarchar(40),
SECRETA nvarchar(40)
)

INSERT INTO #Login (MID, USERNAME, PASSWORD, SECRETQ, SECRETA) VALUES (01,'henimex','namsfli3', 'What is your first school name', 'Cumhuriyet �lk Okulu')
INSERT INTO #Login (MID, USERNAME, PASSWORD, SECRETQ, SECRETA) VALUES (02,'shenimex','osdmv7w6', 'What is your first pets name', 'Rodin')
INSERT INTO #Login (MID, USERNAME, PASSWORD, SECRETQ, SECRETA) VALUES (03,'joseph','15daw#dsa!', 'What is your first date name', 'Telly')

SELECT * FROM #Login

-------------------------------------TRY CATCH-----------------------------------------
BEGIN TRY
INSERT INTO #Login (MID, USERNAME, PASSWORD, SECRETQ, SECRETA) VALUES (03,'maria','r3qdfa12dw!', 'What is your first car model', 'Ford')
END TRY
BEGIN CATCH
PRINT 'HATA'
END CATCH

-----------------------------KULLANICI TANIMLI FONKS�YONLAR(SCALER)------------------
ALTER FUNCTION URUNIDTONAME
(
@ID INT
)
RETURNS NVARCHAR(200)
AS

BEGIN
DECLARE @FOUNDPRO NVARCHAR(200)

IF(EXISTS(SELECT * FROM Production.Product WHERE ProductID = @ID))

BEGIN
SELECT @FOUNDPRO=Name FROM Production.Product WHERE ProductID = @ID
END

ELSE

BEGIN
SET @FOUNDPRO = 'Arad���n�z ID De�erine Sahip �r�n Bulunamad�'
END

RETURN @FOUNDPRO

END

SELECT DBO.URUNIDTONAME(321)
SELECT * FROM Production.Product


--------------------------GER�YE SORGU DONEN FUNCTION-------------------------------
ALTER FUNCTION Grupla  --ISTEDIGIM G�B� CALISMADI
(
@ID INT
)
RETURNS TABLE
AS
RETURN(SELECT Name, ProductNumber FROM Production.Product /*WHERE ProductID= @ID*/)

SELECT * FROM DBO.Grupla(326)

--------------------------------------TRIGGER---------------------------------------

CREATE TABLE TriggerTablosu
(
MID int PRIMARY KEY,
USERNAME nvarchar(20),
PASSWORD nvarchar(12),
SECRETQ nvarchar(40),
SECRETA nvarchar(40)
)

INSERT INTO TriggerTablosu (MID, USERNAME, PASSWORD, SECRETQ, SECRETA) VALUES (01,'henimex','namsfli3', 'What is your first school name', 'Cumhuriyet �lk Okulu')
INSERT INTO TriggerTablosu (MID, USERNAME, PASSWORD, SECRETQ, SECRETA) VALUES (02,'shenimex','osdmv7w6', 'What is your first pets name', 'Rodin')
INSERT INTO TriggerTablosu (MID, USERNAME, PASSWORD, SECRETQ, SECRETA) VALUES (03,'joseph','15daw#dsa!', 'What is your first date name', 'Telly')

SELECT * FROM TriggerTablosu

ALTER TRIGGER T1 ON TriggerTablosu --FROM DELETED FROM INSERTED --AFTER KOMUT GEL�P �ALI�TIKTAN SONRA YAZILIR - FOR ��LEMDEN ONCE �ALI�AN B�R TR�GGERDIR
AFTER INSERT AS 
BEGIN
--DECLARE @SILINEN VARCHAR(500)
--SELECT @SILINEN = CONCAT(MID,' ', USERNAME,' ', PASSWORD,' ', SECRETQ,' ',SECRETA) FROM inserted -- S�L�NEN YADA DEG�SEN DATALARI TUTMA ���N KAYNAK ARASTIRILACAK
INSERT INTO TRIGGER_LOG2 (TABLOADI, KOMUT) VALUES ('TriggerTablosu', 'INSERT')
END

CREATE TABLE TRIGGER_LOG2
(ID INT PRIMARY KEY IDENTITY(1,1), TABLOADI VARCHAR(30),DATE DATETIME DEFAULT GETDATE(),KOMUT VARCHAR(30))

SELECT * FROM TriggerTablosu 
SELECT * FROM TRIGGER_LOG2

ALTER TRIGGER PASSWORDCHAR ON TriggerTablosu
FOR INSERT
AS
BEGIN
IF EXISTS (SELECT * FROM INSERTED WHERE LEN(PASSWORD)<10)
BEGIN
RAISERROR('�ifreniz En Az 10 Haneli Olmal�d�r',1,1)
ROLLBACK TRANSACTION
RETURN
END
END

INSERT INTO TriggerTablosu (MID, USERNAME, PASSWORD, SECRETQ, SECRETA) VALUES (05,'DWA2','32121', 'What is your first date name', 'JACJ')