
Select * from tblChaseDefinition 
Select * from tblEmployeeInfo 
Select * from tblEmployeeInfo 


Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentInterestedRepID',0)

SElect * from tblAppSettings Where PropertyName='CurrentInterestedRepID'

-- drop table tblInterestedReps
Create table tblInterestedReps(
InterestedRepID nvarchar(50) primary key,
ChaseDefinitionID nvarchar(50) foreign key references tblChaseDefinition(ChaseDefinitionID),
EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
InterestType nvarchar(50)
);

Select * from tblInterestedReps

GO

alter proc spGetInterestedRepsByChaseDefID
@ChaseDefinitionID nvarchar(50),
@InterestType nvarchar(50)
as
begin
	
	Select EI.EmployeeName as 'EmployeeName',IR.EmployeeID as 'EmployeeID' from tblInterestedReps IR Left Join tblEmployeeInfo EI 
	On IR.EmployeeID= EI.EmployeeID
	Where ChaseDefinitionID=@ChaseDefinitionID And InterestType=@InterestType  
	order by EI.EmployeeName 	
end

exec spGetInterestedRepsByChaseDefID 'CD-00000001','Representative'

GO

--exec spInsertInterestedReps 'CD-00000001','EMP-00000067'

alter proc spInsertInterestedReps
@ChaseDefinitionID nvarchar(50),
@EmployeeID nvarchar(50),
@InterestType nvarchar(50)
as
begin
	Declare @InterestedRepID nvarchar(50)
	Declare @CurrentInterestedRepID numeric(18,0)
	Declare @InterestedRepIDPrefix as nvarchar(8)

	set @InterestedRepIDPrefix='INT-REP-'

begin tran
	
	select @CurrentInterestedRepID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentInterestedRepID'
	
	set @CurrentInterestedRepID=isnull(@CurrentInterestedRepID,0)+1
	
	Select @InterestedRepID=dbo.generateID(@InterestedRepIDPrefix,@CurrentInterestedRepID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblInterestedReps(InterestedRepID,ChaseDefinitionID,EmployeeID,InterestType)
	Values(@InterestedRepID,@ChaseDefinitionID,@EmployeeID,@InterestType)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentInterestedRepID where PropertyName='CurrentInterestedRepID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

