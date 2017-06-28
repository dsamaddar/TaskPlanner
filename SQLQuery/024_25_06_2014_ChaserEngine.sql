
-- drop view vwMasterChaseStatus
Create view vwMasterChaseStatus
as
Select GC.GeneratedChaseID,CD.ChaseDefinitionID,GC.MasterChaseID,
CD.CategoryID,
(Select CategoryName from tblCategory C Where C.CategoryID=CD.CategoryID) as 'Category',
CD.SubCategoryID,
(Select SubCategory from tblSubCategory SC Where SC.SubCategoryID=CD.SubCategoryID) as 'SubCategory',
CD.ItemID,
(Select ItemName from tblItems I Where I.ItemID=CD.ItemID) as 'Item',
dbo.fnGetEmpNameByID(GC.ContactPersonID) as 'ContactPerson',GC.PriorityID,P.Timing,P.PriorityText,
CD.ChaseName,GC.InitiatorID,dbo.fnGetEmpNameByID(GC.InitiatorID) as 'Initiator',GC.InitiatorRemarks,GC.InitiationDate,
dbo.fnGetEmpNameByID(GC.AssignedToID) as 'AssignedTo',
dbo.fnGetLatestInitiationTime(GC.GeneratedChaseID) as 'EndTime',	dbo.fnGetLatestChaseStatus( GC.GeneratedChaseID) as 'ChaseStatus',
Isnull(GC.FinalStatus,'N\A') as 'FinalStatus',
GC.ULCBranchID,
(SElect ULCBranchName from tblULCBranch UB Where UB.ULCBranchID=GC.ULCBranchID) as 'ULCBranchName',
dbo.fnGetChaseInputValuesDesc(GC.GeneratedChaseID) as 'Description',GC.EntryDate,
dbo.fnGetChaseHistoryByGenChaseID(GC.GeneratedChaseID) as 'AssignmentHistory',
dbo.fnGetLastAssignedPerson(GC.MasterChaseID) as 'LastAssignedPerson'
from tblGeneratedChase GC left Join tblChaseDefinition CD On GC.ChaseDefinitionID=CD.ChaseDefinitionID
Left Join tblPriority P On GC.PriorityID = P.PriorityID
Where GC.GeneratedChaseID=GC.MasterChaseID

-- Select * from vwMasterChaseStatus

GO

alter function fnGetLastAssignedPerson(@MasterChaseID nvarchar(50))
returns nvarchar(200)
as
begin
	
	Declare @AssignedToID as nvarchar(50) Set @AssignedToID = ''
	Declare @AssignedTo nvarchar(200) Set @AssignedTo  = ''

	Select top 1 @AssignedToID = AssignedToID from tblGeneratedChase Where MasterChaseID=@MasterChaseID
	order by InitiationDate desc

	Select @AssignedTo=EmployeeName from tblEmployeeInfo Where EmployeeID=@AssignedToID

	return @AssignedTo

end

GO

-- exec spChaserStatusEngine

alter proc spChaserStatusEngine
as
begin

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0
	Declare @GeneratedChaseID as nvarchar(50) Set @GeneratedChaseID = ''
	Declare @Timing as int Set @Timing = 0
	Declare @StartTime as datetime
	Declare @EndTime as datetime Set @EndTime = getdate()
	Declare @ActualTimeTaken int Set @ActualTimeTaken = 0
	
	Declare @ChaseList Table(
	GeneratedChaseID nvarchar(50),
	Timing int,
	StartTime datetime,
	Taken bit default 0
	);

	Insert into @ChaseList(GeneratedChaseID,Timing,StartTime)
	Select GeneratedChaseID,Timing,InitiationDate from vwMasterChaseStatus
	Where ChaseStatus in ('Assigned','Forwarded') And FinalStatus <> 'Overdue'

	Select @NCount = Count(*) from @ChaseList

	While @Count <= @NCount
	begin
		
		Select top 1 @GeneratedChaseID=GeneratedChaseID,@Timing=Timing*60,@StartTime=StartTime 
		from  @ChaseList Where Taken=0

		Select @ActualTimeTaken =  dbo.fnGetEffectiveTimeTaken(@StartTime,@EndTime)

		if @ActualTimeTaken >= @Timing
		begin
			
			Update tblGeneratedChase Set FinalStatus='Overdue' Where MasterChaseID= @GeneratedChaseID

		end

		Update @ChaseList Set Taken=1 Where GeneratedChaseID=@GeneratedChaseID
		Set @Count = @Count + 1
		Set @GeneratedChaseID = ''

	end
end

GO

alter function fnGetLatestInitiationTime(@GeneratedChaseID as nvarchar(50))
returns nvarchar(50)
as
begin
	Declare @InitioationTime as datetime 
	Declare @TerminationDate as datetime
	Declare @EndTime as datetime 

	SElect top 1 @InitioationTime=InitiationDate,@TerminationDate=TerminationDate from tblGeneratedChase Where MasterChaseID=@GeneratedChaseID
	order by InitiationDate desc,TerminationDate desc

	if @TerminationDate is not null
	begin
		return @TerminationDate
	end
	
	return @InitioationTime
