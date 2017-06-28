
GO

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentControlListID',0)

GO

-- drop table tblControlList
Create table tblControlList(
ControlListID nvarchar(50) primary key,
ChaseDefinitionID nvarchar(50) foreign key references tblChaseDefinition(ChaseDefinitionID),
ControlIndex int,
ControlID nvarchar(50),
ControlLabelInfo nvarchar(200),
ControlValue nvarchar(200),
ControlType nvarchar(50),
IsGroupControl bit default 0,
GroupControlLabelInfo nvarchar(200),
GroupControlID nvarchar(50),
DataType nvarchar(50),
DataSource nvarchar(500),
DataPresentationForm int,
ViewOrder int,
ReportingHead nvarchar(200),
ValueSelectionType nvarchar(50),
IsActive bit default 0,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO


alter proc spUpdateControlList
@ControlListID nvarchar(50),
@ChaseDefinitionID nvarchar(50),
@ControlIndex int,
@ControlID nvarchar(50),
@ControlLabelInfo nvarchar(200),
@ControlValue nvarchar(200),
@ControlType nvarchar(50),
@IsGroupControl bit,
@GroupControlLabelInfo nvarchar(200),
@GroupControlID nvarchar(50),
@DataType nvarchar(50),
@DataSource nvarchar(500),
@DataPresentationForm int,
@ViewOrder int,
@ReportingHead nvarchar(200),
@ValueSelectionType nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	
begin tran
	
	Update tblControlList Set ChaseDefinitionID=@ChaseDefinitionID,ControlIndex=@ControlIndex,ControlID=@ControlID,
	ControlLabelInfo=@ControlLabelInfo,ControlValue=@ControlValue,ControlType=@ControlType,IsGroupControl=@IsGroupControl,GroupControlLabelInfo=@GroupControlLabelInfo,
	GroupControlID=@GroupControlID,DataType=@DataType,DataSource=@DataSource,DataPresentationForm=@DataPresentationForm,ViewOrder=@ViewOrder,
	ReportingHead=@ReportingHead,IsActive=@IsActive,ValueSelectionType=@ValueSelectionType
	Where ControlListID=@ControlListID

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

alter proc spGetAllControlListByChase
@ChaseDefinitionID nvarchar(50)
as
begin
	Select ControlListID,ControlIndex,ControlID,ControlLabelInfo,ControlValue,ControlType,
	Case IsGroupControl When 1 Then 'YES' Else 'NO' end as 'IsGroupControl',
	GroupControlLabelInfo,GroupControlID,DataType,DataSource,DataPresentationForm,isnull(ViewOrder,0) as 'ViewOrder',
	ReportingHead,ValueSelectionType,
	Case IsActive When 1 Then 'YES' Else 'NO' end as 'IsActive',
	EntryBy
	from tblControlList Where ChaseDefinitionID=@ChaseDefinitionID
	order by ControlType,GroupControlID
end

exec spGetAllControlListByChase 'CD-00000001'

GO

alter proc spInsertControlList
@ChaseDefinitionID nvarchar(50),
@ControlIndex int,
@ControlID nvarchar(50),
@ControlLabelInfo nvarchar(200),
@ControlValue nvarchar(200),
@ControlType nvarchar(50),
@IsGroupControl bit,
@GroupControlLabelInfo nvarchar(200),
@GroupControlID nvarchar(50),
@DataType nvarchar(50),
@DataSource nvarchar(500),
@DataPresentationForm int,
@ViewOrder int,
@ReportingHead nvarchar(200),
@ValueSelectionType nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @ControlListID nvarchar(50)
	Declare @CurrentControlListID numeric(18,0)
	Declare @ControlListIDPrefix as nvarchar(5)

	set @ControlListIDPrefix='CTRL-'

begin tran
	
	select @CurrentControlListID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentControlListID'
	
	set @CurrentControlListID=isnull(@CurrentControlListID,0)+1
	Select @ControlListID=dbo.generateID(@ControlListIDPrefix,@CurrentControlListID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblControlList(ControlListID,ControlIndex,ChaseDefinitionID,ControlID,ControlLabelInfo,ControlValue,ControlType,IsGroupControl,GroupControlLabelInfo,
	GroupControlID,DataType,DataSource,DataPresentationForm,ViewOrder,ReportingHead,ValueSelectionType,IsActive,EntryBy)
	Values(@ControlListID,@ControlIndex,@ChaseDefinitionID,@ControlID,@ControlLabelInfo,@ControlValue,@ControlType,@IsGroupControl,@GroupControlLabelInfo,
	@GroupControlID,@DataType,@DataSource,@DataPresentationForm,@ViewOrder,@ReportingHead,@ValueSelectionType,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentControlListID where PropertyName='CurrentControlListID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- drop proc spGetControlInfoByIDAndType
alter proc spGetControlInfoByIDAndType
@ChaseDefinitionID nvarchar(50),
@ControlType nvarchar(50)
as
begin
	Select ControlType,ControlIndex,ControlID,ControlLabelInfo,ControlValue,
	Case IsGroupControl When 1 Then 'YES' Else 'NO' end as 'IsGroupControl',
	GroupControlLabelInfo,GroupControlID,isnull(DataPresentationForm,0) as 'DataPresentationForm',
	(Select Count(distinct ControlID) from tblControlList CL Where CL.ChaseDefinitionID=@ChaseDefinitionID And CL.ControlType=@ControlType And CL.IsActive=1 And CL.ControlID<> '' ) as 'ControlIDCount',
	(Select Count(distinct GroupControlID) from tblControlList CL Where CL.ChaseDefinitionID=@ChaseDefinitionID And CL.ControlType=@ControlType And CL.IsActive=1 and CL.GroupControlID <> '' ) as 'GroupControlIDCount'
	from tblControlList Where ChaseDefinitionID=@ChaseDefinitionID And ControlType=@ControlType
	And IsActive=1 
	order by GroupControlID,ControlIndex
end

exec spGetControlInfoByIDAndType 'CD-00000001','TextBox'

GO

alter proc spGetNoOfCtrlSetByChaseDefID
@ChaseDefinitionID nvarchar(50)
as
begin
	
	Declare @ControlIDCount as int Set @ControlIDCount = 0
	Declare @GroupControlIDCount as int Set @GroupControlIDCount = 0

	Select @ControlIDCount = @ControlIDCount + count(distinct ControlID) from tblControlList 
	Where ChaseDefinitionID=@ChaseDefinitionID And ControlID <> ''

	Select @GroupControlIDCount = @GroupControlIDCount + count(distinct GroupControlID) from tblControlList 
	Where ChaseDefinitionID=@ChaseDefinitionID And GroupControlID <> ''

	Select @ControlIDCount as 'ControlIDCount',@GroupControlIDCount as 'GroupControlIDCount'
	
end

exec spGetNoOfCtrlSetByChaseDefID 'CD-00000001'

GO

alter proc spGetAllCtrlIDByChaseDefID
@ChaseDefinitionID nvarchar(50)
as
begin
	
	Declare @tblCtrl table(
	ControlID nvarchar(200),
	ControlType nvarchar(50),
	ViewOrder int
	)

	Insert into @tblCtrl(ControlID,ControlType,ViewOrder)
	Select Case IsGroupControl When 1 Then GroupControlID else ControlID end,ControlType,ViewOrder
	from tblControlList Where ChaseDefinitionID= @ChaseDefinitionID And IsActive=1
	order by viewOrder

	Select distinct ControlID,ControlType,ViewOrder from @tblCtrl order by ViewOrder

end

exec spGetAllCtrlIDByChaseDefID  'CD-00000001'

GO

alter proc spGetCtrlDetailsByChaseDefIDAndCtrlID
@ChaseDefinitionID nvarchar(50),
@ControlID nvarchar(50)
as
begin
	
	if exists (Select * from tblControlList Where ChaseDefinitionID= @ChaseDefinitionID And IsActive=1 And ControlID=@ControlID)
	begin
		Select ControlType,ControlIndex,ControlID,ControlLabelInfo,ControlValue,
		Case IsGroupControl When 1 Then 'YES' Else 'NO' end as 'IsGroupControl',
		GroupControlLabelInfo,GroupControlID,isnull(DataPresentationForm,0) as 'DataPresentationForm',DataType,ValueSelectionType
		from tblControlList Where ChaseDefinitionID= @ChaseDefinitionID And IsActive=1 And ControlID=@ControlID
		And IsActive=1 
		order by ControlID,ControlIndex
	end
	else
	begin
		Select ControlType,ControlIndex,ControlID,ControlLabelInfo,ControlValue,
		Case IsGroupControl When 1 Then 'YES' Else 'NO' end as 'IsGroupControl',
		GroupControlLabelInfo,GroupControlID,isnull(DataPresentationForm,0) as 'DataPresentationForm',DataType,ValueSelectionType
		from tblControlList Where ChaseDefinitionID= @ChaseDefinitionID And IsActive=1 And GroupControlID=@ControlID
		And IsActive=1 
		order by GroupControlID,ControlIndex
	end

end

exec spGetCtrlDetailsByChaseDefIDAndCtrlID  'CD-00000001','rdbtnDrgald02'

GO
-- drop table tblChaseGroupCtrls
Create table tblChaseGroupCtrls(
ChaseGroupCtrlID nvarchar(50) primary key,
ChaseDefinitionID nvarchar(50) foreign key references tblChaseDefinition(ChaseDefinitionID),
CtrlType nvarchar(50),
GroupName nvarchar(200),
GroupCode nvarchar(50) unique(GroupCode),
IsActive bit default 0,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentChaseGroupCtrlID',0)

GO

alter proc spGetChaseGroupCtrlsByCDID
@ChaseDefinitionID nvarchar(50)
as
begin
	Select ChaseGroupCtrlID,CtrlType,GroupName,GroupCode,
	Case IsActive When 1 Then 'YES' Else 'NO' End as 'IsActive',
	EntryBy  from tblChaseGroupCtrls
	Where ChaseDefinitionID=@ChaseDefinitionID
end

-- exec spGetChaseGroupCtrlsByCDID 

GO

Create proc spGetActiveChaseGroupCtrls
@ChaseDefinitionID nvarchar(50)
as
begin
	Select GroupName,GroupCode from tblChaseGroupCtrls Where ChaseDefinitionID=@ChaseDefinitionID
	And IsActive=1
end

GO

Create proc spGetActiveChaseGroupCtrlsByType
@ChaseDefinitionID nvarchar(50),
@CtrlType nvarchar(50)
as
begin
	Select GroupName,GroupCode from tblChaseGroupCtrls Where ChaseDefinitionID=@ChaseDefinitionID
	and CtrlType=@CtrlType And IsActive=1
end

GO

alter proc spInsertChaseGroupCtrls
@ChaseDefinitionID nvarchar(50),
@CtrlType nvarchar(50),
@GroupName nvarchar(200),
@GroupCode nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @ChaseGroupCtrlID nvarchar(50)
	Declare @CurrentChaseGroupCtrlID numeric(18,0)
	Declare @ChaseGroupCtrlIDPrefix as nvarchar(7)

	set @ChaseGroupCtrlIDPrefix='G-CTRL-'

begin tran
	
	select @CurrentChaseGroupCtrlID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentChaseGroupCtrlID'
	
	set @CurrentChaseGroupCtrlID=isnull(@CurrentChaseGroupCtrlID,0)+1
	Select @ChaseGroupCtrlID=dbo.generateID(@ChaseGroupCtrlIDPrefix,@CurrentChaseGroupCtrlID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblChaseGroupCtrls(ChaseGroupCtrlID,ChaseDefinitionID,CtrlType,GroupName,GroupCode,IsActive,EntryBy)
	Values(@ChaseGroupCtrlID,@ChaseDefinitionID,@CtrlType,@GroupName,@GroupCode,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentChaseGroupCtrlID where PropertyName='CurrentChaseGroupCtrlID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

alter proc spUpdateChaseGroupCtrls
@ChaseGroupCtrlID nvarchar(50),
@CtrlType nvarchar(50),
@ChaseDefinitionID nvarchar(50),
@GroupName nvarchar(200),
@GroupCode nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Update tblChaseGroupCtrls Set ChaseDefinitionID=@ChaseDefinitionID,CtrlType=@CtrlType,GroupName=@GroupName,
	GroupCode=@GroupCode,IsActive=@IsActive,EntryBy=@EntryBy
	Where ChaseGroupCtrlID=@ChaseGroupCtrlID
end

GO

alter proc spGetControlCounter
@ChaseDefinitionID nvarchar(50),
@ControlID nvarchar(50),
@IsGroupControl bit
as
begin

	Declare @Counter as int Set @Counter = 0
	
	if @IsGroupControl = 1
	begin
		Select @Counter = count(distinct GroupControlID) from tblControlList Where ChaseDefinitionID=@ChaseDefinitionID And GroupControlID like '%'+@ControlID+'%'
	end
	else
	begin
		Select @Counter = count(distinct ControlID) from tblControlList Where ChaseDefinitionID=@ChaseDefinitionID And ControlID like '%'+@ControlID+'%'
	end

	if @Counter> 0
	begin
		Set @Counter = @Counter  + 1
		Select convert(nvarchar,@Counter) as 'Suffix'
	end
	else
		Select '' as 'Suffix'

end

exec spGetControlCounter 'CD-00000001','rdbtnSelectOpt',1

Select * from tblControlList

Select * from tblControlList Where ChaseDefinitionID='CD-00000001' 
And GroupControlID='rdbtnSelectOpt'