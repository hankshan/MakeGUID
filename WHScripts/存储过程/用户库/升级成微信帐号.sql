USE WHGameUserDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_WXUpdate_v2]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_WXUpdate_v2]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 升级成WX帐号
CREATE PROC [dbo].[GSP_GP_WXUpdate_v2]
	@iUserId INT,						-- 用户ID
	@strNickname NVARCHAR(32),						
	@strOpenid NVARCHAR(32),						
	@strUnionid NVARCHAR(64),						
	@strFaceUrl NVARCHAR(256),						
	@cbGender TINYINT,							-- 用户性别
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strWXMachineSerial NCHAR(32),				-- 机器码(微信信息的唯一编码)
	@strMachineSerial NCHAR(32)					-- 机器标识
AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @FaceID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @RegAccounts NVARCHAR(31)
DECLARE @TmpRegAccounts NVARCHAR(31)
DECLARE @UnderWrite NVARCHAR(63)

-- 扩展信息
DECLARE @GameID INT
DECLARE @SpreaderID INT
DECLARE @Gender TINYINT
DECLARE @Experience INT
DECLARE @Loveliness INT
DECLARE @MemberOrder INT
DECLARE @MemberOverDate DATETIME
DECLARE @CustomFaceVer TINYINT
DECLARE @IsGuest TINYINT
DECLARE @HasGuest TINYINT
DECLARE @GOLDSCORE INT

-- 辅助变量
DECLARE @EnjoinLogon AS INT
DECLARE @EnjoinRegister AS INT
DECLARE @ErrorDescribe AS NVARCHAR(128)
DECLARE @Rule AS NVARCHAR(512)
DECLARE @guestAccounts NVARCHAR(31)		-- 游客帐号
DECLARE @guestPasswordX NVARCHAR(32)		-- 游客密码
DECLARE @guestPassword NVARCHAR(32)		-- 游客密码明文
DECLARE @guestGender TINYINT			-- 游客性别
DECLARE @NeedGuest AS INT			-- 是否需要游客帐号
DECLARE @iCount AS INT				-- 循环计数器
DECLARE @TheWeekday AS INT			-- 当天星期几
DECLARE @TheNewAward AS INT			-- 新用户赠送数
DECLARE @GMScore INT

-- 扩展信息
-- 辅助变量
DECLARE @strAccounts NVARCHAR(32)

set @UserID=@iUserId

if (@cbGender=1)
BEGIN
	set @cbGender = 49
END
ELSE
BEGIN
	set @cbGender = 48
END

