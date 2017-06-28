
-- drop table tblMenu
create table tblMenu(
MenuID nvarchar(50) primary key,
MenuName nvarchar(200) unique(MenuName),
MenuGroupID nvarchar(50),
ViewOrder int
);

GO

-- Select * from tblMenu

-- *********************************** Administration Menu ***********************************************
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('Administration','Administration','Administration',0)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('EmpInfo','Employee Information','Administration',1)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('FacilityType','Facility Type','Administration',2)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('ChaseDef','Chase Definition','Administration',3)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('CatSettings','Category Settings','Administration',4)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('PrioritySett','Priority Settings','Administration',5)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MngULCBranch','Manage ULC Branch','Administration',6)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('ChaseCtrlStructure','Chase Control Structure','Administration',7)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MasterRptTool','Master Report Tool','Administration',8)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('WebAdmin','Web Administration','Administration',9)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('RoleManagement','Role Management','Administration',10)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('RoleWiseMenu','Role Wise Menu','Administration',11)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('UsrWiseRole','User Wise Role','Administration',12)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MngHolidays','Manage Holidays','Administration',13)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MngWeekDays','Manage WeekDays','Administration',14)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('chngSupRep','Change Primary Support Rep','Administration',15)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('AddNewlyAddEmp','Add Newly Added Emp','Administration',16)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('EmpSync','Emp. Sync','Administration',17)

-- *********************************** Administration Menu Ends ***********************************************

-- *********************************** Voice Data Colleciton Menu ***********************************************
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('VoiceDataColl','Voice Data Collection','VoiceData',20)
-- *********************************** Voice Data Colleciton Menu Ends ***********************************************

-- *********************************** Generate Chase Menu ***********************************************
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('GenerateChase','Generate Chase','GenerateChase',30)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('GenerateChaseCSFDF','Generate Chase CSF/DF','GenerateChase',31)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('GenGenerateChase','Gen. Generate Chase','GenerateChase',32)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('EditChase','Edit Chase','GenerateChase',33)
-- *********************************** Generate Chase Menu Ends ***********************************************

-- *********************************** User Wise Chase Menu ***********************************************
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('AllChases','All Chases','UserWiseChase',40)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('UsrWiseChase','User Wise Chase','UserWiseChase',41)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('AssignedChase','Assigned Chase','UserWiseChase',42)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('PerformedChase','Performed Chase','UserWiseChase',43)
-- *********************************** User Wise Chase Menu Ends ***********************************************

-- *********************************** Reports Menu ***********************************************
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('Reports','Reports','Reports',50)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('ChaserReporting','Chaser Reporting','Reports',51)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('GlobalView','Global View','Reports',52)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('GenerateReport','Generate Report','Reports',53)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('ReqLogView','Request Log View','Reports',54)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('CatWiseView','Category Wise View','Reports',55)


-- *********************************** Reports Menu Ends ***********************************************

-- *********************************** Reports Market Info *********************************************
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('MktInfo','Market Info','MarketInfo',60)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('PrimaryRating','Primary Rating','MarketInfo',61)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('SecRating','Secondary Rating','MarketInfo',62)
Insert into tblMenu(MenuID,MenuName,MenuGroupID,ViewOrder)Values('AllMktInfo','All Market Info','MarketInfo',63)

-- *********************************** Reports Market Info Ends ****************************************
GO

Create proc spGetMenuListByGroup
@MenuGroupID nvarchar(50)
as
begin
	Select MenuID,MenuName from tblMenu
	Where MenuGroupID=@MenuGroupID
	Order by ViewOrder
end

GO

Create proc spGetMenuGroupList
as
begin
	Select Distinct MenuGroupID from tblMenu Order by MenuGroupID
end


GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentRoleID',0)


GO

-- drop table tblRole
Create table tblRole(
RoleID nvarchar(50) primary key,
RoleName nvarchar(50),
isActive bit default 1,
MenuIDs nvarchar(4000),
ActivityIDs nvarchar(500),
CreatedBy nvarchar(50),
CreatedDate datetime default getdate(),
LastUpdatedBy nvarchar(50),
LastUpdatedDate datetime
);

-- Select * from tblRole

GO

-- drop proc spGetRoleList
Create proc spGetRoleList
as
begin
	Select Distinct RoleID,RoleName from tblRole Where isActive=1
	Order by RoleName
end

-- exec spGetRoleList

Go

alter proc spGetRoleWiseMenuIDs
@RoleID nvarchar(50)
as
begin
	Select isnull(MenuIDs,'') as 'MenuIDs' from tblRole Where RoleID=@RoleID
end

-- Select * from tblRole

GO

-- drop proc spInsertRole
Create proc spInsertRole
@RoleName nvarchar(50),
@isActive bit,
@CreatedBy nvarchar(50)
as
begin
	Declare @RoleID nvarchar(50)
	Declare @CurrentRoleID numeric(18,0)
	Declare @RoleIDPrefix as nvarchar(5)

	set @RoleIDPrefix='ROLE-'

