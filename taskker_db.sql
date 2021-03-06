USE [master]
GO
/****** Object:  Database [Taskker]    Script Date: 11/21/2013 7:59:53 AM ******/
CREATE DATABASE [Taskker]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Taskker', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Taskker.mdf' , SIZE = 13312KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Taskker_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Taskker_log.ldf' , SIZE = 12352KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Taskker] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Taskker].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Taskker] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Taskker] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Taskker] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Taskker] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Taskker] SET ARITHABORT OFF 
GO
ALTER DATABASE [Taskker] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Taskker] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Taskker] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Taskker] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Taskker] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Taskker] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Taskker] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Taskker] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Taskker] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Taskker] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Taskker] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Taskker] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Taskker] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Taskker] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Taskker] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Taskker] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Taskker] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Taskker] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Taskker] SET RECOVERY FULL 
GO
ALTER DATABASE [Taskker] SET  MULTI_USER 
GO
ALTER DATABASE [Taskker] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Taskker] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Taskker] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Taskker] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Taskker', N'ON'
GO
USE [Taskker]
GO
/****** Object:  User [tskMaster]    Script Date: 11/21/2013 7:59:53 AM ******/
CREATE USER [tskMaster] FOR LOGIN [tskMaster] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [i4ms\md]    Script Date: 11/21/2013 7:59:53 AM ******/
CREATE USER [i4ms\md] FOR LOGIN [i4ms\md] WITH DEFAULT_SCHEMA=[i4ms\md]
GO
ALTER ROLE [db_owner] ADD MEMBER [tskMaster]
GO
/****** Object:  Schema [i4ms\md]    Script Date: 11/21/2013 7:59:53 AM ******/
CREATE SCHEMA [i4ms\md]
GO
/****** Object:  StoredProcedure [dbo].[checkEmail]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkEmail]
    (
  
		@Email VarChar(255)

   )
As
 
SELECT  count(*) As EmailExists FROM [TaskkerUsersProfiles] WHERE ([TaskkerUserEmail] = @Email)

GO
/****** Object:  StoredProcedure [dbo].[checkIdUserProfileDetails]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkIdUserProfileDetails]
    (
  
		@idUser VarChar(255)

   )
As
 
SELECT  *   FROM [TaskkerUsersProfiles] WHERE ([idUser] = @idUser)

GO
/****** Object:  StoredProcedure [dbo].[checkUserAvatar]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkUserAvatar]
    (
  
		@token VarChar(255)

   )
As
 
SELECT  TaskkerUserAvatar FROM [TaskkerUsersProfiles] WHERE ([TaskkerUserUniqID] = @token)

GO
/****** Object:  StoredProcedure [dbo].[checkUserName]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkUserName]
    (
  
		@User VarChar(255)

   )
As
 
SELECT  count(*) As UserExists FROM [TaskkerUsersProfiles] WHERE ([TaskkerUserName] = @User)

GO
/****** Object:  StoredProcedure [dbo].[checkUserNameProfileDetails]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkUserNameProfileDetails]
    (
  
		@User VarChar(255)

   )
As
 
SELECT  *   FROM [TaskkerUsersProfiles] WHERE ([TaskkerUserName] = @User)

GO
/****** Object:  StoredProcedure [dbo].[checkUserNetwork]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkUserNetwork]
    (
  
		@idUser VarChar(255)

   )
As
 
SELECT        SPLIT_1.val, TaskkerUsersProfiles.TaskkerUserName, TaskkerUsersProfiles.TaskkerUserAvatar, TaskkerUsersProfiles.TaskkerUserRealName, 
                         TaskkerUsersProfiles.TaskkerUserNetwork
FROM            dbo.SPLIT
                             ((SELECT        TaskkerUserNetwork
                                 FROM            TaskkerUsersProfiles
                                 WHERE        (idUser = @idUser)), 1, 0) AS SPLIT_1 INNER JOIN
                         TaskkerUsersProfiles ON SPLIT_1.val = TaskkerUsersProfiles.idUser

GO
/****** Object:  StoredProcedure [dbo].[checkUserNetworkTasks]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkUserNetworkTasks]
    (
  
		@idUser VarChar(255)

   )
As
 


SELECT    *
FROM         dbo.SPLIT
                          ((SELECT     TaskkerUsersProfiles.TaskkerUserNetwork
                              FROM         TaskkerUsersProfiles INNER JOIN
                                                    Taskkers ON TaskkerUsersProfiles.TaskkerUserUniqID = Taskkers.idUser
                              WHERE     (TaskkerUsersProfiles.idUser  = @idUser)), 1, 0) AS SPLIT_1 INNER JOIN
                      TaskkerUsersProfiles ON SPLIT_1.val = TaskkerUsersProfiles.idUser INNER JOIN
                      Taskkers ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID
WHERE     (Taskkers.TaskkerPrivacy = 1)
ORDER BY Taskkers.TaskkerDate DESC

GO
/****** Object:  StoredProcedure [dbo].[checkUserProfile]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[checkUserProfile]
    (
  
		@Token VarChar(255)

   )
As
 
SELECT  count(*) As UserExists FROM [TaskkerUsersProfiles] WHERE ([TaskkerUserUniqID] = @Token)

GO
/****** Object:  StoredProcedure [dbo].[checkUserProfileDetails]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[checkUserProfileDetails]
    (
  
		@Token VarChar(255)

   )
As
 
SELECT  *   FROM [TaskkerUsersProfiles] WHERE ([TaskkerUserUniqID] = @Token)

GO
/****** Object:  StoredProcedure [dbo].[getAllCategories]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllCategories]
    (
        @Top int   

   )
As


SELECT  Top  (@Top) COUNT([idCateg]) As _cnter , idCategThing, RTRIM(CategThing)  As 'CategThing', RTRIM(CategThingDesc) As 'CategThingDesc'
  FROM [dbo].[Taskkers] INNER JOIN  
[dbo].[CategThings] ON [CategThings].idCategThing = [Taskkers].[idCateg]
 
GROUP BY [idCategThing], CategThing, CategThingDesc
ORDER BY _cnter DESC, CategThing


 
--SELECT  top (@Top) idCategThing, CategThing, CategThingDesc FROM [CategThings]   ORDER by CategThing ASC


--SELECT  Top  (@Top) (SELECT COUNT([idCateg])  FROM [dbo].[Taskkers] WHERE idCateg = xx.idCategThing ) As _cnter , idCategThing, CategThing, CategThingDesc
--  FROM [dbo].[Taskkers] CROSS JOIN  
--[dbo].[CategThings] --ON [CategThings].idCategThing = [Taskkers].[idCateg]
-- xx
--GROUP BY [idCategThing], CategThing, CategThingDesc
--ORDER BY  _cnter DESC, CategThing


 
GO
/****** Object:  StoredProcedure [dbo].[getAllCategoriesUser]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllCategoriesUser]
    (
        @Top int ,  @idUser char(100)

   )
As


SELECT  Top  (@Top) COUNT([idCateg]) As _cnter , idCategThing, RTRIM(CategThing)  As 'CategThing', RTRIM(CategThingDesc) As 'CategThingDesc'
  FROM [dbo].[Taskkers] INNER JOIN  
[dbo].[CategThings] ON [CategThings].idCategThing = [Taskkers].[idCateg]
 where [idUser]=rtrim(@idUser)
GROUP BY [idCategThing], CategThing, CategThingDesc
ORDER BY _cnter DESC, CategThing


 
--SELECT  top (@Top) idCategThing, CategThing, CategThingDesc FROM [CategThings]   ORDER by CategThing ASC


--SELECT  Top  (@Top) (SELECT COUNT([idCateg])  FROM [dbo].[Taskkers] WHERE idCateg = xx.idCategThing ) As _cnter , idCategThing, CategThing, CategThingDesc
--  FROM [dbo].[Taskkers] CROSS JOIN  
--[dbo].[CategThings] --ON [CategThings].idCategThing = [Taskkers].[idCateg]
-- xx
--GROUP BY [idCategThing], CategThing, CategThingDesc
--ORDER BY  _cnter DESC, CategThing


 
GO
/****** Object:  StoredProcedure [dbo].[getAllMainCategories]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAllMainCategories]
    (
        @Top int    
   )
As

 SELECT  top (@Top) idCategThing, RTRIM(CategThing) As 'CategThing' , CategThingDesc FROM [CategThings]   ORDER by CategThing ASC

 
GO
/****** Object:  StoredProcedure [dbo].[getSAllCategories]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getSAllCategories]
    (
        @Top int,
		@Categ  VarChar(10) ,
		@CategSec  VarChar(10) 

   )
As
 
SELECT  top (@Top)     ToDoThings.*
FROM            ToDoThings where Categ = @Categ OR CategSec = @CategSec

GO
/****** Object:  StoredProcedure [dbo].[getStatuses]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getStatuses]
 /*  users taskkers on ID and STATUS   */
    (
        @Top int   
   )
