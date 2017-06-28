

Declare @GeneratedChaseID as nvarchar(50) Set @GeneratedChaseID = 'GEN-C-00000039'
Declare @ParentChaseID as nvarchar(50) Set @ParentChaseID = ''
Declare @InterimID as nvarchar(50) Set @InterimID = ''
Declare @ChildID as nvarchar(50) Set @ChildID = ''
Declare @SQLChase as nvarchar(1000) Set @SQLChase = ''

Declare @i as int Set @i=0
Declare @j as int Set @j=0
Declare @k as int Set @k=0
Declare @l as int Set @l=0
Declare @m as int Set @m=0


Declare @VarInitiatorName as nvarchar(50) Set @VarInitiatorName = ''
Declare @VarInitiationDate as nvarchar(50) Set @VarInitiationDate = ''
Declare @VarInitiatorRemarks as nvarchar(50) Set @VarInitiatorRemarks = ''
Declare @VarTimeTaken as nvarchar(50) Set @VarTimeTaken = ''

Declare @InitiatorName as nvarchar(500) Set @InitiatorName = ''
Declare @InitiationDate as nvarchar(50) Set @InitiationDate = ''
Declare @InitiatorRemarks as nvarchar(500) Set @InitiatorRemarks = ''
Declare @TimeTaken as nvarchar(50) Set @TimeTaken = ''

Create table #MyTblChaseInfo (
GeneratedChaseID nvarchar(50)
);

alter table #MyTblChaseInfo Add InitiatorName nvarchar(500)
alter table #MyTblChaseInfo Add InitiationDate nvarchar(50)
alter table #MyTblChaseInfo Add InitiatorRemarks nvarchar(500)
alter table #MyTblChaseInfo Add TimeTaken int

---------------------------------------

Insert into #MyTblChaseInfo(GeneratedChaseID,InitiatorName,InitiationDate,InitiatorRemarks,TimeTaken)
Select GC.GeneratedChaseID, EI.EmployeeName,	Convert(nvarchar,InitiationDate,100),InitiatorRemarks,dbo.fnGetTimeTakenInChase(GC.GeneratedChaseID)
from tblGeneratedChase GC left Join tblEmployeeInfo EI On GC.InitiatorID=EI.EmployeeID
Where GeneratedChaseID = @GeneratedChaseID

-------------------------------------------
While @m < 5
begin

	Set @VarInitiatorName = 'Initiator' + convert(nvarchar,@i)
	Set @VarInitiationDate = 'InitiationDate'+ convert(nvarchar,@j)
	Set @VarInitiatorRemarks = 'InitiationRemarks'+ convert(nvarchar,@k)
	Set @VarTimeTaken = 'TimeTaken' + convert(nvarchar,@l)

	Set @SQLChase = 'alter table #MyTblChaseInfo Add '+Convert(nvarchar,@VarInitiatorName)+' nvarchar(500);'
	exec (@SQLChase)

	Set @SQLChase = 'alter table #MyTblChaseInfo Add '+Convert(nvarchar,@VarInitiationDate)+' nvarchar(50);'
	exec (@SQLChase)

	Set @SQLChase = 'alter table #MyTblChaseInfo Add '+Convert(nvarchar,@VarInitiatorRemarks)+' nvarchar(500);'
	exec (@SQLChase)

	Set @SQLChase = 'alter table #MyTblChaseInfo Add '+Convert(nvarchar,@VarTimeTaken)+' nvarchar(50);'
	exec (@SQLChase)

	Set @m = @m + 1
	Set @i = @i + 1
	Set @j = @j + 1
	Set @k = @k + 1
	Set @l = @l + 1
end


Set @i=0
Set @j=0
Set @k=0
Set @l=0

Select @ParentChaseID=isnull(ParentChaseID,'N\A') from tblGeneratedChase Where GeneratedChaseID=@GeneratedChaseID

	if @ParentChaseID = 'N\A' And  (Select Count(*) from tblGeneratedChase Where ParentChaseID=@GeneratedChaseID) > 0
	begin
		Set @ParentChaseID = @GeneratedChaseID
		While(1=1)
		begin
			If exists(Select * from tblGeneratedChase Where ParentChaseID=@ParentChaseID)
			begin

				Set @VarInitiatorName = 'Initiator' + convert(nvarchar,@i)
				Set @VarInitiationDate = 'InitiationDate'+ convert(nvarchar,@j)
				Set @VarInitiatorRemarks = 'InitiationRemarks'+ convert(nvarchar,@k)
				Set @VarTimeTaken = 'TimeTaken' + convert(nvarchar,@l)

				Select @InterimID=GeneratedChaseID from tblGeneratedChase Where ParentChaseID=@ParentChaseID

				Select @InitiatorName=EI.EmployeeName
				,@InitiationDate = InitiationDate,@InitiatorRemarks=InitiatorRemarks
				,@TimeTaken =	Convert(nvarchar,dbo.fnGetTimeTakenInChase(GC.GeneratedChaseID))
				from tblGeneratedChase GC left Join tblEmployeeInfo EI On GC.InitiatorID=EI.EmployeeID
				Where GeneratedChaseID = @InterimID

				SEt @SQLChase = 'Update #MyTblChaseInfo Set '
				+@VarInitiatorName+'='+''''+@InitiatorName+''''
				+','+@VarInitiationDate+'='+ '''' +convert(nvarchar,@InitiationDate)+''''
				+','+@VarInitiatorRemarks+'='+''''+@InitiatorRemarks+''''
				+','+@VarTimeTaken+'='+Convert(nvarchar,@TimeTaken)

				print @SQLChase
				exec (@SQLChase)


				Set @ParentChaseID = @InterimID
				Set @InterimID = ''
				Set @InitiatorName = ''
				Set @InitiatorRemarks = ''
				Set @TimeTaken = 0
				Set @i = @i + 1
				Set @j = @j + 1
				Set @k = @k + 1
				Set @l = @l + 1
			end
			else
				break
		end
	end


Select * from #MyTblChaseInfo

drop table #MyTblChaseInfo

