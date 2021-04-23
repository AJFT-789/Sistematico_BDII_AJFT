
-- =============================================
-- Create database on multiple filegroups
-- =============================================
IF EXISTS (
  SELECT * 
    FROM sys.databases 
   WHERE name = N'Hotel'
)
  DROP DATABASE Hotel
GO

CREATE DATABASE Hotel
ON PRIMARY
	(NAME = Hotel_Data,
	  FILENAME = N'D:\Sistematico BDII III 2021\BDII III 2021\SQL\DATA\Hotel_Data.mdf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%),
	
	( NAME = Hotel_Data_2,
	  FILENAME = N'D:\Sistematico BDII III 2021\BDII III 2021\SQL\DATA\Hotel_Data_2.ndf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%),

FILEGROUP Hotel_filegroup1
	( NAME = Hotel_Data_3,
	  FILENAME = N'D:\Sistematico BDII III 2021\BDII III 2021\SQL\DATA\Hotel_Data_3.ndf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%),
	
	( NAME = Hotel_Data_4,
	  FILENAME = N'D:\Sistematico BDII III 2021\BDII III 2021\SQL\DATA\Hotel_Data_4.ndf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%),

FILEGROUP Hotel_group_2
	( NAME = Hotel_Data_5,
	  FILENAME = N'D:\Sistematico BDII III 2021\BDII III 2021\SQL\DATA\Hotel_Data_5.ndf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%)

LOG ON
	( NAME = Hotel_Log_1,
	  FILENAME = N'D:\Sistematico BDII III 2021\BDII III 2021\SQL\LOG\Hotel_Log_1.ldf',
          SIZE = 10MB,
          MAXSIZE = 50MB,
          FILEGROWTH = 10%),

	( NAME = Hotel_Log_2,
	  FILENAME = N'D:\Sistematico BDII III 2021\BDII III 2021\SQL\LOG\Hotel_Log_2.ldf',
          SIZE = 5MB,
          MAXSIZE = 25MB,
          FILEGROWTH = 5MB)
GO


USE master;  
GO
--Crea dispositivo de almacenamiento
EXEC sp_addumpdevice 'disk', 'HotelData',   
'D:\Sistematico BDII III 2021\BDII III 2021\SQL\BACKUP\HotelData.bak';  
GO

--Crear el primer backup
BACKUP DATABASE Hotel   
 TO HotelData  
   WITH FORMAT, INIT, NAME = N'Hotel – Full Backup' ;  
GO  

--Crea nuevos backups
DECLARE @BackupName VARCHAR(100)
SET @BackupName = N'Hotel – Full Backup ' + FORMAT(GETDATE(),'yyyyMMdd_hhmmss');

BACKUP DATABASE Hotel
TO HotelData
WITH NOFORMAT, NOINIT, NAME = @BackupName,
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

RESTORE FILELISTONLY FROM HotelData
GO
RESTORE HEADERONLY FROM HotelData
GO

SELECT      *
FROM        sys.backup_devices
GO

--EXEC sp_dropdevice 'HotelData', 'delfile' ;  
--GO 




BACKUP DATABASE [Hotel] 
TO  DISK = N'D:\Sistematico BDII III 2021\BDII III 2021\SQL\BACKUP\HotelData.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'AdventureWorks2016-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10;




BACKUP DATABASE [Hotel] 
TO  DISK = N'D:\Sistematico BDII III 2021\BDII III 2021\SQL\BACKUP\HotelDataDIF.bak' 
WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'AdventureWorks2016-Differential Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10




