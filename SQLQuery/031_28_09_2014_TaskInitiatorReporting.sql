

alter proc spGetTaskInitiatorList
as
begin
	Select distinct GC.InitiatorID,EI.EmployeeName 
	from vwMasterChaseStatus GC Left Join tblEmployeeInfo EI On GC.InitiatorID=EI.EmployeeID
	order by EI.EmployeeName
end

-- exec spGetTaskInitiatorList

GO

alter proc spGetAssignedChaseByInitiator
@InitiatorID nvarchar(50),
@DateFrom datetime,
@DateTo datetime
as
begin

	Set @DateFrom = @DateFrom + ' 12:00:00 AM'
	Set @DateTo = @DateTo + ' 11:59:00 PM'

	Select * from vwMasterChaseStatus Where InitiatorID=@InitiatorID And 
	InitiationDate between @DateFrom and @DateTo

end

exec spGetAssignedChaseByInitiator 'EMP-00000020','3/1/2014','9/28/2014'