As
 
SELECT  top (@Top) *  FROM [TaskkersStatus]

GO
/****** Object:  StoredProcedure [dbo].[getTaskkerAllOnUser]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTaskkerAllOnUser]
    (
        @Top int, 
		@User VarChar(255)

   )
As
 
SELECT  top (@Top) * FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID WHERE ( ([Taskkers].[TaskkerUserName] = @User)) ORDER by idTaskker DESC 


GO
/****** Object:  StoredProcedure [dbo].[getTaskkerCountComments]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTaskkerCountComments] 
	(
	@TskID VarChar(255) 
	)
 
AS
	 SELECT count(*) As tskComm FROM [TaskkersComment] WHERE ([TaskkerUniqID] = @TskID)
	RETURN


GO
/****** Object:  StoredProcedure [dbo].[getTaskkerOnPrivacyStatusUser]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTaskkerOnPrivacyStatusUser]
 /*  users taskkers on ID and STATUS   */
    (
        @Top int  , 
		@idUser VarChar(255),
		@TaskkerStatus VarChar(255),
		@privacy VarChar(255)

   )
As
 
SELECT  top (@Top) * FROM [Taskkers] WHERE (([TaskkerStatus] = @TaskkerStatus) 
AND ([TaskkerUserName] = @idUser) AND   ([TaskkerPrivacy] = @privacy) ) ORDER by idTaskker DESC 

GO
/****** Object:  StoredProcedure [dbo].[getTaskkerOnStatusUser]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTaskkerOnStatusUser]
 /*  users taskkers on ID and STATUS   */
    (
        @Top int  , 
		@idUser VarChar(255),
		@TaskkerStatus VarChar(255)

   )
As
 
SELECT  top (@Top) * FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID WHERE (([TaskkerStatus] = @TaskkerStatus) 
AND ([Taskkers].[TaskkerUserName] = @idUser)) ORDER by IdTaskker DESC 


