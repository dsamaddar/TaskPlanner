

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentChaseDefinitionID',0)

GO

-- drop table tblChaseDefinition
Create table tblChaseDefinition(
ChaseDefinitionID nvarchar(50) primary key,
FacilityTypeID nvarchar(50) foreign key references tblFacilityType(FacilityTypeID),
ChaseName nvarchar(500),
ChaseShortCode nvarchar(50) unique(ChaseShortCode),
CategoryID nvarchar(50) foreign key references tblCategory(CategoryID),
SubCategoryID nvarchar(50) foreign key references tblSubCategory(SubCategoryID),
ItemID nvarchar(50) foreign key references tblItems(ItemID),
PriorityID nvarchar(50) foreign key references tblPriority(PriorityID),
IsOpenChase bit default 0,
IsActive bit default 0,
PrimarySupportRep nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
ChaseInstruction nvarchar(500),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

alter proc spGetChaseDefListAll
as
begin
	Select CD.ChaseDefinitionID,CD.FacilityTypeID,
	(Select FacilityType from tblFacilityType FT Where FT.FacilityTypeID= CD.FacilityTypeID) as 'FacilityType',
	CD.ChaseName,CD.ChaseShortCode,
	isnull(CD.CategoryID,'N\A') as 'CategoryID',
	isnull((Select C.CategoryName from tblCategory C Where C.CategoryID=CD.CategoryID),'N\A') as 'CategoryName',
	isnull(CD.SubCategoryID,'N\A') as 'SubCategoryID',
	isnull((Select SubCategory from tblSubCategory SC Where SC.SubCategoryID=CD.SubCategoryID),'N\A') as 'SubCategory',
	isnull(CD.ItemID,'N\A') as 'ItemID',
	isnull((Select ItemName from tblItems I Where I.ItemID=CD.ItemID),'N\A') as 'ItemName',
	isnull(CD.PriorityID,'N\A') as 'PriorityID',
	isnull((Select PriorityText from tblPriority P Where P.PriorityID=CD.PriorityID ) ,'N\A')as 'PriorityText',
	Case CD.IsActive When 1 Then 'YES' Else 'NO' End as 'IsActive',
	Case CD.IsOpenChase When 1 Then 'YES' Else 'NO' End as 'IsOpenChase',
	isnull(CD.PrimarySupportRep,'N\A') as 'PrimarySupportRep',
	isnull((Select EmployeeName from tblEmployeeInfo EI Where EI.EmployeeID=CD.PrimarySupportRep),'N\A') as 'PrimarySupporter',
	isnull(CD.ChaseInstruction,'') as 'ChaseInstruction',CD.EntryBy,Convert(nvarchar,CD.EntryDate,106) as 'EntryDate' 
	from  tblChaseDefinition CD
	order by CD.EntryDate desc
end

GO

-- exec spGetChaseDefListAll

Create proc spGetChaseDefListActive
as
begin
	Select ChaseDefinitionID,ChaseName from tblChaseDefinition Where IsActive=1 
	order by ChaseName
end

exec spGetChaseDefListActive

GO

alter proc spGetChaseDefListActiveByCat
@CategoryID nvarchar(50),
@SubCategoryID nvarchar(50)
as
begin

	Declare @CategoryIDParam as nvarchar(50) Set @CategoryIDParam = ''
	Declare @SubCategoryIDParam as nvarchar(50) Set @SubCategoryIDParam = ''


	if 	@CategoryID = 'N\A'
		Set @CategoryIDParam = '%'
	else
		Set @CategoryIDParam = '%'+ @CategoryID +'%'
		
	if 	@SubCategoryID = 'N\A'
		Set @SubCategoryIDParam = '%'
	else
		Set @SubCategoryIDParam = '%'+ @SubCategoryID +'%'

	Select ChaseDefinitionID,ChaseName from tblChaseDefinition Where IsActive=1 
	And CategoryID like @CategoryIDParam And (SubCategoryID like @SubCategoryIDParam or SubCategoryID is null)
	order by ChaseName

end

GO

Create proc spGetChaseDefListByFacilityType
@FacilityTypeID nvarchar(50)
as
begin
	Select ChaseDefinitionID,ChaseName from tblChaseDefinition 
	Where IsActive=1 And FacilityTypeID = @FacilityTypeID
	order by ChaseName
end

Select * from tblChaseDefinition

GO

Create proc spGetChaseShortCode
@ChaseDefinitionID nvarchar(50)
as
begin
	Select ChaseShortCode from tblChaseDefinition Where ChaseDefinitionID=@ChaseDefinitionID
end

GO

alter proc spUpdateChaseDefinition
@ChaseDefinitionID nvarchar(50),
@FacilityTypeID nvarchar(50),
@ChaseName nvarchar(500),
@ChaseShortCode nvarchar(50),
@CategoryID nvarchar(50),
@SubCategoryID nvarchar(50),
@ItemID nvarchar(50),
@PriorityID nvarchar(50),
@EmployeeList nvarchar(4000),
@InformedParties nvarchar(4000),
@DepartmentIDList nvarchar(4000),
@IsOpenChase bit,
@IsActive bit,
@PrimarySupportRep nvarchar(50),
@ChaseInstruction nvarchar(500),
@EntryBy nvarchar(50)
as
begin

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0

	Declare @EmpTbl table(
	EmployeeID nvarchar(50),
	Taken bit default 0
	)

	
	if @SubCategoryID = 'N\A'
		Set @SubCategoryID = null

	if @ItemID = 'N\A'
		Set @ItemID = null

	if @PrimarySupportRep = 'N\A'
		Set @PrimarySupportRep = null

begin tran

	Insert Into @EmpTbl(EmployeeID)
	SELECT Value 
   	FROM dbo.Split( ',', @EmployeeList ) AS s
   	ORDER BY s.[Value]
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Update tblChaseDefinition Set FacilityTypeID=@FacilityTypeID,ChaseName=@ChaseName,ChaseShortCode=@ChaseShortCode,
	CategoryID=@CategoryID,SubCategoryID=@SubCategoryID,ItemID=@ItemID,PriorityID=@PriorityID,IsActive=@IsActive,
	IsOpenChase=@IsOpenChase,PrimarySupportRep=@PrimarySupportRep,ChaseInstruction=@ChaseInstruction
	Where ChaseDefinitionID=@ChaseDefinitionID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Delete from tblInterestedReps Where ChaseDefinitionID = @ChaseDefinitionID And InterestType='Representative'

	Select @NCount = Count(*) from @EmpTbl
	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
	While @Count <= @NCount
	begin
		
		Select Top 1 @EmployeeID=EmployeeID from @EmpTbl Where Taken=0

		exec spInsertInterestedReps @ChaseDefinitionID,@EmployeeID,'Representative'
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Update @EmpTbl Set Taken=1 Where EmployeeID=@EmployeeID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Set @Count = @Count + 1
		Set @EmployeeID = ''
	end

	delete from @EmpTbl

	Insert Into @EmpTbl(EmployeeID)
	SELECT Value 
   	FROM dbo.Split( ',', @InformedParties ) AS s
   	ORDER BY s.[Value]
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Delete from tblInterestedReps Where ChaseDefinitionID = @ChaseDefinitionID And InterestType='Informed'

	Select @NCount = Count(*) from @EmpTbl
	Set @EmployeeID = ''
	Set @Count = 1
	While @Count <= @NCount
	begin
		
		Select Top 1 @EmployeeID=EmployeeID from @EmpTbl Where Taken=0

		exec spInsertInterestedReps @ChaseDefinitionID,@EmployeeID,'Informed'
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Update @EmpTbl Set Taken=1 Where EmployeeID=@EmployeeID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Set @Count = @Count + 1
		Set @EmployeeID = ''
	end

	delete from tblChaseOpenForDept where ChaseDefinitionID=@ChaseDefinitionID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	exec spInsertChaseOpenForDept @ChaseDefinitionID,@DepartmentIDList,@EntryBy
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- exec spInsertChaseDefinition 'FCT-00000001','Does the distributor receive goods against last disbursement on time?',1,'dsamaddar'

alter proc spInsertChaseDefinition
@FacilityTypeID nvarchar(50),
@ChaseName nvarchar(500),
@ChaseShortCode nvarchar(50),
@CategoryID nvarchar(50),
@SubCategoryID nvarchar(50),
@ItemID nvarchar(50),
@PriorityID nvarchar(50),
@EmployeeList nvarchar(4000),
@InformedParties nvarchar(4000),
@DepartmentIDList nvarchar(4000),
@IsOpenChase bit,
@IsActive bit,
@PrimarySupportRep nvarchar(50),
@ChaseInstruction nvarchar(500),
@EntryBy nvarchar(50)
as
begin
	Declare @ChaseDefinitionID nvarchar(50)
	Declare @CurrentChaseDefinitionID numeric(18,0)
	Declare @ChaseDefinitionIDPrefix as nvarchar(3)

	set @ChaseDefinitionIDPrefix='CD-'

	if @SubCategoryID = 'N\A'
		Set @SubCategoryID = null

	if @ItemID = 'N\A'
		Set @ItemID = null

	if @PrimarySupportRep = 'N\A'
		Set @PrimarySupportRep = null

begin tran

	Declare @EmpTbl table(
	EmployeeID nvarchar(50),
	Taken bit default 0
	)

	Insert Into @EmpTbl(EmployeeID)
	SELECT Value 
   	FROM dbo.Split( ',', @EmployeeList ) AS s
   	ORDER BY s.[Value]
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	select @CurrentChaseDefinitionID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentChaseDefinitionID'
	
	set @CurrentChaseDefinitionID=isnull(@CurrentChaseDefinitionID,0)+1
	Select @ChaseDefinitionID=dbo.generateID(@ChaseDefinitionIDPrefix,@CurrentChaseDefinitionID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblChaseDefinition(ChaseDefinitionID,FacilityTypeID,ChaseName,ChaseShortCode,CategoryID,SubCategoryID,ItemID,
	PriorityID,IsOpenChase,IsActive,PrimarySupportRep,ChaseInstruction,EntryBy)
	Values(@ChaseDefinitionID,@FacilityTypeID,@ChaseName,@ChaseShortCode,@CategoryID,@SubCategoryID,@ItemID,
	@PriorityID,@IsActive,@IsOpenChase,@PrimarySupportRep,@ChaseInstruction,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0

	Select @NCount = Count(*) from @EmpTbl
	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
	While @Count <= @NCount
	begin
		
		Select Top 1 @EmployeeID=EmployeeID from @EmpTbl Where Taken=0

		exec spInsertInterestedReps @ChaseDefinitionID,@EmployeeID,'Representative'
		
		Update @EmpTbl Set Taken=1 Where EmployeeID=@EmployeeID

		Set @Count = @Count + 1
		set @EmployeeID = ''
	end

	delete from @EmpTbl

	Insert Into @EmpTbl(EmployeeID)
	SELECT Value 
   	FROM dbo.Split( ',', @InformedParties ) AS s
   	ORDER BY s.[Value]
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Select @NCount = Count(*) from @EmpTbl
	Set @EmployeeID = ''
	Set @Count = 1
	While @Count <= @NCount
	begin
		
		Select Top 1 @EmployeeID=EmployeeID from @EmpTbl Where Taken=0

		exec spInsertInterestedReps @ChaseDefinitionID,@EmployeeID,'Informed'
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Update @EmpTbl Set Taken=1 Where EmployeeID=@EmployeeID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Set @Count = @Count + 1
		Set @EmployeeID = ''
	end

	exec spInsertChaseOpenForDept @ChaseDefinitionID,@DepartmentIDList,@EntryBy
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentChaseDefinitionID where PropertyName='CurrentChaseDefinitionID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- Create table tblChaseControlStructure

Create proc spGetPriorityByChaseDef
@ChaseDefinitionID nvarchar(50)
as
begin
	Select PriorityID from tblChaseDefinition Where ChaseDefinitionID=@ChaseDefinitionID
end

GO

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentChaseOpenForDeptID',0)

GO

Create table tblChaseOpenForDept(
ChaseOpenForDeptID nvarchar(50) primary key,
ChaseDefinitionID nvarchar(50) foreign key references tblChaseDefinition(ChaseDefinitionID),
DepartmentID nvarchar(50) foreign key references tblDepartment(DepartmentID),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

Select * from tblChaseOpenForDept

GO

alter proc spGetOpenForDeptByChaseID
@ChaseDefinitionID nvarchar(50)
as
begin

	Select DepartmentID from tblChaseOpenForDept Where ChaseDefinitionID=@ChaseDefinitionID

end
-- exec spGetOpenForDeptByChaseID 'CD-00000010'
-- Select * from tblChaseOpenForDept

GO

alter proc spInsertChaseOpenForDept
@ChaseDefinitionID nvarchar(50),
@DepartmentIDList nvarchar(1000),
@EntryBy nvarchar(50)
as
begin

	Declare @ChaseOpenForDeptID nvarchar(50)
	Declare @CurrentChaseOpenForDeptID numeric(18,0)
	Declare @ChaseOpenForDeptIDPrefix as nvarchar(5)

	set @ChaseOpenForDeptIDPrefix='COFD-'

	Declare @DeptTbl table(
	DepartmentID nvarchar(50),
	Taken bit default 0
	);

	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''
	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0

begin tran

	Insert into @DeptTbl(DepartmentID)
	Select Value from dbo.Split(',',@DepartmentIDList)

	Select @NCount=Count(*) from @DeptTbl

	select @CurrentChaseOpenForDeptID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentChaseOpenForDeptID'
	
	While @Count <= @NCount
	begin
		
		Select top 1 @DepartmentID=DepartmentID from @DeptTbl Where Taken = 0 

		set @CurrentChaseOpenForDeptID=isnull(@CurrentChaseOpenForDeptID,0)+1
		Select @ChaseOpenForDeptID=dbo.generateID(@ChaseOpenForDeptIDPrefix,@CurrentChaseOpenForDeptID,8)		
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Insert into tblChaseOpenForDept(ChaseOpenForDeptID,ChaseDefinitionID,DepartmentID,EntryBy)
		Values(@ChaseOpenForDeptID,@ChaseDefinitionID,@DepartmentID,@EntryBy)

		Update @DeptTbl Set Taken=1 Where DepartmentID=@DepartmentID
		Set @Count = @Count + 1
		Set @ChaseOpenForDeptID = ''
		Set @DepartmentID = ''
	end

	update tblAppSettings set PropertyValue=@CurrentChaseOpenForDeptID where PropertyName='CurrentChaseOpenForDeptID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

exec spInsertChaseOpenForDept '21331,qwrqeras,qwreewr'