begin tran

	select @CurrentRoleID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentRoleID'
	
	set @CurrentRoleID=isnull(@CurrentRoleID,0)+1
	Select @RoleID=dbo.generateID(@RoleIDPrefix,@CurrentRoleID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblRole(RoleID,RoleName,isActive,CreatedBy)Values(@RoleID,@RoleName,@isActive,@CreatedBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentRoleID where PropertyName='CurrentRoleID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spUpdateRole
Create proc spUpdateRole
@RoleID nvarchar(50),
@RoleName nvarchar(50),
@isActive bit,
@LastUpdatedBy nvarchar(50)
as
begin
	Update tblRole Set RoleName=@RoleName,isActive=@isActive,LastUpdatedBy=@LastUpdatedBy,LastUpdatedDate=getdate()
	Where RoleID=@RoleID
end

GO

Create proc spUpdateRolePermission
@RoleID nvarchar(50),
@MenuIDList nvarchar(4000),
@LastUpdatedBy nvarchar(50)
as
begin
	Update tblRole Set MenuIDs=@MenuIDList,LastUpdatedBy=@LastUpdatedBy,LastUpdatedDate=getdate()
	Where RoleID=@RoleID
end

Go

Create proc spGetDetailsRoleList
as
begin
	Select RoleID,RoleName,isActive=Case isActive When 1 Then 'YES' Else 'NO' End,
	CreatedBy,Convert(nvarchar,CreatedDate,106) as 'CreatedDate'
	from tblRole Order by RoleName
end

-- exec spGetDetailsRoleList

GO


insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentUserWiseRoleID',0)

GO

-- drop table tblUserWiseRole
Create table tblUserWiseRole(
UserWiseRoleID nvarchar(50) primary key,
UniqueUserID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
RoleID nvarchar(50) foreign key references tblRole(RoleID),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate Datetime default getdate()
);

Go

-- drop proc spShowUserWiseRole
Create proc spShowUserWiseRole
@UniqueUserID nvarchar(50)
as
begin
	Select UWR.UserWiseRoleID,R.RoleID,R.RoleName from tblUserWiseRole UWR Left Join tblRole R On UWR.RoleID=R.RoleID
	Where UWR.IsActive=1 And UWR.UniqueUserID=@UniqueUserID
end

GO

-- drop proc spGetUserPermission
Create proc spGetUserPermission
@UniqueUserID nvarchar(50)
as
begin
	Declare @MenuIDs as nvarchar(4000)
	Set @MenuIDs = ''
	Select @MenuIDs = @MenuIDs + isnull(R.MenuIDs,'') from tblUserWiseRole UWR Left Join tblRole R On UWR.RoleID=R.RoleID
	Where UWR.IsActive=1 And UWR.UniqueUserID=@UniqueUserID

	Select @MenuIDs as 'MenuIDs'
end

-- exec spGetUserPermission 'USR-00000002'

GO

-- drop function fnGetUserPermission
Create function fnGetUserPermission(@UniqueUserID nvarchar(50))
returns nvarchar(4000)
as
begin
	Declare @MenuIDs as nvarchar(4000)
	Set @MenuIDs = ''
	Select @MenuIDs = @MenuIDs + isnull(R.MenuIDs,'') from tblUserWiseRole UWR Left Join tblRole R On UWR.RoleID=R.RoleID
	Where UWR.IsActive=1 And UWR.UniqueUserID=@UniqueUserID
	
	return isnull(@MenuIDs,'')
end

-- select dbo.fnGetUserPermission('USR-00000002')


GO

-- drop proc spInActiveUsrPermission
Create proc spInActiveUsrPermission
@UserWiseRoleID nvarchar(50)
as
begin
	Update tblUserWiseRole Set IsActive=0
	Where UserWiseRoleID=@UserWiseRoleID
end


GO

-- drop proc spInsertUserWiseRole
Create proc spInsertUserWiseRole
@UniqueUserID nvarchar(50),
@RoleID nvarchar(50),
@EntryBy nvarchar(50)
as
begin
	Declare @UserWiseRoleID nvarchar(50)
	Declare @CurrentUserWiseRoleID numeric(18,0)
	Declare @UserWiseRoleIDPrefix as nvarchar(7)

	set @UserWiseRoleIDPrefix='USR-RL-'

begin tran

	select @CurrentUserWiseRoleID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentUserWiseRoleID'
	
	set @CurrentUserWiseRoleID=isnull(@CurrentUserWiseRoleID,0)+1
	Select @UserWiseRoleID=dbo.generateID(@UserWiseRoleIDPrefix,@CurrentUserWiseRoleID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblUserWiseRole(UserWiseRoleID,UniqueUserID,RoleID,EntryBy)
	Values(@UserWiseRoleID,@UniqueUserID,@RoleID,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentUserWiseRoleID where PropertyName='CurrentUserWiseRoleID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

Go