GO
/****** Object:  StoredProcedure [dbo].[getTaskkersAllCategories]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 CREATE PROCEDURE [dbo].[getTaskkersAllCategories]
    (
        @Top int   

   )
As
 
 

SELECT  top (@Top)   idCategThing, CategThing, CategThingDesc,
                             (SELECT        LTRIM(RTRIM(CategThings.CategThing)) + '  ( ' + LTRIM(RTRIM(CAST(COUNT(*) AS char(10)))) AS test
                               FROM            Taskkers
                               WHERE        (CategThings.idCategThing = idCateg) AND (TaskkerPrivacy = 1)) + ' )' AS taskkersCount
FROM            CategThings
ORDER BY CategThing DESC

GO
/****** Object:  StoredProcedure [dbo].[getTaskkersOnUserAllCategories]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTaskkersOnUserAllCategories]
    (
        @Top int,
				@U VarChar(255) 

   )
As
 
SELECT    idCategThing, CategThing, CategThingDesc,
                             (SELECT        LTRIM(RTRIM(CategThings.CategThing)) + '  ( ' + LTRIM(RTRIM(CAST(COUNT(*) AS char(10)))) AS test
                               FROM            Taskkers
                               WHERE        (CategThings.idCategThing = idCateg) AND ([TaskkerUserName] = @U)) + ' )' AS taskkersCount
FROM            CategThings
ORDER BY CategThing ASC

GO
/****** Object:  StoredProcedure [dbo].[getTaskkerStats]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTaskkerStats]
As
SELECT (SELECT COUNT([idTaskker])  FROM [dbo].[Taskkers] ) As 'PublishedTasks',
(SELECT COUNT([idTaskker])  FROM [dbo].[Taskkers] WHERE [TaskkerStatus]= '2') As 'SolvedTasks',
(SELECT COUNT([idTaskker])  FROM [dbo].[Taskkers] WHERE [TaskkerStatus] <> '2') As 'UNSolvedTasks'

--(SELECT COUNT([idUser])  FROM [dbo].[TaskkerUsersProfiles] ) As 'Users',
--(SELECT COUNT([idTaskkerComment])  FROM [dbo].[TaskkersComment]) As 'Comments'
--,(SELECT DATEDIFF(day,'2010-06-05',GETDATE()) AS DiffDate)
GO
/****** Object:  StoredProcedure [dbo].[getTaskkerStatsOnUser]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTaskkerStatsOnUser]
(@idUser char(100))
As
SELECT (SELECT COUNT([idTaskker])  FROM [dbo].[Taskkers]  where [idUser]=rtrim(@idUser)) As 'PublishedTasks',
(SELECT COUNT([idTaskker])  FROM [dbo].[Taskkers] WHERE  [idUser]=rtrim(@idUser)) As 'SolvedTasks',
(SELECT COUNT([idTaskker])  FROM [dbo].[Taskkers] WHERE   [idUser]=rtrim(@idUser)) As 'UNSolvedTasks'

--(SELECT COUNT([idUser])  FROM [dbo].[TaskkerUsersProfiles] ) As 'Users',
--(SELECT COUNT([idTaskkerComment])  FROM [dbo].[TaskkersComment]) As 'Comments'
--,(SELECT DATEDIFF(day,'2010-06-05',GETDATE()) AS DiffDate)
GO
/****** Object:  StoredProcedure [dbo].[getTaskkerStatsUser]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[getTaskkerStatsUser]
(@idUser char(100))
As
SELECT (SELECT COUNT([idTaskker])  FROM [dbo].[Taskkers] ) As 'PublishedTasks',
(SELECT COUNT([idTaskker])  FROM [dbo].[Taskkers] WHERE [TaskkerStatus]= '2') As 'SolvedTasks',
(SELECT COUNT([idTaskker])  FROM [dbo].[Taskkers] WHERE [TaskkerStatus] <> '2') As 'UNSolvedTasks'

--(SELECT COUNT([idUser])  FROM [dbo].[TaskkerUsersProfiles] ) As 'Users',
--(SELECT COUNT([idTaskkerComment])  FROM [dbo].[TaskkersComment]) As 'Comments'
--,(SELECT DATEDIFF(day,'2010-06-05',GETDATE()) AS DiffDate)
GO
/****** Object:  StoredProcedure [dbo].[getTaskkerUniq]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTaskkerUniq]
    (
  
		@TskID VarChar(255)

   )
As
 
SELECT  * FROM [Taskkers] WHERE ([TaskkerUniq] = @TskID)

GO
/****** Object:  StoredProcedure [dbo].[prcChangeDetails]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[prcChangeDetails]
    (@userID int, @Email nchar(50), @User nchar(50), @Phone nchar(50),@NameX nchar(50),@Webpage nchar(50),@Location nchar(50))
As

UPDATE [dbo].[Log_Users]

SET 

[E_MAIL] =RTRIM(@Email),
[Usr] = RTRIM(@User), 
[Phone] =RTRIM(@Phone), 
[Name]=RTRIM(@NameX), 
[Webpage]=RTRIM(@Webpage), 
[Location]=RTRIM(@Location)

WHERE [Logid] = @userID

GO
/****** Object:  StoredProcedure [dbo].[prcChangeUserPasswd]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prcChangeUserPasswd]
    (@userID int, @Password nchar(50))
As
UPDATE [dbo].[Log_Users]
SET [Pswrd] = @Password
WHERE [Logid] = @userID

GO
/****** Object:  StoredProcedure [dbo].[prcGetUserDetails]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prcGetUserDetails]
    (@userID int)
As
SELECT [E_MAIL],[Usr],[Phone],[Name],[Webpage],[Location] FROM [dbo].[Log_Users]
WHERE [Logid] = @userID



GO
/****** Object:  StoredProcedure [dbo].[prcLoginv]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[prcLoginv] (
@Username varchar(50),@UPassword varchar(50)
)
AS

SELECT '1' As 'OutRes',   Usr As 'UserName', Logid As 'UserID',E_MAIL As 'UserEmail', Phone As 'UserPhone', Time_Logged_Out As 'UserLogin'  FROM [Log_Users] 
where Logid IN (SELECT LogId FROM [Log_Users] where [Usr] = RTRIM(@Username) OR [E_MAIL] = RTRIM(@Username)) and 
[Pswrd] = RTRIM(@UPassword)
 
 --SELECT count(*) As 'OutRes'  
----(SELECT top 1 Usr FROM [Log_Users]  ) As 'UserName', 
----(SELECT top 1 Logid FROM [Log_Users]  ) As 'UserID',
----(SELECT top 1 E_MAIL FROM [Log_Users]  ) As 'UserEmail',
----(SELECT top 1 Phone FROM [Log_Users]  ) As 'UserPhone', 
----(SELECT top 1 Time_Logged_Out FROM [Log_Users] ) As 'UserLogin'
--FROM 
--WHERE  [Pswrd] = RTRIM(@UPassword)
--UPDATE dbo.Log_Users 
--SET [Time_Logged_In] = getDate(), [Status] = 1
--WHERE ([Usr] = RTRIM(@Username) OR [E_MAIL] = RTRIM(@Username)) AND [Pswrd] = RTRIM(@UPassword)
--prcLoginv 'winstore','stest'

GO
/****** Object:  StoredProcedure [dbo].[prcLogOut]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prcLogOut] (
@Username varchar(50)
)
AS
 
UPDATE dbo.Log_Users 
SET [Time_Logged_Out] = getDate(), [Status] = 0
WHERE [Usr] = RTRIM(@Username) 


GO
/****** Object:  StoredProcedure [dbo].[prcUserContactOnLink]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prcUserContactOnLink] (
@ALink varchar(50)
)
AS
SELECT  TOP 1      Log_Users.E_MAIL As 'Email', Log_Users.Phone As 'Phone'
FROM            AnalyseCategories INNER JOIN
                         Analyses ON AnalyseCategories.idAnalyseCategory = Analyses.idAnalyseCategory INNER JOIN
                         Log_Users ON AnalyseCategories.UserId = Log_Users.Logid
where [ALink] = RTRIM(@ALink)

GO
/****** Object:  StoredProcedure [dbo].[prcUserDelAnalyse]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prcUserDelAnalyse]
    ( 
   @idAnalyse int
     )
As
 
/****** FIRST REMOVE ELEMENTS FROM ALL ANALYSES ITEMS  ******/   
DELETE FROM dbo.ElementItems 
WHERE idAnalyseItem  IN (
SELECT idAnalyseItem FROM  AnalyseItems 
INNER JOIN    Analyses ON AnalyseItems.idAnalyse = Analyses.idAnalyse
WHERE (Analyses.idAnalyse = @idAnalyse )                      
)
/****** NOW REMOVE ALL ANALYSES ITEMS FROM SPECIFIC CATEGORY AND DATE ******/    
DELETE AnalyseItems FROM  AnalyseItems WHERE  [idAnalyse] = @idAnalyse
DELETE FROM [dbo].[Analyses] WHERE [idAnalyse]=@idAnalyse
DELETE  FROM [dbo].[AnalyseTemplates] WHERE [idAnalyse]=@idAnalyse



