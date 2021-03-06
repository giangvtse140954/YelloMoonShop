USE [YellowMoonShop]
GO
/****** Object:  Table [dbo].[tblCate]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCate](
	[cateId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__tblCate__A88B4DE4A6380280] PRIMARY KEY CLUSTERED 
(
	[cateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblLog]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLog](
	[logId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [varchar](100) NULL,
	[proId] [int] NULL,
	[date] [date] NULL,
 CONSTRAINT [PK__tblLog__7839F64DE772EFEF] PRIMARY KEY CLUSTERED 
(
	[logId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOrder](
	[orderId] [uniqueidentifier] NOT NULL CONSTRAINT [DF__tblOrder__orderI__2D27B809]  DEFAULT (newid()),
	[userId] [varchar](100) NULL,
	[total] [float] NOT NULL,
	[date] [datetime] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[address] [varchar](500) NOT NULL,
	[status] [nvarchar](20) NULL,
	[phone] [char](10) NULL,
 CONSTRAINT [PK__tblOrder__0809335DD566BE9B] PRIMARY KEY CLUSTERED 
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[detailId] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [uniqueidentifier] NULL,
	[proId] [int] NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK__tblOrder__8307785985529D1A] PRIMARY KEY CLUSTERED 
(
	[detailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblProduct](
	[proId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
	[cateId] [int] NULL,
	[image] [varchar](500) NULL,
	[expiredDate] [date] NULL,
	[createDate] [date] NULL,
	[description] [varchar](200) NULL,
	[status] [varchar](10) NOT NULL,
 CONSTRAINT [PK__tblProdu__5BBBEEF5C1F17437] PRIMARY KEY CLUSTERED 
(
	[proId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblRole](
	[roleId] [int] NOT NULL,
	[name] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[userId] [varchar](100) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[phone] [char](10) NULL,
	[address] [varchar](500) NOT NULL,
	[roleId] [int] NULL,
	[password] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tblCate] ON 

INSERT [dbo].[tblCate] ([cateId], [name]) VALUES (1, N'Nhan Dua')
INSERT [dbo].[tblCate] ([cateId], [name]) VALUES (2, N'Nhan Dau Xanh')
INSERT [dbo].[tblCate] ([cateId], [name]) VALUES (3, N'Nhan Trai')
INSERT [dbo].[tblCate] ([cateId], [name]) VALUES (4, N'Nhan My')
SET IDENTITY_INSERT [dbo].[tblCate] OFF
SET IDENTITY_INSERT [dbo].[tblLog] ON 

INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (1, N'vuthugiang', 2, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (2, N'vuthugiang', 2, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (3, N'vuthugiang', 2, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (4, N'vuthugiang', 2, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (5, N'vuthugiang', 2, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (6, N'vuthugiang', 2, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (7, N'vuthugiang', 2, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (8, N'vuthugiang', 5, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (9, N'vuthugiang', 5, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (10, N'vuthugiang', 2, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (11, N'vuthugiang', 5, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (12, N'vuthugiang', 5, CAST(N'2020-10-12' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (13, N'vuthugiang', 9, CAST(N'2020-10-13' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (14, N'vuthugiang', 11, CAST(N'2020-10-13' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (15, N'vuthugiang', 1, CAST(N'2020-10-14' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (16, N'vuthugiang', 13, CAST(N'2020-10-16' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (17, N'vuthugiang', 1, CAST(N'2020-10-16' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (18, N'vuthugiang', 7, CAST(N'2020-10-16' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (19, N'vuthugiang', 7, CAST(N'2020-10-16' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (20, N'vuthugiang', 7, CAST(N'2020-10-16' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (21, N'vuthugiang', 7, CAST(N'2020-10-16' AS Date))
INSERT [dbo].[tblLog] ([logId], [userId], [proId], [date]) VALUES (22, N'vuthugiang', 9, CAST(N'2020-10-16' AS Date))
SET IDENTITY_INSERT [dbo].[tblLog] OFF
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [name], [address], [status], [phone]) VALUES (N'b66ed910-b592-470f-b099-1716ce5abd77', NULL, 2700.46, CAST(N'2020-10-16 17:25:51.020' AS DateTime), N'Ant-1.10', N'giangvtse140954', N'delivering', N'0988246909')
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [name], [address], [status], [phone]) VALUES (N'3af07414-eaa6-4641-af29-306702f0350c', N'daothienphuc', 2478.16, CAST(N'2020-10-17 12:01:52.923' AS DateTime), N'Dao Thien Phuc', N'tran hoi, tran van thoi, ca mau', N'delivering', N'0909015723')
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [name], [address], [status], [phone]) VALUES (N'1f12e9e2-1f86-4228-86cc-7208bc9ab66a', NULL, 2587.96, CAST(N'2020-10-17 17:03:46.993' AS DateTime), N'Hung Nguyen', N'giangvtse140954', N'delivering', N'0988246909')
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [name], [address], [status], [phone]) VALUES (N'59fcc421-1bf9-4297-94cc-e33cadc12615', NULL, 123.2, CAST(N'2020-10-16 17:13:40.727' AS DateTime), N'Ant-1.10', N'eeeee', N'delivering', N'0988246909')
SET IDENTITY_INSERT [dbo].[tblOrderDetail] ON 

INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [proId], [price], [quantity]) VALUES (25, N'b66ed910-b592-470f-b099-1716ce5abd77', 2, 1232.48, 2)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [proId], [price], [quantity]) VALUES (26, N'b66ed910-b592-470f-b099-1716ce5abd77', 7, 100.3, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [proId], [price], [quantity]) VALUES (27, N'b66ed910-b592-470f-b099-1716ce5abd77', 9, 12.2, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [proId], [price], [quantity]) VALUES (28, N'b66ed910-b592-470f-b099-1716ce5abd77', 12, 123, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [proId], [price], [quantity]) VALUES (29, N'3af07414-eaa6-4641-af29-306702f0350c', 1, 12.2, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [proId], [price], [quantity]) VALUES (30, N'3af07414-eaa6-4641-af29-306702f0350c', 2, 1232.48, 2)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [proId], [price], [quantity]) VALUES (31, N'3af07414-eaa6-4641-af29-306702f0350c', 13, 1, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [proId], [price], [quantity]) VALUES (32, N'1f12e9e2-1f86-4228-86cc-7208bc9ab66a', 2, 1232.48, 2)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [proId], [price], [quantity]) VALUES (33, N'1f12e9e2-1f86-4228-86cc-7208bc9ab66a', 12, 123, 1)
SET IDENTITY_INSERT [dbo].[tblOrderDetail] OFF
SET IDENTITY_INSERT [dbo].[tblProduct] ON 

INSERT [dbo].[tblProduct] ([proId], [name], [price], [quantity], [cateId], [image], [expiredDate], [createDate], [description], [status]) VALUES (1, N'Trang Vang Kim Cuong', 12.2, 1, 1, N'dua.jpg', CAST(N'2020-12-12' AS Date), CAST(N'2020-07-20' AS Date), N'Banh nay sieu ngon', N'Active')
INSERT [dbo].[tblProduct] ([proId], [name], [price], [quantity], [cateId], [image], [expiredDate], [createDate], [description], [status]) VALUES (2, N'Trang Vang Hoang Kim', 1232.48, 770, 1, N'my.jpg', CAST(N'2020-12-19' AS Date), CAST(N'2020-12-09' AS Date), N'Banh nay sieu ngon lanh', N'Active')
INSERT [dbo].[tblProduct] ([proId], [name], [price], [quantity], [cateId], [image], [expiredDate], [createDate], [description], [status]) VALUES (4, N'Trang Vang Pha Le', 11.1, 7, 2, N'dua.jpg', CAST(N'2020-12-13' AS Date), CAST(N'2020-02-20' AS Date), N'Banh nay sieu ngon', N'Active')
INSERT [dbo].[tblProduct] ([proId], [name], [price], [quantity], [cateId], [image], [expiredDate], [createDate], [description], [status]) VALUES (5, N'Trang Vang Dep Trai', 111, 2, 2, N'deptrai.jpg', CAST(N'2020-11-20' AS Date), CAST(N'2020-06-23' AS Date), N'Banh kha la ngon day', N'Active')
INSERT [dbo].[tblProduct] ([proId], [name], [price], [quantity], [cateId], [image], [expiredDate], [createDate], [description], [status]) VALUES (6, N'My Ket Hop Trang', 101, 220, 4, N'my.jpg', CAST(N'2021-02-23' AS Date), CAST(N'2020-01-01' AS Date), N'My an chung voi banh', N'Active')
INSERT [dbo].[tblProduct] ([proId], [name], [price], [quantity], [cateId], [image], [expiredDate], [createDate], [description], [status]) VALUES (7, N'Banh moi nhap luon', 100.3, 9, 2, N'deptrai.jpg', CAST(N'2020-10-09' AS Date), CAST(N'2020-09-08' AS Date), N'Anh minh ngon hoi voi bo', N'Active')
INSERT [dbo].[tblProduct] ([proId], [name], [price], [quantity], [cateId], [image], [expiredDate], [createDate], [description], [status]) VALUES (9, N'Banh nha', 12.2, 0, 1, N'nha.jpg', CAST(N'2020-12-30' AS Date), CAST(N'2018-10-10' AS Date), N'hahah', N'Active')
INSERT [dbo].[tblProduct] ([proId], [name], [price], [quantity], [cateId], [image], [expiredDate], [createDate], [description], [status]) VALUES (11, N'Giang Vu', 12.22, 3, 1, N'nha.jpg', CAST(N'2020-10-14' AS Date), CAST(N'2020-10-01' AS Date), N'banh trung thu giang vu', N'Active')
INSERT [dbo].[tblProduct] ([proId], [name], [price], [quantity], [cateId], [image], [expiredDate], [createDate], [description], [status]) VALUES (12, N'do thi hoa', 123, 0, 2, N'dua.jpg', CAST(N'2020-10-28' AS Date), CAST(N'2020-10-13' AS Date), N'123123123', N'Deactive')
INSERT [dbo].[tblProduct] ([proId], [name], [price], [quantity], [cateId], [image], [expiredDate], [createDate], [description], [status]) VALUES (13, N'qweqweq', 1, 0, 1, N'nha.jpg', CAST(N'2020-11-06' AS Date), CAST(N'2020-10-13' AS Date), N'qweqewqwe', N'Deactive')
SET IDENTITY_INSERT [dbo].[tblProduct] OFF
INSERT [dbo].[tblRole] ([roleId], [name]) VALUES (1, N'Admin')
INSERT [dbo].[tblRole] ([roleId], [name]) VALUES (2, N'Employee')
INSERT [dbo].[tblUser] ([userId], [name], [phone], [address], [roleId], [password]) VALUES (N'daothienphuc', N'Dao Thien Phuc', N'0909015723', N'tran hoi, tran van thoi, ca mau', 2, N'123123')
INSERT [dbo].[tblUser] ([userId], [name], [phone], [address], [roleId], [password]) VALUES (N'dothihoa2512@gmail.com', N'', N'          ', N'', 2, N'114472777547339517038')
INSERT [dbo].[tblUser] ([userId], [name], [phone], [address], [roleId], [password]) VALUES (N'vuthugiang', N'Vu Thu Giang', N'0988246909', N'tran hoi, tran van thoi, ca mau', 1, N'123123')
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__tblUser__B43B145F30458744]    Script Date: 10/18/2020 3:39:51 PM ******/
ALTER TABLE [dbo].[tblUser] ADD UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK__tblLog__proId__4AB81AF0] FOREIGN KEY([proId])
REFERENCES [dbo].[tblProduct] ([proId])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK__tblLog__proId__4AB81AF0]
GO
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK__tblLog__userId__49C3F6B7] FOREIGN KEY([userId])
REFERENCES [dbo].[tblUser] ([userId])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK__tblLog__userId__49C3F6B7]
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK__tblOrder__userId__2E1BDC42] FOREIGN KEY([userId])
REFERENCES [dbo].[tblUser] ([userId])
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK__tblOrder__userId__2E1BDC42]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__tblOrderD__order__33D4B598] FOREIGN KEY([orderId])
REFERENCES [dbo].[tblOrder] ([orderId])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK__tblOrderD__order__33D4B598]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK__tblOrderD__proId__34C8D9D1] FOREIGN KEY([proId])
REFERENCES [dbo].[tblProduct] ([proId])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK__tblOrderD__proId__34C8D9D1]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK__tblProduc__cateI__30F848ED] FOREIGN KEY([cateId])
REFERENCES [dbo].[tblCate] ([cateId])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK__tblProduc__cateI__30F848ED]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD FOREIGN KEY([roleId])
REFERENCES [dbo].[tblRole] ([roleId])
GO
/****** Object:  StoredProcedure [dbo].[getProFromAd]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getProFromAd] 
 @PageNumber int,
 @RowsOfPage int,
 @name varchar(100),
 @lowPrice float,
 @highPrice float,
 @cateId int
AS
	SELECT proId, name, price, quantity, cateId, image, description, expiredDate, createDate, status
	FROM tblProduct
	where name like '%' + @name + '%' and price >= @lowPrice and price <= @highPrice and cateId = @cateId
	ORDER BY createDate desc 
	OFFSET (@PageNumber-1)*@RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;

	select * from tblProduct


GO
/****** Object:  StoredProcedure [dbo].[getProFromAdAcceptCate]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getProFromAdAcceptCate] 
 @PageNumber int,
 @RowsOfPage int,
 @name varchar(100),
 @lowPrice float,
 @highPrice float
AS
	SELECT proId, name, price, quantity, cateId, image, description, expiredDate, createDate, status
	FROM tblProduct
	where name like '%' + @name + '%' and price >= @lowPrice and price <= @highPrice 
	ORDER BY createDate desc 
	OFFSET (@PageNumber-1)*@RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;

	select * from tblProduct


GO
/****** Object:  StoredProcedure [dbo].[getProFromEmp]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[getProFromEmp] 
 @PageNumber int,
 @RowsOfPage int,
 @name varchar(100),
 @lowPrice float,
 @highPrice float,
 @cateId int
AS
	SELECT proId, name, price, quantity, cateId, image, description, expiredDate, createDate, status
	FROM tblProduct
	where name like '%' + @name + '%' and price >= @lowPrice and price <= @highPrice 
	and cateId = @cateId and quantity > 0 and expiredDate > GETDATE() and status like 'Active'
	ORDER BY createDate desc 
	OFFSET (@PageNumber-1)*@RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;

	select * from tblProduct



GO
/****** Object:  StoredProcedure [dbo].[getProFromEmpAcceptCate]    Script Date: 10/18/2020 3:39:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[getProFromEmpAcceptCate] 
 @PageNumber int,
 @RowsOfPage int,
 @name varchar(100),
 @lowPrice float,
 @highPrice float
AS
	SELECT proId, name, price, quantity, cateId, image, description, expiredDate, createDate, status
	FROM tblProduct
	where name like '%' + @name + '%' and price >= @lowPrice and price <= @highPrice 
	 and quantity > 0 and expiredDate > GETDATE() and status like 'Active'
	ORDER BY createDate desc 
	OFFSET (@PageNumber-1)*@RowsOfPage ROWS
	FETCH NEXT @RowsOfPage ROWS ONLY;

	select * from tblProduct
GO
