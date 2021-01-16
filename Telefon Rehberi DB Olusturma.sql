CREATE DATABASE TelefonRehberi
GO
USE TelefonRehberi
GO

CREATE TABLE Kullanici
(
KullaniciID UNIQUEIDENTIFIER PRIMARY KEY,
KullaniciAdi NVARCHAR(20) UNIQUE,
Sifre NVARCHAR(20) NOT NULL
)
GO

INSERT INTO Kullanici (KullaniciID, KullaniciAdi, Sifre) VALUES (NEWID(),'DEMO','DEMO')

GO

CREATE TABLE Rehber
(
ID UNIQUEIDENTIFIER PRIMARY KEY,
Isim NVARCHAR(30) NOT NULL,
Soyisim NVARCHAR(30) NOT NULL,
Tel1 NVARCHAR(12) NOT NULL,
Tel2 NVARCHAR(12),
Tel3 NVARCHAR(12),
Email NVARCHAR(30),
Web NVARCHAR(30),
Adres NVARCHAR(100),
Aciklama NVARCHAR(100)
)
GO

CREATE PROC SP_REHBERKAYITYENI
(
@ID UNIQUEIDENTIFIER,
@Isim NVARCHAR(30),
@Soyisim NVARCHAR(30),
@Tel1 NVARCHAR(12),
@Tel2 NVARCHAR(12),
@Tel3 NVARCHAR(12),
@Email NVARCHAR(30),
@Web NVARCHAR(30),
@Adres NVARCHAR(100),
@Aciklama NVARCHAR(10)
)AS BEGIN 
	INSERT INTO Rehber (ID, Isim, Soyisim,Tel1, Tel2, Tel3, Email, Web, Adres, Aciklama) VALUES (@ID, @Isim, @Soyisim, @Tel1, @Tel2, @Tel3, @Email, @Web, @Adres, @Aciklama) 
	END

GO

CREATE PROC SP_REHBERKAYITDUZENLE
(
@ID UNIQUEIDENTIFIER,
@Isim NVARCHAR(30),
@Soyisim NVARCHAR(30),
@Tel1 NVARCHAR(12),
@Tel2 NVARCHAR(12),
@Tel3 NVARCHAR(12),
@Email NVARCHAR(30),
@Web NVARCHAR(30),
@Adres NVARCHAR(100),
@Aciklama NVARCHAR(10)
)AS BEGIN 
	UPDATE Rehber SET ID = @ID, Isim = @Isim, Soyisim = @Soyisim, Tel1 = @Tel1, Tel2 = @Tel2, Tel3 = @Tel3, Email = @Email, Web = @Web, Adres = @Adres, Aciklama = @Aciklama WHERE ID = @ID 
	END
GO

CREATE PROC SP_REHBERKAYITSIL
(
@ID UNIQUEIDENTIFIER
)AS BEGIN 
	DELETE Rehber WHERE ID = @ID 
	END
GO

CREATE PROC SP_REHBERLISTETUM
 AS BEGIN
	SELECT * FROM Rehber
	END
GO

CREATE PROC SP_REHBERLISTETEK
(
@ID UNIQUEIDENTIFIER
)AS BEGIN
	SELECT * FROM Rehber WHERE ID = @ID
	END
GO