GO
/****** Object:  StoredProcedure [dbo].[prcUserElementNew]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prcUserElementNew]
    ( 
     @ESymbol char(50), @UserId int
     )
As
INSERT INTO [dbo].[Elements]
           ([ESymbol] ,[idUnit],[UserId])
     VALUES
           (@ESymbol,1,@UserId)

GO
/****** Object:  StoredProcedure [dbo].[prcUserElements]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prcUserElements]
    ( 
      @UserId int, @Top int 
     )
As
SELECT Top(@Top) [ESymbol], [idElement] FROM [Elements] 
WHERE UserId = @UserId
ORDER BY [ESymbol], [idElementCategory], [EName]

GO
/****** Object:  StoredProcedure [dbo].[prcUserFormOCR]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prcUserFormOCR] 
( @ElementIDList char(200) )
AS 
 SELECT Top 1 COUNT(idAnalyse) As _cnter, idAnalyse As 'FormID'
  FROM [dbo].[AnalyseTemplates]
  where idElement IN (select * from dbo.split(RTRIM(@ElementIDList),1,0 ))
  GROUP BY idAnalyse
  ORDER BY _cnter DESC


GO
/****** Object:  StoredProcedure [dbo].[prcUserGetPasswordEmail]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------
CREATE PROCEDURE [dbo].[prcUserGetPasswordEmail] (
@Email varchar(55)
)
AS 
IF (SELECT count(*) FROM dbo.Log_Users WHERE E_MAIL = RTRIM(@Email)) > 0 
BEGIN 
  PRINT 'User exist'
  SELECT [Usr] As 'User',[Pswrd] As 'UPass', [Phone] As 'Phone' , [E_MAIL] As 'Email' FROM Log_Users WHERE [E_MAIL] = RTRIM(@Email) 
END

GO
/****** Object:  StoredProcedure [dbo].[prcUserGetPasswordPhone]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------
CREATE PROCEDURE [dbo].[prcUserGetPasswordPhone] (
@Phone varchar(50)
)
AS 
IF (SELECT count(*) FROM dbo.Log_Users WHERE Phone = RTRIM(@Phone)) > 0 
BEGIN 
  PRINT 'User exist'
  SELECT [Usr] As 'User',[Pswrd] As 'UPass', [Phone] As 'Phone' , [E_MAIL] As 'Email' FROM Log_Users WHERE [Phone] = RTRIM(@Phone) 
END

GO
/****** Object:  StoredProcedure [dbo].[prcUserMakeContactForm]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[prcUserMakeContactForm] (
@NewUid int
)
AS 
 
-- add new user category
INSERT INTO dbo.AnalyseCategories ([UserId]) VALUES (@NewUid)
-- find that category ID
DECLARE @NewCategID int
SET @NewCategID = (SELECT TOP 1 [idAnalyseCategory] FROM dbo.AnalyseCategories WHERE [UserId] = @NewUid)
-- add to analyse ID
INSERT INTO  dbo.Analyses  ([idAnalyseCategory],[AName]) VALUES (@NewCategID,'Contact form')
--GET THE NEW FORM ANALYSE
DECLARE @NewAnalyseID int
SET @NewAnalyseID = (SELECT TOP 1 [idAnalyse] FROM [dbo].[Analyses] WHERE [idAnalyseCategory] = @NewCategID)

-- create new element with that ID
INSERT INTO dbo.Elements  ([UserId],[ESymbol],[EName], [idUnit]) VALUES (@NewUid,'Name','Your name',1)
INSERT INTO dbo.Elements  ([UserId],[ESymbol],[EName], [idUnit]) VALUES (@NewUid,'Email','Your email address',1)
INSERT INTO dbo.Elements  ([UserId],[ESymbol],[EName], [idUnit]) VALUES (@NewUid,'Phone','Your phone number',1)
INSERT INTO dbo.Elements  ([UserId],[ESymbol],[EName], [idUnit]) VALUES (@NewUid,'Subject','What is about',1)
INSERT INTO dbo.Elements  ([UserId],[ESymbol],[EName], [idUnit]) VALUES (@NewUid,'Message','Message',1)

--POPULATE THE NEW FORM
INSERT INTO AnalyseTemplates(idAnalyse, idElement,  ATOrder, idSystemForm, ProcedureName, AVisible) 
SELECT @NewAnalyseID, idElement, ( @@RowCount ) AS row_count, 1, 1,1 FROM dbo.Elements WHERE [UserId] = @NewUid

GO
/****** Object:  StoredProcedure [dbo].[prcUserNewAnalyse]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prcUserNewAnalyse] (
@UserId varchar(55), @AnalyseName varchar(50)
)
AS 
DECLARE @NewCategID int
SET @NewCategID = (SELECT TOP 1 [idAnalyseCategory] FROM dbo.AnalyseCategories WHERE [UserId] = @UserId)
-- add to analyse ID
INSERT INTO  dbo.Analyses  ([idAnalyseCategory],[AName]) VALUES (@NewCategID, @AnalyseName)


GO
/****** Object:  StoredProcedure [dbo].[prcUserNewRegistration]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------
CREATE PROCEDURE [dbo].[prcUserNewRegistration] (
@Phone varchar(50)
)
AS 

IF (SELECT count(*) FROM dbo.Log_Users WHERE  Phone = RTRIM(@Phone)) = 0 
BEGIN
--make uniq user reg
DECLARE @Usr varchar(6)
DECLARE @UPasw char(5)
SET @Usr = (SELECT RTRIM(SUBSTRING(lower(newid()), 0,6)))
SET @UPasw = (SELECT SUBSTRING(lower(newid()), 1,3))
-- add to the loggin db
INSERT INTO dbo.Log_Users (Phone, Usr, Pswrd) VALUES (@Phone, @Usr, @UPasw)
DECLARE @NewUid int
SET @NewUid = (SELECT TOP 1 Logid FROM dbo.Log_Users WHERE Usr =  @Usr AND Pswrd= @UPasw)
-- add new user category
INSERT INTO dbo.AnalyseCategories ([UserId]) VALUES (@NewUid)
-- find that category ID
DECLARE @NewCategID int
SET @NewCategID = (SELECT TOP 1 [idAnalyseCategory] FROM dbo.AnalyseCategories WHERE [UserId] = @NewUid)
-- add to analyse ID
INSERT INTO  dbo.Analyses  ([idAnalyseCategory],[AName]) VALUES (@NewCategID,'my new form')
-- create new element with that ID
INSERT INTO dbo.Elements  ([UserId],[ESymbol],[EName], [idUnit]) VALUES (@NewUid,'New field','Field description',1)
-- return user temporary details
SELECT [Usr] As 'User',[Pswrd] As 'UPass', [Phone] As 'Phone' FROM Log_Users  WHERE Logid = @NewUid
END
ELSE
BEGIN 
 PRINT 'User exist'
 -- SELECT 'PHONE ALREADY EXIST' As 'User'
  SELECT [Usr] As 'User',[Pswrd] As 'UPass', [Phone] As 'Phone' FROM Log_Users WHERE Phone = RTRIM(@Phone) 
END
--prcUserNewRegistration '4740456242'

GO
/****** Object:  StoredProcedure [dbo].[prcUserNewRegistrationEmail]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






--DECLARE @SQLStr varchar(100)
--SELECT @SQLStr = 'ddmma@yahoo.com'
--SELECT top 1  *  FROM  dbo.split(@SQLStr, '@')

---------------------------------------------------------------------
CREATE PROCEDURE [dbo].[prcUserNewRegistrationEmail] (
@Email varchar(55)
)
AS 
IF (SELECT count(*) FROM dbo.Log_Users WHERE E_MAIL = LTRIM(RTRIM(lower(@Email)))) = 0 
BEGIN
--make uniq user reg
--SELECT count(*) FROM dbo.Log_Users WHERE E_MAIL = LTRIM(RTRIM(lower('ddmma@yahoo.com ')))

DECLARE @Usr varchar(15)
DECLARE @UPasw char(7)
SET @Usr = (SELECT top 1  *  FROM  dbo.SplitMe(@Email, '@')) --SELECT RTRIM(SUBSTRING(lower(newid()), 0,5))
SET @UPasw = (SELECT SUBSTRING(lower(newid()), 1,7))
-- add to the loggin db
INSERT INTO dbo.Log_Users (E_MAIL, Usr, Pswrd) VALUES (@Email, RTRIM(@Usr), @UPasw)
DECLARE @NewUid int
SET @NewUid = (SELECT TOP 1 Logid FROM dbo.Log_Users WHERE Usr =  @Usr AND Pswrd= @UPasw)

-- -------  ------------------- USER DETAILS -------------------------------------------------------
-- return user temporary details
SELECT Usr As 'User',[Pswrd] As 'UPass', [Phone] As 'Phone', [E_MAIL] As 'Email' FROM Log_Users  WHERE Logid = @NewUid
END
ELSE
BEGIN 
 PRINT 'User exist'
  SELECT Usr As 'User',[Pswrd] As 'UPass', [Phone] As 'Phone' , [E_MAIL] As 'Email' FROM Log_Users WHERE [E_MAIL] = RTRIM(@Email) 
END
--prcUserNewRegistrationEmail 'get@i4.ms'









GO
/****** Object:  StoredProcedure [dbo].[prcUserUpEmail]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[prcUserUpEmail] (
@Uid int, @Email varchar(55)
)
AS 
UPDATE dbo.Log_Users 
SET [E_MAIL] = RTRIM(E_MAIL)
WHERE [Logid] = @Uid 


GO
/****** Object:  StoredProcedure [dbo].[prcUserUpPhone]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[prcUserUpPhone] (
@Uid int, @Phone varchar(50)
)
AS 
UPDATE dbo.Log_Users 
SET [Phone] = RTRIM(@Phone)
WHERE [Logid] = @Uid 

GO
/****** Object:  StoredProcedure [dbo].[spCountTaskkerUserCategory]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCountTaskkerUserCategory]
    (
      
		@param VarChar(255),
		@user VarChar(255)
   )
As
 
SELECT  count(*) As items FROM [Taskkers] WHERE ( ([idCateg] = @param) AND [TaskkerUserName]=@user)  

GO
/****** Object:  StoredProcedure [dbo].[spCountTaskkerUserPrivacy]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCountTaskkerUserPrivacy]
    (
      
		@param VarChar(255),
		@user VarChar(255)
   )
As
 
SELECT  count(*) As items FROM [Taskkers] WHERE ( ([TaskkerPrivacy] = @param) AND [TaskkerUserName]=@user)  

GO
/****** Object:  StoredProcedure [dbo].[spCountTaskkerUserStatus]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCountTaskkerUserStatus]
    (
      
		@param VarChar(255),
		@user VarChar(255)
   )
As
 
SELECT  count(*) As items FROM [Taskkers] WHERE ( ([TaskkerStatus] = @param) AND [TaskkerUserName]=@user)  

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnCategory]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnCategory]
 /*  users taskkers from a user   */
    (
	@C VarChar(255)
	   )
