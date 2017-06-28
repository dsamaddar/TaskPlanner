

Create proc spGetAllPrimaryRep
as
begin

	Select Distinct CD.PrimarySupportRep,EI.EmployeeName 
	from tblChaseDefinition CD Left Join tblEmployeeInfo EI On CD.PrimarySupportRep=EI.EmployeeID
	Where CD.PrimarySupportRep is not null And CD.IsActive=1

end

GO

alter proc spGetAllChasesByPrimaryRep
@PrimarySupportRep nvarchar(50)
as
begin
	Select ChaseDefinitionID,ChaseName,isnull(PrimarySupportRep,'N\A') as 'PrimarySupportRep',Isnull(ChaseInstruction,'') as 'ChaseInstruction' 
	from tblChaseDefinition Where isnull(PrimarySupportRep,'N\A') = @PrimarySupportRep And IsActive=1
end

-- exec spGetAllChasesByPrimaryRep 'N\A'

GO

alter proc spChngSupRep
@ChaseDefinitionID nvarchar(50),
@PrimarySupportRep nvarchar(50),
@ChaseInstruction nvarchar(500)
as
begin

	if @PrimarySupportRep = 'N\A'
		Set @PrimarySupportRep = null

	Update tblChaseDefinition Set ChaseInstruction=@ChaseInstruction,PrimarySupportRep=@PrimarySupportRep
	Where ChaseDefinitionID=@ChaseDefinitionID

end
