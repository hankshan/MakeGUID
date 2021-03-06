USE [WHServerInfoDB]
GO
/****** 对象:  Table [dbo].[DataBaseInfo]    脚本日期: 12/08/2008 11:51:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataBaseInfo](
	[DBAddr] [nvarchar](15) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[DBPort] [int] NOT NULL CONSTRAINT [DF_TABLE1_DataBasePort]  DEFAULT ((1433)),
	[DBAddrExt] [nvarchar](32) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[DBUser] [nvarchar](512) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[DBPassword] [nvarchar](512) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Information] [nvarchar](128) COLLATE Chinese_PRC_CI_AS NOT NULL CONSTRAINT [DF_SQLConnectInfo_NoteInfo]  DEFAULT (''),
 CONSTRAINT [PK_DataBaseInfo_DBAddr] PRIMARY KEY CLUSTERED 
(
	[DBAddrExt] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库地址' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'DBAddr'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库端口' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'DBPort'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库用户' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'DBUser'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库密码' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'DBPassword'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'备注信息' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataBaseInfo', @level2type=N'COLUMN',@level2name=N'Information'
GO

/****** 对象:  Table [dbo].[GameConfig]    脚本日期: 12/08/2008 11:51:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GameConfig]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GameConfig](
	[Name] [nvarchar](32) NOT NULL,
	[Value] [nvarchar](64) NOT NULL,
	[ValidDate] [datetime] NOT NULL,
	[Describe] [nvarchar](64) NULL,
	[ToClient] [int] NOT NULL CONSTRAINT [DF_GameConfig_ToClient]  DEFAULT ((0)),
	[LoginServer] [nvarchar](64) NULL
) ON [PRIMARY]
END
GO

/****** 对象:  Table [dbo].[GameKindItem]    脚本日期: 12/08/2008 11:51:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameKindItem](
	[KindID] [int] NOT NULL,
	[TypeID] [int] NOT NULL,
	[JoinID] [int] NOT NULL CONSTRAINT [DF_GameKindItem_JoinID]  DEFAULT ((0)),
	[SortID] [int] NOT NULL CONSTRAINT [DF_GameKindItem_SortID]  DEFAULT ((1000)),
	[KindName] [nvarchar](32) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[ProcessName] [nvarchar](32) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[MaxVersion] [int] NOT NULL CONSTRAINT [DF_GameKindItem_MaxVersion]  DEFAULT ((65542)),
	[DataBaseName] [nvarchar](32) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Nullity] [bit] NOT NULL CONSTRAINT [DF_GameKindItem_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_GameKindItem] PRIMARY KEY CLUSTERED 
(
	[KindID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** 对象:  Index [IX_GameKindItem_JoinID]    脚本日期: 12/08/2008 11:51:42 ******/
CREATE NONCLUSTERED INDEX [IX_GameKindItem_JoinID] ON [dbo].[GameKindItem] 
(
	[JoinID] ASC
) ON [PRIMARY]
GO

/****** 对象:  Index [IX_GameKindItem_SortID]    脚本日期: 12/08/2008 11:51:42 ******/
CREATE NONCLUSTERED INDEX [IX_GameKindItem_SortID] ON [dbo].[GameKindItem] 
(
	[SortID] ASC
) ON [PRIMARY]
GO

/****** 对象:  Index [IX_GameKindItem_TypeID]    脚本日期: 12/08/2008 11:51:42 ******/
CREATE NONCLUSTERED INDEX [IX_GameKindItem_TypeID] ON [dbo].[GameKindItem] 
(
	[TypeID] ASC
) ON [PRIMARY]
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'种类标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'TypeID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'挂接标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'JoinID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'排序标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'SortID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'类型名字' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'KindName'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'进程名字' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'ProcessName'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'版本号码' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'MaxVersion'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'数据库名字' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'DataBaseName'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameKindItem', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
/****** 对象:  Table [dbo].[GameNodeItem]    脚本日期: 12/08/2008 11:51:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameNodeItem](
	[NodeID] [int] NOT NULL,
	[KindID] [int] NOT NULL,
	[JoinID] [int] NOT NULL CONSTRAINT [DF_GameStationItem_JoinID]  DEFAULT ((0)),
	[SortID] [int] NOT NULL CONSTRAINT [DF_GameStationItem_SortID]  DEFAULT ((1000)),
	[NodeName] [nvarchar](32) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Nullity] [bit] NOT NULL CONSTRAINT [DF_GameStationItem_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_GameNodeItem] PRIMARY KEY CLUSTERED 
(
	[NodeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** 对象:  Index [IX_GameStationItem_JoinID]    脚本日期: 12/08/2008 11:51:42 ******/