As
 
SELECT * FROM [Taskkers]  INNER JOIN [TaskkerUsersProfiles] ON
[TaskkerUsersProfiles].[TaskkerUserName]= [Taskkers].[TaskkerUserName]
INNER JOIN [dbo].[CategThings] ON [CategThings].[idCategThing] = [Taskkers].[idCateg]
 WHERE ( ([Taskkers].[idCateg] = @C) ) ORDER by idTaskker DESC 

 -- spTaskkerOnUser 'i4ms'
GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnCategoryPublicProgressAll]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnCategoryPublicProgressAll]
 /*  users taskkers from a user   */
 (
 	@C VarChar(255)
 )
As
 
SELECT top(5) *  FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID  WHERE ( ([TaskkerPrivacy] = 1)
AND ([TaskkerStatus] = 1) AND ([idCateg] = @C) AND (LEN(TaskkerBody) > 10)  AND (TaskkerHomePage = 1)
) 
ORDER by idTaskker DESC 

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnHomePageLatestPublicProgress]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnHomePageLatestPublicProgress]
 /*  users taskkers from a user   */

As
 
SELECT top(5) *  FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID
WHERE       ( (Taskkers.TaskkerPrivacy = 1) 
 
AND ([TaskkerStatus] = 1)  and TaskkerHomePage = 1
) 
ORDER by [Taskkers].idTaskker DESC 

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnLatestPublicProgress]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnLatestPublicProgress]
 /*  users taskkers from a user   */

