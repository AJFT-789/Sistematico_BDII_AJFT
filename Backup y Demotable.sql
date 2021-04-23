USE master;  
GO
--Crea dispositivo de almacenamiento
EXEC sp_addumpdevice 'disk', 'HotelData',   
'D:\BDII III 2021\SQL\BACKUP\HotelData.bak';  
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

USE Hotel
GO

CREATE TABLE dbo.DemoTable
( DemoTableId int IDENTITY(1,1) PRIMARY KEY,
  FirstLargeColumn nvarchar(600),
  BigIntColumn bigint
);
GO

SET NOCOUNT ON;
INSERT INTO DemoTable (FirstLargeColumn,BigIntColumn)
  VALUES('This is some testdata',12345);
GO