CREATE NONCLUSTERED INDEX [IX_GameStationItem_JoinID] ON [dbo].[GameNodeItem] 
(
	[JoinID] ASC
) ON [PRIMARY]
GO

/****** 对象:  Index [IX_GameStationItem_KindID]    脚本日期: 12/08/2008 11:51:42 ******/
CREATE NONCLUSTERED INDEX [IX_GameStationItem_KindID] ON [dbo].[GameNodeItem] 
(
	[KindID] ASC
) ON [PRIMARY]
GO

/****** 对象:  Index [IX_GameStationItem_SortID]    脚本日期: 12/08/2008 11:51:42 ******/
CREATE NONCLUSTERED INDEX [IX_GameStationItem_SortID] ON [dbo].[GameNodeItem] 
(
	[SortID] ASC
) ON [PRIMARY]
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'节点标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'NodeID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'KindID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'挂接标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'JoinID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'排序标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'SortID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'站点名字' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'NodeName'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameNodeItem', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
/****** 对象:  Table [dbo].[GameTypeItem]    脚本日期: 12/08/2008 11:51:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameTypeItem](
	[TypeID] [int] NOT NULL,
	[JoinID] [int] NOT NULL CONSTRAINT [DF_GameTypeItem_JoinID]  DEFAULT ((0)),
	[SortID] [int] NOT NULL CONSTRAINT [DF_GameTypeItem_SortID]  DEFAULT ((1000)),
	[TypeName] [nvarchar](32) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Nullity] [bit] NOT NULL CONSTRAINT [DF_GameTypeItem_Nullity]  DEFAULT ((0)),
 CONSTRAINT [PK_GameTypeItem_TypeID] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** 对象:  Index [IX_GameTypeItem_JoinID]    脚本日期: 12/08/2008 11:51:42 ******/
CREATE NONCLUSTERED INDEX [IX_GameTypeItem_JoinID] ON [dbo].[GameTypeItem] 
(
	[JoinID] ASC
) ON [PRIMARY]
GO

/****** 对象:  Index [IX_GameTypeItem_SortID]    脚本日期: 12/08/2008 11:51:42 ******/
CREATE NONCLUSTERED INDEX [IX_GameTypeItem_SortID] ON [dbo].[GameTypeItem] 
(
	[SortID] ASC
) ON [PRIMARY]
GO

/****** 对象:  Index [IX_GameTypeItem_TypeName]    脚本日期: 12/08/2008 11:51:42 ******/
CREATE NONCLUSTERED INDEX [IX_GameTypeItem_TypeName] ON [dbo].[GameTypeItem] 
(
	[TypeName] ASC
) ON [PRIMARY]
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'类型标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem', @level2type=N'COLUMN',@level2name=N'TypeID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'挂接标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem', @level2type=N'COLUMN',@level2name=N'JoinID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'排序标识' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem', @level2type=N'COLUMN',@level2name=N'SortID'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'类型名字' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem', @level2type=N'COLUMN',@level2name=N'TypeName'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'无效标志' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem', @level2type=N'COLUMN',@level2name=N'Nullity'
GO
EXEC dbo.sp_addextendedproperty @name=N'MS_Description', @value=N'类型信息' , @level0type=N'USER',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GameTypeItem'



