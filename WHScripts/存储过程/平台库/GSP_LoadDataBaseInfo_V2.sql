USE [WHServerInfoDB]
GO
/****** Object:  StoredProcedure [dbo].[GSP_LoadDataBaseInfo_V2]    Script Date: 2018/12/21 20:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------------------------

-- 连接信息
create PROCEDURE [dbo].[GSP_LoadDataBaseInfo_V2]
	@strDBAddr NVARCHAR(32)						-- 数据库地址
  AS

-- 属性设置
SET NOCOUNT ON

-- 变量定义
DECLARE @DBPort INT
DECLARE @DBAddr NVARCHAR(128)
DECLARE @DBUser NVARCHAR(512)
DECLARE @DBPassword NVARCHAR(512)
DECLARE @ErrorDescribe NVARCHAR(128)

-- 执行逻辑
BEGIN

	-- 查询信息
	SELECT @DBAddr=DBAddr, @DBPort=DBPort, @DBUser=DBUser, @DBPassword=DBPassword 
		FROM DataBaseInfo(NOLOCK) WHERE DBAddrExt=@strDBAddr
	
	-- 存在判断
	IF @DBAddr IS NULL
	BEGIN
		SET @ErrorDescribe=N'数据库 [ '+@strDBAddr+N' ] 连接信息不存在，请检查 WHServerInfoDB 数据库的 SQLDBConnectInfo 表数据'
		SELECT [ErrorDescribe]=@ErrorDescribe
		RETURN 1
	END
	
	-- 输出变量
	SELECT @DBAddr AS DBAddr, @DBPort AS DBPort, @DBUser AS DBUser, @DBPassword AS DBPassword
	
END

RETURN 0

----------------------------------------------------------------------------------------------------