end

GO

-- Select dbo.fnGetEffectiveTimeTaken('6/25/2014 09:06 AM','6/25/2014 12:35 PM')

-- drop proc spGetEffectiveTimeTaken
Create function fnGetEffectiveTimeTaken(
@InitiationDate datetime,
@EndDate datetime
)
returns int
as
begin
	
	Declare @TimeTaken as int Set @TimeTaken = 0
	Declare @TotalMin as int Set @TotalMin = 0

	Declare @TotalDays as int Set @TotalDays = 0
	Declare @Count as int Set @Count = 0
	Declare @NCount as int Set @NCount = 0
	Declare @InterimDate as datetime
	Declare @StartPoint as nvarchar(50) Set @StartPoint = ''
	Declare @EndPoint as nvarchar(50) Set @EndPoint = ''
	Declare @A as datetime
	Declare @B as datetime
	Declare @MinDiff as int Set @MinDiff = 0
	Declare @eod as datetime
	
	Set @TotalMin = DATEDIFF(Minute,@InitiationDate,@EndDate)

	Set @NCount = DATEDIFF(DAY,@InitiationDate,@EndDate)

	Set @InterimDate = @InitiationDate

	While @Count <= @NCount
	begin
		If DATENAME(DW,@InterimDate) = 'Friday' or DATENAME(DW,@InterimDate) = 'Saturday'
			or exists (Select * from tblHolidays Where Convert(nvarchar, HolidayDate,101)= Convert(nvarchar,@InterimDate,101) )
		begin
			Set @TotalMin = @TotalMin - 1440
			Set @InterimDate =  Convert(nvarchar,DATEADD(DAY,1,@InterimDate),101)+ ' 12:01 AM'
		end
		else
		begin
			
			Select @StartPoint=Convert(nvarchar,FromHour)+':'+Convert(nvarchar,FromMinute)+' ' + FromMeridiem,
			@EndPoint=Convert(nvarchar,ToHour)+':'+Convert(nvarchar,ToMinute)+' ' + ToMeridiem 
			from tblManageWeekdays Where WeekDays=DATENAME(DW,@InterimDate)

			Set @A = CONVERT(nvarchar,@InterimDate,101)+ ' ' + @StartPoint
			Set @B = CONVERT(nvarchar,@InterimDate,101)+ ' ' + @EndPoint

			Set @MinDiff = DATEDIFF(MINUTE,@A,@InterimDate)

			if @MinDiff < 0
				Set @TotalMin = @TotalMin - ABS(@MinDiff)
						
			if @EndDate > @B
			begin
				Set @MinDiff = DATEDIFF(MINUTE,@B,Convert(nvarchar,@InterimDate,101)+' 11:59 PM')
				Set @TotalMin = @TotalMin - @MinDiff
				Set @InterimDate =  Convert(nvarchar,DATEADD(DAY,1,@InterimDate),101)+ ' 12:01 AM'
			end								
		end

		Set @Count = @Count + 1
		
			
	end
	
	if @TotalMin < 0
		Set  @TimeTaken = 0
	else
		Set  @TimeTaken = @TotalMin

	return @TimeTaken
end

GO

-- drop proc spSearchChaseByIDorName
alter proc spSearchChaseByIDorName
@ChaseNameOrID nvarchar(200)
as
begin
	Select * from vwMasterChaseStatus  
	Where (GeneratedChaseID like '%'+ @ChaseNameOrID +'%' or 
	ChaseName like '%'+ @ChaseNameOrID+'%' or 
	ContactPerson like '%'+ @ChaseNameOrID+'%')
end

-- exec spSearchChaseByIDorName 'IA'