As
 
SELECT top(5) *  FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID
WHERE       ( (Taskkers.TaskkerPrivacy = 1) 
 
AND ([TaskkerStatus] = 1)  
) 
ORDER by [Taskkers].idTaskker DESC 


GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnLatestUserProgress]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnLatestUserProgress]
 /*  users taskkers from a user   */
 (@idUser char(100))
As
 
SELECT top(5) *  FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID
WHERE    Taskkers.idUser=rtrim(@idUser)

ORDER by [Taskkers].idTaskker DESC 


GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnRandomPublicProgress]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnRandomPublicProgress]
 /*  users taskkers from a user   */

As
 
SELECT top(5) *  FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID
WHERE       ( (Taskkers.TaskkerPrivacy = 1)  
AND ([TaskkerStatus] = 1) AND (LEN(TaskkerBody) > 10) 
) 
ORDER BY NEWID()

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnTask]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnTask]
 /*  users taskkers from a user   */
    (
	@T VarChar(255)
	   )
As
 
SELECT * FROM [Taskkers]  INNER JOIN [TaskkerUsersProfiles] ON
[TaskkerUsersProfiles].[TaskkerUserName]= [Taskkers].[TaskkerUserName]
INNER JOIN [dbo].[CategThings] ON [CategThings].[idCategThing] = [Taskkers].[idCateg]
 WHERE ( ([Taskkers].[TaskkerUniq] = @T) ) ORDER by idTaskker DESC 

 -- spTaskkerOnCategory 30
GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnUser]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnUser]
 /*  users taskkers from a user   */
    (
	@U VarChar(255)
	   )
As
 
SELECT * FROM [Taskkers]  INNER JOIN [TaskkerUsersProfiles] ON
[TaskkerUsersProfiles].[TaskkerUserName]= [Taskkers].[TaskkerUserName]
 WHERE ( ([Taskkers].[TaskkerUserName] = @U) ) ORDER by idTaskker DESC 
 

 -- spTaskkerOnUser 'i4ms'
GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnUserCategory]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spTaskkerOnUserCategory] 

 
 /*  users taskkers from a user   */
    (
	@U VarChar(255),
				@C VarChar(255) 
	   )
As
 
SELECT * FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID  WHERE ( (Taskkers.[TaskkerUserName] = @U) 
AND ([idCateg] = @C)
) 
ORDER by idTaskker DESC 

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnUserCategoryStatus]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnUserCategoryStatus]

 
 /*  users taskkers from a user   */
    (
	@U VarChar(255),
				@C VarChar(255),  @S VarChar(255) 
	   )
As
 
SELECT * FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID WHERE ( ([Taskkers].TaskkerUserName = @U) 
AND ([idCateg] = @C) AND ([TaskkerStatus] = @S)
) 
ORDER by idTaskker DESC 

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnUserPrivacy]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnUserPrivacy]
 /*  users taskkers from a user   */
    (
	@U VarChar(255),
		@P VarChar(255)
	   )
As
 
SELECT * FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID  WHERE ( (Taskkers.[TaskkerUserName] = @U) AND ([TaskkerPrivacy] = @P)) 

ORDER by idTaskker DESC 

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnUserPrivacyCategory]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnUserPrivacyCategory]
 /*  users taskkers from a user   */
    (
	@U VarChar(255),
		@P VarChar(255),
				@C VarChar(255)
	   )
As
 
SELECT * FROM [Taskkers] 
INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID  WHERE ( ([Taskkers].TaskkerUserName = @U) 
AND ([TaskkerPrivacy] = @P)
AND ([idCateg] = @C)
) 
ORDER by idTaskker DESC 

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnUserPrivacyCategoryStatus]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerOnUserPrivacyCategoryStatus]
 
 /*  users taskkers from a user   */
    (
	@U VarChar(255),
		@P VarChar(255),
				@S VarChar(255),
			       @C VarChar(255) 
	   )
As
 
