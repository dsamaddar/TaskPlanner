

Select * from tblChaseInputValues 

GO

-- drop proc spGetAssignedChaseByUser
alter proc spGetAssignedChaseByUser
@EmployeeID nvarchar(50)
as
begin
	
	Select GC.GeneratedChaseID,GC.MasterChaseID,CD.ChaseDefinitionID,CD.ChaseName,EI.EmployeeName as 'Initiator',Convert(nvarchar,GC.InitiationDate,100) as 'InitiationDate',
	GC.InitiatorRemarks,isnull(VD.DataSource,'N\A') as 'DataSource',
	dbo.fnGetChaseInputValuesDesc(GC.MasterChaseID) as 'Description'
	from tblGeneratedChase GC left join tblChaseDefinition CD On GC.ChaseDefinitionID=CD.ChaseDefinitionID
	Left Join tblEmployeeInfo EI On GC.InitiatorID = EI.EmployeeID
	left Join tblVoiceDataCollection VD On GC.VoiceDataCollectionID = VD.VoiceDataCollectionID
	Where GC.AssignedToID=@EmployeeID 
	And GC.IsTerminated=0 And GC.IsActive=1
	order by GC.InitiationDate asc

end

-- exec spGetAssignedChaseByUser 'EMP-00000020'




GO

alter proc spGetChaseHistoryByGenChaseID
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
	UploadedFile nvarchar(500),
	AssignedTo nvarchar(200),
	Remarks nvarchar(500),
	IsTerminated nvarchar(500),
	TimeTaken int,
	ChaseProgress nvarchar(50),
	ChaseStatus nvarchar(50)
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
	
	
	Select * from @ChaseHistory
end

-- exec spGetChaseHistoryByGenChaseID 'GEN-C-00000150' 


Select * from tblGeneratedChase Where GeneratedChaseID='GEN-C-00000035' 

GO

-- drop function fnGetTimeTakenInChase
alter function fnGetTimeTakenInChase(@GeneratedChaseID nvarchar(50))
returns int
as
begin

	Declare @InitiationDate as datetime
	Declare @TerminationDate as datetime
	Declare @EndDate as datetime
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

	Select @InitiationDate=InitiationDate,@TerminationDate=TerminationDate from tblGeneratedChase 
	Where GeneratedChaseID=@GeneratedChaseID

	If exists(Select * from tblGeneratedChase Where ParentChaseID=@GeneratedChaseID)
	begin
		
		Select @EndDate=InitiationDate from tblGeneratedChase Where ParentChaseID=@GeneratedChaseID
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

				If @MinDiff < 0
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

	end
	else
	begin
		if @TerminationDate is null
			Set @TimeTaken = 0
		else
		begin
			
			Set @TotalMin = DATEDIFF(Minute,@InitiationDate,@TerminationDate)

			Set @NCount = DATEDIFF(DAY,@InitiationDate,@TerminationDate)

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
						
					if @TerminationDate > @B
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

		end
	end
		

	return isnull( @TimeTaken,0)
end

select dbo.fnGetTimeTakenInChase('GEN-C-00000035')
