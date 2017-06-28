
-- drop proc spGetSubordinateList
alter proc spGetSubordinateList
@CurrentSupervisor nvarchar(50)
as
begin

	Create table #EmpTbl (
	EmployeeID nvarchar(50),
	EmployeeName nvarchar(200),
	CurrentSupervisor nvarchar(50),
	Taken bit default 0
	);
	
	exec spRecursiveCallForEmp @CurrentSupervisor

	Select distinct EmployeeID,EmployeeName from #EmpTbl

	drop table #EmpTbl

end

GO

alter proc spRecursiveCallForEmp
@CurrentSupervisor nvarchar(50)
as
begin
	
	Insert into #EmpTbl(EmployeeID,EmployeeName,CurrentSupervisor)
	Select EmployeeID,EmployeeName,CurrentSupervisor from tblEmployeeInfo Where CurrentSupervisor=@CurrentSupervisor

	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
	--Declare @EmployeeName as nvarchar(200) Set @EmployeeName = ''
	--Declare @CurrentSupervisor as nvarchar(50) @Set CurrentSupervisor = ''
	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount=0

	Select @NCount=Count(*) from #EmpTbl Where Taken=0 And CurrentSupervisor = @CurrentSupervisor

	While @Count <= @NCount
	begin
		
		Select top 1 @EmployeeID=EmployeeID from #EmpTbl Where Taken=0 And CurrentSupervisor = @CurrentSupervisor

		exec spRecursiveCallForEmp @EmployeeID
		
		Update #EmpTbl Set Taken=1 Where EmployeeID=@EmployeeID
		Set @Count = @Count + 1
	end

end

-- exec spGetSubordinateList 'EMP-00000128'

GO

Create proc spGetSubordinateUsrChaseList
@CurrentSupervisor nvarchar(50)
as
begin
	Create table #EmpTbl (
	EmployeeID nvarchar(50),
	EmployeeName nvarchar(200),
	CurrentSupervisor nvarchar(50),
	Taken bit default 0
	);
	
	exec spRecursiveCallForEmp @CurrentSupervisor

	Select ChaseDefinitionID,ChaseName from tblChaseDefinition Where ChaseDefinitionID in (
	Select Distinct ChaseDefinitionID  from tblGeneratedChase Where AssignedToID in (
	Select distinct EmployeeID from #EmpTbl) 
	)
	
	drop table #EmpTbl
end

-- exec spGetSubordinateUsrChaseList 'EMP-00000005'

GO

alter proc spGetSupervisorChaseView
@CurrentSupervisor nvarchar(50),
@ChaseDefinitionID nvarchar(50),
@EmployeeID nvarchar(50),
@ChaseStatus nvarchar(50)
as
begin

	Declare @EmployeeIDParam as nvarchar(50) Set @EmployeeIDParam = ''
	Declare @ChaseDefinitionIDParam as nvarchar(50) Set @ChaseDefinitionIDParam = ''
	Declare @ChaseStatusParam as nvarchar(50) Set @ChaseStatusParam = ''

	if @EmployeeID = 'N\A'
		Set @EmployeeIDParam = '%'
	else
		Set @EmployeeIDParam = '%'+ @EmployeeID +'%'

	if @ChaseDefinitionID = 'N\A'
		Set @ChaseDefinitionIDParam = '%'
	else
		Set @ChaseDefinitionIDParam = '%'+ @ChaseDefinitionID +'%'

	if @ChaseStatus = 'N\A'
		Set @ChaseStatusParam = '%'
	else
		Set @ChaseStatusParam = '%'+ @ChaseStatus +'%'

	Create table #EmpTbl (
	EmployeeID nvarchar(50),
	EmployeeName nvarchar(200),
	CurrentSupervisor nvarchar(50),
	Taken bit default 0
	);
	
	exec spRecursiveCallForEmp @CurrentSupervisor

	Select GeneratedChaseID,MasterChaseID,Category,SubCategory,Item,ChaseName,Initiator,InitiatorRemarks,
	InitiationDate,ChaseStatus,AssignedTo,Description
	from vwAllChaseStatus Where AssignedToID in (
	Select distinct EmployeeID from #EmpTbl
	)
	And (ChaseStatus like @ChaseStatusParam or ChaseStatus is null)
	And (ChaseDefinitionID like @ChaseDefinitionIDParam or ChaseDefinitionID is null)
	And (AssignedToID like @EmployeeIDParam or AssignedToID is null)

	drop table #EmpTbl

end

-- exec spGetSupervisorChaseView 'EMP-00000007','N\A','N\A','N\A'