SELECT * FROM [Taskkers] INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID WHERE ( ([Taskkers].[TaskkerUserName] = @U) 
AND ([TaskkerPrivacy] = @P) AND ([idCateg] = @C)
AND ([TaskkerStatus] = @S)
) 
ORDER by idTaskker DESC 

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnUserPrivacyStatus]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spTaskkerOnUserPrivacyStatus]
 /*  users taskkers from a user   */
    (
	@U VarChar(255),
		@P VarChar(255),
				@S VarChar(255)
	   )
As
 
SELECT * FROM [Taskkers] INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID WHERE ( ([Taskkers].[TaskkerUserName] = @U) 
AND ([TaskkerPrivacy] = @P)
AND ([TaskkerStatus] = @S)
) 
ORDER by idTaskker DESC 

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerOnUserStatus]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spTaskkerOnUserStatus]
 
 /*  users taskkers from a user   */
    (
	@U VarChar(255),
				@S VarChar(255) 
	   )
As
 
SELECT * FROM [Taskkers] INNER JOIN     TaskkerUsersProfiles ON Taskkers.idUser = TaskkerUsersProfiles.TaskkerUserUniqID WHERE ( ([Taskkers].[TaskkerUserName] = @U) 
AND ([TaskkerStatus] = @S)
) 
ORDER by idTaskker DESC 

GO
/****** Object:  StoredProcedure [dbo].[spTaskkerPrice]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerPrice]
 /*  users taskkers from a user   */
    (
	@T VarChar(255)
	   )
As
 
SELECT * FROM [Taskkers] WHERE ( ([TaskkerUniq] = @T) )  



GO
/****** Object:  StoredProcedure [dbo].[spTaskkerRSSOnLatestPublicProgress]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTaskkerRSSOnLatestPublicProgress]
 /*  users taskkers from a user   */

As
 
SELECT top(25) *  FROM [Taskkers] 
WHERE       ( (Taskkers.TaskkerPrivacy = 1) 
 
AND ([TaskkerStatus] = 1) 
) 
ORDER by [Taskkers].idTaskker DESC 


GO
/****** Object:  StoredProcedure [dbo].[spUsersOnMap]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUsersOnMap]
 /*  location of the users   */

As
 
SELECT top(2000) * 
    FROM     
        TaskkerUsersProfiles where   LEN(TaskkerUserLocation) > 2