USE [WHServerInfoDB]
GO
/****** 对象:  Table [dbo].[GameBBS]    脚本日期: 07/08/2015 14:16:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameBBS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsValid] [smallint] NOT NULL CONSTRAINT [DF_GameBBS_IsValid]  DEFAULT ((0)),
	[Type] [smallint] NOT NULL CONSTRAINT [DF_GameBBS_Type]  DEFAULT ((0)),
	[Date] [datetime] NOT NULL CONSTRAINT [DF_GameBBS_Date]  DEFAULT (getdate()),
	[Title] [nvarchar](128) COLLATE Chinese_PRC_CI_AS NULL,
	[Details] [nvarchar](512) COLLATE Chinese_PRC_CI_AS NULL,
	[Action] [smallint] NOT NULL CONSTRAINT [DF_GameBBS_Action]  DEFAULT ((0)),
	[AttachInfo] [nvarchar](64) COLLATE Chinese_PRC_CI_AS NULL,
	[ClientName] [nvarchar](32) COLLATE Chinese_PRC_CI_AS NOT NULL CONSTRAINT [DF_GameBBS_ClientName]  DEFAULT (N''),
	[StartDate] [datetime] NULL CONSTRAINT [DF_GameBBS_StartDate]  DEFAULT (getdate()),
	[EndDate] [datetime] NULL CONSTRAINT [DF_GameBBS_EndDate]  DEFAULT (getdate())
) ON [PRIMARY]

USE [WHServerInfoDB]
GO
/****** 对象:  Table [dbo].[GameKeFu]    脚本日期: 07/08/2015 14:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameKeFu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[Date] [datetime] NOT NULL CONSTRAINT [DF_GameKeFu_Date]  DEFAULT (getdate()),
	[Question] [nvarchar](512) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[AttachPath] [nvarchar](128) COLLATE Chinese_PRC_CI_AS NULL,
	[Reply] [nvarchar](256) COLLATE Chinese_PRC_CI_AS NULL,
	[ReplyDate] [datetime] NULL,
	[Replier] [nvarchar](64) COLLATE Chinese_PRC_CI_AS NULL,
	[Status] [smallint] NOT NULL CONSTRAINT [DF_GameKeFu_Status]  DEFAULT ((0)),
	[ChannelName] [nvarchar](32) COLLATE Chinese_PRC_CI_AS NOT NULL CONSTRAINT [DF_GameKeFu_ChannelName]  DEFAULT (N'')
) ON [PRIMARY]

USE [WHServerInfoDB]
GO
/****** 对象:  Table [dbo].[GameSpeaker]    脚本日期: 05/18/2016 16:48:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameSpeaker](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL CONSTRAINT [DF_GameSpeaker_UserID]  DEFAULT ((0)),
	[Account] [nvarchar](50) NULL,
	[Txt] [nvarchar](256) NULL,
	[Type] [tinyint] NOT NULL CONSTRAINT [DF_GameSpeaker_Type]  DEFAULT ((0)),
	[CollectDate] [datetime] NOT NULL CONSTRAINT [DF_GameSpeaker_CollectDate]  DEFAULT (getdate())
) ON [PRIMARY]


USE [WHServerInfoDB]
GO
/****** 对象:  Table [dbo].[UserConfig]    脚本日期: 05/18/2016 16:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserConfig](
	[K] [nvarchar](10) NULL,
	[V] [nvarchar](255) NULL,
	[IsValid] [tinyint] NOT NULL CONSTRAINT [DF_UserConfig_IsValid]  DEFAULT ((0)),
	[OrderID] [int] NOT NULL CONSTRAINT [DF_UserConfig_OrderID]  DEFAULT ((0)),
	[Version] [int] NOT NULL CONSTRAINT [DF_UserConfig_Version]  DEFAULT ((0)),
	[UserID] [int] NOT NULL CONSTRAINT [DF_UserConfig_UserID]  DEFAULT ((0)),
	[ConfigID] [int] NOT NULL CONSTRAINT [DF_UserConfig_ConfigID]  DEFAULT ((0)),
	[ClientName] [nvarchar](32) NOT NULL CONSTRAINT [DF_UserConfig_ClientName]  DEFAULT (N'')
) ON [PRIMARY]
