
exec spRptGeneratedChase 'N\A','N\A','N\A','N\A','N\A','N\A'

alter proc spRptGeneratedChase
@CategoryID nvarchar(50),
@SubCategoryID nvarchar(50),
@ItemID nvarchar(50),
@ChaseStatus nvarchar(50),
@PriorityID nvarchar(50),
@ULCBranchID nvarchar(50)
as
begin

	Declare @PriorityIDParam as nvarchar(50) Set @PriorityIDParam = ''
	Declare @ULCBranchIDParam as nvarchar(50) Set @ULCBranchIDParam = ''
	Declare @ChaseStatusParam as nvarchar(50) Set @ChaseStatusParam = ''
	Declare @CategoryIDParam as nvarchar(50) Set @CategoryIDParam= ''
	Declare @SubCategoryIDParam as nvarchar(50) Set @SubCategoryIDParam = ''
	Declare @ItemIDParam as nvarchar(50) Set @ItemIDParam = ''

	if @CategoryID = 'N\A'
		Set @CategoryIDParam = '%'
	else
		Set @CategoryIDParam = '%'+ @CategoryID +'%'

	if @SubCategoryID = 'N\A'
		Set @SubCategoryIDParam = '%'
	else
		Set @SubCategoryIDParam = '%'+ @SubCategoryID +'%'

	if @ItemID = 'N\A'
		Set @ItemIDParam = '%'
	else
		Set @ItemIDParam = '%'+ @ItemID +'%'

	if @ChaseStatus = 'N\A'
		Set @ChaseStatusParam = '%'
	else
		Set @ChaseStatusParam = '%'+ @ChaseStatus +'%'

	if @PriorityID='N\A'
		Set @PriorityIDParam = '%'
	else
		Set @PriorityIDParam = '%'+ @PriorityID +'%'

	if @ULCBranchID = 'N\A'
		Set @ULCBranchIDParam = '%'
	else
		Set @ULCBranchIDParam = '%'+ @ULCBranchID +'%'

	Select GC.GeneratedChaseID,
	(Select CategoryName from tblCategory C Where C.CategoryID=CD.CategoryID) as 'Category',
	(Select SubCategory from tblSubCategory SC Where SC.SubCategoryID=CD.SubCategoryID) as 'SubCategory',
	(Select ItemName from tblItems I Where I.ItemID=CD.ItemID) as 'Item',
	CD.ChaseName,dbo.fnGetEmpNameByID(GC.InitiatorID) as 'Initiator',
	dbo.fnGetEmpNameByID(GC.ContactPersonID) as 'ContactPerson',
	GC.InitiatorRemarks,GC.InitiationDate,
	dbo.fnGetLatestChaseStatus( GC.GeneratedChaseID) as 'ChaseStatus',
	dbo.fnGetEmpNameByID(GC.AssignedToID) as 'AssignedTo',
	dbo.fnGetChaseInputValuesDesc(GC.GeneratedChaseID) as 'Description'
	from tblGeneratedChase GC left Join tblChaseDefinition CD On GC.ChaseDefinitionID=CD.ChaseDefinitionID
	
	Where ParentChaseID is null And GC.PriorityID like @PriorityIDParam
	And (CD.CategoryID like @CategoryIDParam or CD.CategoryID is null)
	And (CD.SubCategoryID like @SubCategoryIDParam or CD.SubCategoryID is null )
	And (CD.ItemID like @ItemIDParam or CD.ItemID is null)
	And GC.ULCBranchID like @ULCBranchIDParam
	And GC.ChaseStatus like @ChaseStatusParam
	order by GC.InitiationDate

end

GO

alter function fnGetLatestChaseStatus(@GeneratedChaseID as nvarchar(50))
returns nvarchar(50)
as
begin
	Declare @ChaseStatus as nvarchar(50) Set @ChaseStatus =''
	SElect top 1 @ChaseStatus=ChaseStatus from tblGeneratedChase Where MasterChaseID=@GeneratedChaseID
	order by InitiationDate desc,TerminationDate desc

	return @ChaseStatus
end

GO