-- 执行逻辑
BEGIN
	-- 查询用户
	SELECT @strAccounts=Accounts,@IsGuest=IsGuest FROM AccountsInfo(NOLOCK) WHERE UserID=@iUserId

	IF @strAccounts IS NULL 
	BEGIN
		SELECT [ErrorDescribe]=N'帐号不存在！'
		RETURN 1
	END

	IF @IsGuest<>1 
	BEGIN
		SELECT [ErrorDescribe]=N'帐号不是游客帐号！'
		RETURN 2
	END

	-- 查询用户
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Openid=@strOpenid)
	BEGIN
		SELECT [ErrorDescribe]=N'您的微信账号已存在，换个微信试试吧！'
		RETURN 3
	END
	
	--升级
	UPDATE AccountsInfo SET RegAccounts=@strNickName,Gender=@cbGender,OpenID=@strOpenid,Unionid=@strUnionid,FaceUrl=@strFaceUrl,MachineSerial=@strWXMachineSerial,IsGuest=2 WHERE UserID=@iUserId

	-- 查询用户
	SELECT @UserID=UserID, @Accounts=Accounts, @UnderWrite=UnderWrite, @Gender=Gender, @FaceID=FaceID, @Experience=Experience,
		@MemberOrder=MemberOrder, @MemberOverDate=MemberOverDate, @Loveliness=Loveliness,@CustomFaceVer=CustomFaceVer
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	SET @HasGuest=0

	-- 查询用户
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE MachineSerial=@strMachineSerial and isguest=1)
	BEGIN
		SET @HasGuest=1
	END

	SET @GameID=0

	-- 游戏信息
	SELECT @GoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID

	-- 信息判断
	IF @GoldScore IS NULL
	BEGIN
		-- 插入资料
		INSERT INTO WHTreasureDB.dbo.GameScoreInfo (UserID, LastLogonIP, RegisterIP)	VALUES (@UserID,@strClientIP,@strClientIP)

		-- 游戏信息
		SELECT @GoldScore=Score FROM WHTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID
	END
	
	--只有新人才有奖励
	IF @NeedGuest <> 0
	BEGIN
		SET @TheNewAward = @GoldScore
		SET @RegAccounts = @strNickName
	END


	--检查GM工具发放的奖励
	EXEC @GMScore=dbo.GSP_GP_CheckUserGMScore @UserID
	SET @GoldScore = @GoldScore + @GMScore

	-- 查询系统参数配置
	SET @Rule = N''
	DECLARE c1 cursor for SELECT name,value from WHServerInfoDB.dbo.GameConfig WHERE getdate() >= ValidDate and ToClient=1
        DECLARE @sname varchar(32), @svalue varchar(64), @nWeekday INT, @nLen INT, @nTemp INT
        OPEN c1  
        FETCH c1 INTO @sname,@svalue  
        WHILE @@fetch_status=0  
        BEGIN  
		
		IF @sname='wx_task'	--判断任务面板中的微信分享是否显示
		BEGIN
			SET @nTemp = 0
			SET @TheWeekday=CONVERT(INT, datepart(weekday, getdate()))-1 --当前星期几
			IF @TheWeekday = 0		--星期天时值为7
				SET @TheWeekday = 7
				
			WHILE @svalue<>''
			BEGIN
				SET @nLen = LEN(@svalue)
				IF @nLen = 1
				BEGIN
					SET @nWeekday = CONVERT(INT, LEFT(@svalue, 1))
					SET @svalue = STUFF(@svalue, 1, 1, '')
				END
				ELSE
				BEGIN
					SET @nWeekday = CONVERT(INT, LEFT(@svalue, CHARINDEX('/', @svalue)-1))
					SET @svalue = STUFF(@svalue, 1, 2, '')
				END
				
				IF @TheWeekday = @nWeekday
				BEGIN
					SET @nTemp = 1
					BREAK
				END
			END
			
			IF @nTemp = 1
			BEGIN
				SET @svalue = '1'
			END
			ELSE 
			BEGIN
				SET @svalue = '0'
			END
		END
		
		IF @Rule = ''  
		BEGIN  
			SET @Rule = @sname + ':' + @svalue
		END
		ELSE 
		BEGIN  
			SET @Rule = @Rule + '|' + @sname + ':' + @svalue
		END 
 
		FETCH c1 INTO @sname,@svalue  
        END 
	CLOSE c1
	DEALLOCATE c1

	--追加ip
	SET @Rule = @Rule + '|ip:' + @strClientIP 

	-- 输出变量
	SET @IsGuest = 2
	SELECT @UserID AS UserID, @GameID AS GameID, @Accounts AS Accounts, @strNickname AS NickName, @GuestPassword AS GuestPassword, @UnderWrite AS UnderWrite, @FaceID AS FaceID, @Gender AS Gender, @Experience AS Experience, @MemberOrder AS MemberOrder, @MemberOverDate AS MemberOverDate,@ErrorDescribe AS ErrorDescribe, @Loveliness AS Loveliness,@CustomFaceVer AS CustomFaceVer,@GoldScore AS GoldScore, @Rule AS LobbyRule, @IsGuest AS IsGuest, @TheNewAward AS NewAward,@HasGuest as HasGuest
END

RETURN 0