alter proc spRptReqLogCount
@QueryType nvarchar(50)
as
begin
	
	Declare @FirstDate as datetime

	Declare @ReqCountTbl table(
	Value nvarchar(50),
	ReqCount int
	);

	Declare @Count as int
	Declare @NCount as int

	if @QueryType = 'ThisWeek'
	begin
		Set @Count = 1
		Set @NCount = 7
		Select @FirstDate = dbo.GetFirstDayOfWeek(getdate())

		While @Count <= @NCount
		begin
			Print Convert(nvarchar,@Count)

			if exists(
				Select LEFT(DATENAME(WEEKDAY,@FirstDate),3) ,Count(*) from vwMasterChaseStatus 
				Where CONVERT(nvarchar,EntryDate,101)=Convert(nvarchar,@FirstDate,101)
				group by CONVERT(nvarchar,EntryDate,101)
			)
			begin
				Insert into @ReqCountTbl(Value,ReqCount)
				Select LEFT(DATENAME(WEEKDAY,@FirstDate),3) ,Count(*) from vwMasterChaseStatus 
				Where CONVERT(nvarchar,EntryDate,101)=Convert(nvarchar,@FirstDate,101)
				group by CONVERT(nvarchar,EntryDate,101)
			end
			else
			begin
				Insert into @ReqCountTbl(Value,ReqCount)Values(LEFT(DATENAME(WEEKDAY,@FirstDate),3),0)
			end
			
			
			Set @FirstDate = DATEADD(DAY,1,@FirstDate)
			Set @Count = @Count + 1
		end

	end
	Else if @QueryType = 'LastWeek'
	begin
		Set @Count = 1
		Set @NCount = 7
		Select @FirstDate = dbo.GetFirstDayOfWeek(DATEADD(DAY,-7,getdate()))

		While @Count <= @NCount
		begin
			Print Convert(nvarchar,@Count)
			
			if exists(
				Select LEFT(DATENAME(WEEKDAY,@FirstDate),3) ,Count(*) from vwMasterChaseStatus 
				Where CONVERT(nvarchar,EntryDate,101)=Convert(nvarchar,@FirstDate,101)
				group by CONVERT(nvarchar,EntryDate,101)
			)
			begin
				Insert into @ReqCountTbl(Value,ReqCount)
				Select LEFT(DATENAME(WEEKDAY,@FirstDate),3) ,Count(*) from vwMasterChaseStatus 
				Where CONVERT(nvarchar,EntryDate,101)=Convert(nvarchar,@FirstDate,101)
				group by CONVERT(nvarchar,EntryDate,101)
			end
			else
			begin
				Insert into @ReqCountTbl(Value,ReqCount)Values(LEFT(DATENAME(WEEKDAY,@FirstDate),3),0)
			end
			
			Set @FirstDate = DATEADD(DAY,1,@FirstDate)
			Set @Count = @Count + 1
		end

	end

	--elect @FirstDate
	Select * from @ReqCountTbl

end

exec spRptReqLogCount 'ThisWeek'

Select CONVERT(nvarchar,EntryDate,101),count(*) from vwMasterChaseStatus 
group by CONVERT(nvarchar,EntryDate,101)


GO

CREATE FUNCTION GetFirstDayOfWeek( @pInputDate DATETIME )
RETURNS DATETIME
BEGIN

	SET @pInputDate = CONVERT(VARCHAR(10), @pInputDate, 111)
	RETURN DATEADD(DD, 1 - DATEPART(DW, @pInputDate),@pInputDate)

END

-- Select dbo.GetFirstDayOfWeek('7/3/2014')

GO

alter function fnGetChaseHistoryByGenChaseID(@GeneratedChaseID nvarchar(50))
returns nvarchar(4000)
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
	UploadedFile nvarchar(500),
	AssignedTo nvarchar(200),
	Remarks nvarchar(500),
	IsTerminated nvarchar(500),
	TimeTaken int,
	ChaseProgress nvarchar(50),
	ChaseStatus nvarchar(50),
	Taken bit default 0
	);

	Insert into @ChaseHistory(InitiatorName,InitiationDate,InitiatorRemarks,UploadedFile,
	AssignedTo,Remarks,IsTerminated,TimeTaken,ChaseProgress,ChaseStatus)
	Select EI.EmployeeName,	Convert(nvarchar,InitiationDate,100),InitiatorRemarks,isnull(UploadedFile,'N\A'),
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

				Insert into @ChaseHistory(InitiatorName,InitiationDate,InitiatorRemarks,UploadedFile,
				AssignedTo,Remarks,IsTerminated,TimeTaken,ChaseProgress,ChaseStatus)
				Select EI.EmployeeName,Convert(nvarchar,InitiationDate,100),InitiatorRemarks,isnull(UploadedFile,'N\A'),
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
	
	Declare @AssignmentStr as nvarchar(400) Set @AssignmentStr = ''
	
	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0
	Declare @Initiator as nvarchar(200) Set @Initiator = ''
	Declare @AssignedTo as nvarchar(200) Set @AssignedTo = ''
	Declare @ChaseStatus as nvarchar(50) Set @ChaseStatus = ''
	Declare @InitiationDate as datetime 

	Select @NCount = count(*) from @ChaseHistory

	While @Count<= @NCount
	begin
		
		Select top 1 @Initiator=InitiatorName,@AssignedTo=AssignedTo,@InitiationDate=InitiationDate,@ChaseStatus=ChaseStatus 
		from @ChaseHistory Where Taken = 0

		Set @AssignmentStr = @AssignmentStr + ' - ' + @Initiator + ' - ' + @AssignedTo + ' [' + Convert(nvarchar, @InitiationDate) + '] -' + @ChaseStatus + CHAR(13)

		Update @ChaseHistory Set Taken=1 Where SLNo = @Count
		Set @Count = @Count + 1
	end

	return @AssignmentStr
end

-- exec spGetChaseHistoryByGenChaseID 'GEN-C-00000150' 

Select dbo.fnGetChaseHistoryByGenChaseID('GEN-C-00000121')