--drop function fnGetEmpNameByID
Create function fnGetEmpNameByID(@EmployeeID nvarchar(50))
returns nvarchar(200)
as
begin

	Declare @EmpName as nvarchar(50) Set @EmpName = ''

	Select @EmpName=isnull(EmployeeName,'N\A') from tblEmployeeInfo Where EmployeeID=@EmployeeID

	return isnull(@EmpName,'N\A')

end

Select dbo.fnGetEmpNameByID('')

GO

Create proc spGetDataForGraphicalView
@GeneratedChaseID nvarchar(50)
as
begin

	
	Declare @ParentChaseID as nvarchar(50) Set @ParentChaseID = ''
	Declare @InterimID as nvarchar(50) Set @InterimID = ''
	Declare @ChildID as nvarchar(50) Set @ChildID = ''
	
	Declare @ChaseHistory table(
	SLNo int identity(1,1),
	InitiatorName nvarchar(200),
	InitiationDate datetime,
	InitiatorRemarks nvarchar(500),
	AssignedTo nvarchar(200),
	Remarks nvarchar(500),
	IsTerminated nvarchar(500),
	TimeTaken int,
	ChaseProgress nvarchar(50),
	ChaseStatus nvarchar(50)
	);

	Insert into @ChaseHistory(InitiatorName,InitiationDate,InitiatorRemarks,
	AssignedTo,Remarks,IsTerminated,TimeTaken,ChaseProgress,ChaseStatus)
	Select EI.EmployeeName,	Convert(nvarchar,InitiationDate,100),InitiatorRemarks,
	(SElect EmployeeName from tblEmployeeInfo E Where E.EmployeeID= GC.AssignedToID),
	isnull(Remarks,'N\A'),Case IsTerminated When 1 Then 'YES' + ' [On: ' + Convert(nvarchar,TerminationDate,100) + ' ] ' Else 'NO' End,
	dbo.fnGetTimeTakenInChase(GC.GeneratedChaseID),
	isnull(ChaseProgress,'N\A'),isnull(ChaseStatus,'N\A')
	from tblGeneratedChase GC left Join tblEmployeeInfo EI On GC.InitiatorID=EI.EmployeeID
	Where GeneratedChaseID = @GeneratedChaseID

	Select @ParentChaseID=isnull(ParentChaseID,'N\A') from tblGeneratedChase Where GeneratedChaseID=@GeneratedChaseID

	if @ParentChaseID = 'N\A' And  (Select Count(*) from tblGeneratedChase Where ParentChaseID=@GeneratedChaseID) > 0
	begin
		Set @ParentChaseID = @GeneratedChaseID
		While(1=1)
		begin
			If exists(Select * from tblGeneratedChase Where ParentChaseID=@ParentChaseID)
			begin
				
				Select @InterimID=GeneratedChaseID from tblGeneratedChase Where ParentChaseID=@ParentChaseID

				Insert into @ChaseHistory(InitiatorName,InitiationDate,InitiatorRemarks,
				AssignedTo,Remarks,IsTerminated,TimeTaken,ChaseProgress,ChaseStatus)
				Select EI.EmployeeName,Convert(nvarchar,InitiationDate,100),InitiatorRemarks,
				(SElect EmployeeName from tblEmployeeInfo E Where E.EmployeeID= GC.AssignedToID),
				isnull(Remarks,'N\A'),
				Case IsTerminated When 1 Then 'YES' + ' [On: ' + Convert(nvarchar,TerminationDate,100) + ' ] ' Else 'NO' End,
					dbo.fnGetTimeTakenInChase(GC.GeneratedChaseID),
				isnull(ChaseProgress,'N\A'),isnull(ChaseStatus,'N\A')
				from tblGeneratedChase GC left Join tblEmployeeInfo EI On GC.InitiatorID=EI.EmployeeID
				Where GeneratedChaseID = @InterimID

				Set @ParentChaseID = @InterimID
				Set @InterimID = ''
			end
			else
				break
		end
	end
	
	
	Select InitiatorName,TimeTaken from @ChaseHistory

end


GO