GO
/****** Object:  StoredProcedure [i4ms\md].[addNewTaskker]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [i4ms\md].[addNewTaskker]
(
@idUser VarChar(255),
@idStatus int,
@idCateg nchar(2),
@TaskkerUniq char(200),
@TaskkerUserName char(200) ,
@TaskkerEmail char(200),
@TaskkerSubject char(255),
@TaskkerBody char(1000),
@TaskkerHomePage char(1) ,
@TaskkerStart char(18),
@TaskkerDue char(18),
@TaskkerLocation char(200),
@TaskkerPrice char(18),
@TaskkerCoin char(4),
@TaskkerHours char(4),
@TaskkerStatus char(2),
@TaskkerPrivacy char(2),
@TaskkerAssignmentEmail char(250),
@TaskkerAttachment char(250),
@TaskkerIP char(20)
)

AS
INSERT INTO [dbo].[Taskkers]
           (
		    [idUser]
		   ,[idStatus]
           ,[idCateg]
           ,[TaskkerUniq]
           ,[TaskkerUserName]
           ,[TaskkerEmail]
           ,[TaskkerSubject]
           ,[TaskkerBody]
           ,[TaskkerHomePage]
           ,[TaskkerStart]
           ,[TaskkerDue]
           ,[TaskkerLocation]
           ,[TaskkerPrice]
           ,[TaskkerCoin]
           ,[TaskkerHours]
           ,[TaskkerStatus]
           ,[TaskkerPrivacy]
           ,[TaskkerAssignmentEmail]
		   ,[TaskkerAttachment]
           ,[TaskkerIP])
     VALUES
           (@idUser,
@idStatus,
@idCateg,
@TaskkerUniq ,
@TaskkerUserName  ,
@TaskkerEmail ,
@TaskkerSubject ,
@TaskkerBody,
@TaskkerHomePage,
@TaskkerStart,
@TaskkerDue,
@TaskkerLocation,
@TaskkerPrice  ,
@TaskkerCoin ,
@TaskkerHours ,
@TaskkerStatus ,
@TaskkerPrivacy ,
@TaskkerAssignmentEmail ,
@TaskkerAttachment,
@TaskkerIP 
)

GO
/****** Object:  UserDefinedFunction [dbo].[SPLIT]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SPLIT]
 (
 @s nvarchar(max),
 @trimPieces bit,
 @returnEmptyStrings bit
 )
 returns @t table (val nvarchar(max))
 as
 begin
 
declare @i int, @j int
 select @i = 0, @j = (len(@s) - len(replace(@s,',','')))
 
;with cte 
as
 (
 select
 i = @i + 1,
 s = @s, 
n = substring(@s, 0, charindex(',', @s)),
 m = substring(@s, charindex(',', @s)+1, len(@s) - charindex(',', @s))
 
union all
 
select 
i = cte.i + 1,
 s = cte.m, 
n = substring(cte.m, 0, charindex(',', cte.m)),
 m = substring(
 cte.m,
 charindex(',', cte.m) + 1,
 len(cte.m)-charindex(',', cte.m)
 )
 from cte
 where i <= @j
 )
 insert into @t (val)
 select pieces
 from 
(
 select 
case 
when @trimPieces = 1
 then ltrim(rtrim(case when i <= @j then n else m end))
 else case when i <= @j then n else m end
 end as pieces
 from cte
 ) t
 where
 (@returnEmptyStrings = 0 and len(pieces) > 0)
 or (@returnEmptyStrings = 1)
 option (maxrecursion 0)
 
return
 
end
 









GO
/****** Object:  UserDefinedFunction [dbo].[SplitMe]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE  FUNCTION [dbo].[SplitMe](@String VARCHAR(8000), @Delimiter CHAR(1))       
  RETURNS @temptable TABLE (items VARCHAR(8000))       
AS       
    BEGIN       
     DECLARE @idx INT       
    DECLARE @slice VARCHAR(8000)       
 
    SELECT @idx = 1       
         IF len(@String)<1 OR @String IS NULL  RETURN       
 
      while @idx!= 0       
       BEGIN       
         SET @idx = charindex(@Delimiter,@String)       
         IF @idx!=0       
             SET @slice = LEFT(@String,@idx - 1)       
        ELSE       
             SET @slice = @String       
 
         IF(len(@slice)>0)  
            INSERT INTO @temptable(Items) VALUES(@slice)       
 
         SET @String = RIGHT(@String,len(@String) - @idx)       
          IF len(@String) = 0 break       
     END   
   RETURN       
 END


GO
/****** Object:  Table [dbo].[CategThings]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategThings](
	[idCategThing] [int] NOT NULL,
	[CategThing] [nchar](100) NULL,
	[CategThingDesc] [nchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Log_Users]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Log_Users](
	[Logid] [int] IDENTITY(100,1) NOT NULL,
	[Usr] [varchar](55) NOT NULL,
	[Pswrd] [varchar](55) NULL,
	[Time_Logged_in] [datetime] NULL,
	[Time_Logged_Out] [datetime] NULL,
	[Status] [int] NULL,
	[Date_Logged_in] [datetime] NULL,
	[E_MAIL] [varchar](55) NULL,
	[Phone] [nchar](50) NULL,
	[IP] [nchar](50) NULL,
	[Location] [nchar](50) NULL,
	[Name] [nchar](50) NULL,
	[Webpage] [nchar](100) NULL,
 CONSTRAINT [PK__Log_User__5E5582505BBC246D] PRIMARY KEY CLUSTERED 
(
	[Logid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaskkerEmails]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaskkerEmails](
	[idTaskEmail] [int] IDENTITY(1,1) NOT NULL,
	[TaskEmail] [nchar](255) NULL,
	[TaskSubject] [nchar](500) NULL,
	[TaskBody] [nvarchar](max) NULL,
	[TaskDate] [datetime] NULL,
	[TaskAttachment] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Taskkers]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Taskkers](
	[idTaskker] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [nchar](255) NULL,
	[idStatus] [int] NULL,
	[idCateg] [nchar](2) NULL,
	[TaskkerUniq] [nchar](5) NULL,
	[TaskkerUserName] [nchar](255) NULL,
	[TaskkerEmail] [nchar](255) NULL,
	[TaskkerSubject] [nvarchar](255) NULL,
	[TaskkerBody] [nvarchar](max) NULL,
	[TaskkerHomePage] [nchar](1) NULL,
	[TaskkerStart] [nchar](18) NULL,
	[TaskkerDue] [nchar](18) NULL,
	[TaskkerLocation] [nchar](200) NULL,
	[TaskkerDate] [datetime] NULL,
	[TaskkerPrice] [nchar](18) NULL,
	[TaskkerCoin] [nchar](4) NULL,
	[TaskkerHours] [nchar](4) NULL,
	[TaskkerStatus] [nchar](2) NULL,
	[TaskkerPrivacy] [nchar](2) NULL,
	[TaskkerAssignmentEmail] [nchar](250) NULL,
	[TaskkerAttachment] [nchar](250) NULL,
	[TaskkerIP] [nchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskkersComment]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskkersComment](
	[idTaskkerComment] [int] IDENTITY(1,1) NOT NULL,
	[TaskkerComment] [ntext] NULL,
	[TaskkerCommentDate] [datetime] NULL,
	[TaskkerCommentUser] [nchar](180) NULL,
	[TaskkerCommentEmail] [nchar](200) NULL,
	[TaskkerResponseValue] [nchar](10) NULL,
	[TaskkerResponseCoin] [nchar](4) NULL,
	[TaskkerUniqID] [nchar](8) NULL,
	[TaskkerIP] [nchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskkersStatus]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskkersStatus](
	[idStatus] [int] IDENTITY(1,1) NOT NULL,
	[TaskkerStatus] [nchar](20) NULL,
	[TaskkerStatusCode] [nchar](1) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskkerStats]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskkerStats](
	[idStats] [int] IDENTITY(1,1) NOT NULL,
	[TaskkerStat] [nchar](200) NULL,
	[TaskkerIP] [nchar](15) NULL,
	[TaskkerDate] [nchar](16) NULL,
	[TaskkerUniq] [nchar](8) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaskkerUsersProfiles]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskkerUsersProfiles](
	[idUser] [int] IDENTITY(1,1) NOT NULL,
	[TaskkerUserName] [nchar](150) NULL,
	[TaskkerUserUniqID] [nchar](45) NULL,
	[TaskkerUserEmail] [nchar](200) NULL,
	[TaskkerUserAvatar] [nchar](90) NULL,
	[TaskkerUserIP] [nchar](30) NULL,
	[TaskkerUserDate] [nchar](20) NULL,
	[TaskkerUserLocation] [nchar](40) NULL,
	[TaskkerUserRealName] [nchar](90) NULL,
	[TaskkerUserBio] [nchar](500) NULL,
	[TaskkerUserWeb] [nchar](120) NULL,
	[TaskkerUserInterests] [nchar](140) NULL,
	[TaskkerUserNetwork] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ToDoThings]    Script Date: 11/21/2013 7:59:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ToDoThings](
	[idThingToDo] [int] NOT NULL,
	[ThingToDo] [nchar](400) NULL,
	[Categ] [nchar](10) NULL,
	[CategSec] [nchar](10) NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Log_Users] ADD  CONSTRAINT [DF_Log_Users_Date_Logged_in]  DEFAULT (getdate()) FOR [Date_Logged_in]
GO
ALTER TABLE [dbo].[Taskkers] ADD  CONSTRAINT [DF_Taskkers_TaskkerDate]  DEFAULT (getdate()) FOR [TaskkerDate]
GO
ALTER TABLE [dbo].[Taskkers] ADD  CONSTRAINT [DF_Taskkers_TaskkerPrice]  DEFAULT ((0)) FOR [TaskkerPrice]
GO
USE [master]
GO
ALTER DATABASE [Taskker] SET  READ_WRITE 
GO
