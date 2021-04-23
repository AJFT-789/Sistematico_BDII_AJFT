IF OBJECT_ID('TempDB..#RestoreHeaderOnlyData') IS NOT NULL
DROP TABLE #RestoreHeaderOnlyData
GO
CREATE TABLE #RestoreHeaderOnlyData( 
BackupName NVARCHAR(128) 
,BackupDescription NVARCHAR(255) 
,BackupType smallint 
,ExpirationDate datetime 
,Compressed tinyint 
,Position smallint 
,DeviceType tinyint 
,UserName NVARCHAR(128) 
,ServerName NVARCHAR(128) 
,DatabaseName NVARCHAR(128) 
,DatabaseVersion INT 
,DatabaseCreationDate datetime 
,BackupSize numeric(20,0) 
,FirstLSN numeric(25,0) 
,LastLSN numeric(25,0) 
,CheckpointLSN numeric(25,0) 
,DatabaseBackupLSN numeric(25,0) 
,BackupStartDate datetime 
,BackupFinishDate datetime 
,SortOrder smallint 
,CodePage smallint 
,UnicodeLocaleId INT 
,UnicodeComparisonStyle INT 
,CompatibilityLevel tinyint 
,SoftwareVendorId INT 
,SoftwareVersionMajor INT 
,SoftwareVersionMinor INT 
,SoftwareVersionBuild INT 
,MachineName NVARCHAR(128) 
,Flags INT 
,BindingID uniqueidentifier 
,RecoveryForkID uniqueidentifier 
,Collation NVARCHAR(128) 
,FamilyGUID uniqueidentifier 
,HasBulkLoggedData INT 
,IsSnapshot INT 
,IsReadOnly INT 
,IsSingleUser INT 
,HasBackupChecksums INT 
,IsDamaged INT 
,BeginsLogChain INT 
,HasIncompleteMetaData INT 
,IsForceOffline INT 
,IsCopyOnly INT 
,FirstRecoveryForkID uniqueidentifier 
,ForkPointLSN numeric(25,0) 
,RecoveryModel NVARCHAR(128) 
,DifferentialBaseLSN numeric(25,0) 
,DifferentialBaseGUID uniqueidentifier 
,BackupTypeDescription NVARCHAR(128) 
,BackupSetGUID uniqueidentifier 
,CompressedBackupSize BIGINT
,Containment INT
,KeyAlgorithm varchar(500)
,EncryptorThumbprint varchar(500)
,EncryptorType varchar(500)
) 

INSERT INTO #RestoreHeaderOnlyData 
EXEC('RESTORE HEADERONLY FROM HotelData') 

 
DECLARE @File smallint
SELECT @File = MAX(Position) 
FROM #RestoreHeaderOnlyData 
WHERE BackupName = 'Hotel – Full Backup 20201108_105831' 

RESTORE DATABASE Hotel
FROM HotelData 
WITH FILE = @File, 
    MOVE N'Hotel_Data' TO N'D:\Sistematico BDII III 2021\BDII III 2021\REEMPLACE\SQL\DATA\Hotel20201108_105831_Data.mdf', 
	MOVE N'Hotel_Data_2' TO N'D:\Sistematico BDII III 2021\BDII III 2021\REEMPLACE\SQL\DATA\DATA\Hotel20201108_105831_2.mdf', 
	MOVE N'Hotel_Data_3' TO N'D:\Sistematico BDII III 2021\BDII III 2021\REEMPLACE\SQL\DATA\Hotel20201108_105831_3.mdf', 
	MOVE N'Hotel_Data_4' TO N'D:\Sistematico BDII III 2021\BDII III 2021\REEMPLACE\SQL\\DATA\Hotel20201108_105831_4.mdf', 
	MOVE N'Hotel_Data_5' TO N'D:\Sistematico BDII III 2021\BDII III 2021\REEMPLACE\SQL\DATA\Hotel20201108_105831_5.mdf', 
    MOVE N'Hotel_Log_1' TO N'D:\Sistematico BDII III 2021\BDII III 2021\REEMPLACE\SQL\LOG\Hotel20201108_105831_Log_1.ldf', 
	MOVE N'Hotel_Log_2' TO N'D:\Sistematico BDII III 2021\BDII III 2021\REEMPLACE\SQL\LOG\Hotel20201108_105831_Log_2.ldf', 
NOUNLOAD, REPLACE, STATS = 10
GO


