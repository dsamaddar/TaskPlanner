
Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentMasterReportID',0)

GO
-- drop table tblMasterReport
Create table tblMasterReport(
MasterReportID nvarchar(50) primary key,
ChaseDefinitionID nvarchar(50) foreign key references tblChaseDefinition(ChaseDefinitionID),
ReportName nvarchar(200),
IsActive bit default 0,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

alter proc spGetMasterRportLstDetails
as
begin

	Select MasterReportID,ChaseDefinitionID,ReportName,Case IsActive When 1 Then 'YES' Else 'NO' End as 'IsActive',
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate' from tblMasterReport
	order by ReportName 
end

GO

Create proc spGetActiveMasterRptList
as
begin
	Select MasterReportID,ReportName from tblMasterReport Where IsActive=1
	order by ReportName
end

GO


alter proc spInsertMasterReport
@ChaseDefinitionID nvarchar(50),
@ReportName nvarchar(200),
@IsActive bit,
@ControlListIDLst nvarchar(4000),
@EntryBy nvarchar(50)
as
begin
	Declare @MasterReportID nvarchar(50)
	Declare @CurrentMasterReportID numeric(18,0)
	Declare @MasterReportIDPrefix as nvarchar(5)

	set @MasterReportIDPrefix='MSTR-'

	Declare @CtrlLstTbl table(
	ControlListID nvarchar(50),
	Taken bit default 0
	)

begin tran

	Insert Into @CtrlLstTbl(ControlListID)
	SELECT Value 
   	FROM dbo.Split( ',', @ControlListIDLst ) AS s
   	ORDER BY s.[Value]
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	select @CurrentMasterReportID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentMasterReportID'
	
	set @CurrentMasterReportID=isnull(@CurrentMasterReportID,0)+1
	Select @MasterReportID=dbo.generateID(@MasterReportIDPrefix,@CurrentMasterReportID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblMasterReport(MasterReportID,ChaseDefinitionID,ReportName,IsActive,EntryBy)
	Values(@MasterReportID,@ChaseDefinitionID,@ReportName,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0

	Select @NCount = Count(*) from @CtrlLstTbl
	Declare @ControlListID as nvarchar(50) Set @ControlListID = ''
	While @Count <= @NCount
	begin
		
		Select Top 1 @ControlListID=ControlListID from @CtrlLstTbl Where Taken=0

		exec spInsertMasterReportField @MasterReportID,@ControlListID,@EntryBy
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Update @CtrlLstTbl Set Taken=1 Where ControlListID=@ControlListID

		Set @Count = @Count + 1
		set @ControlListID = ''
	end

	update tblAppSettings set PropertyValue=@CurrentMasterReportID where PropertyName='CurrentMasterReportID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end


GO


Create proc spUpdateMasterReport
@MasterReportID nvarchar(50),
@ChaseDefinitionID nvarchar(50),
@ReportName nvarchar(200),
@IsActive bit,
@ControlListIDLst nvarchar(4000),
@EntryBy nvarchar(50)
as
begin

	Declare @CtrlLstTbl table(
	ControlListID nvarchar(50),
	Taken bit default 0
	)

begin tran

	Insert Into @CtrlLstTbl(ControlListID)
	SELECT Value 
   	FROM dbo.Split( ',', @ControlListIDLst ) AS s
   	ORDER BY s.[Value]
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	Update tblMasterReport Set ReportName=@ReportName,IsActive=@IsActive,EntryBy=@EntryBy
	Where MasterReportID=@MasterReportID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Delete from tblMasterReportField Where MasterReportID=@MasterReportID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0

	Select @NCount = Count(*) from @CtrlLstTbl
	Declare @ControlListID as nvarchar(50) Set @ControlListID = ''
	While @Count <= @NCount
	begin
		
		Select Top 1 @ControlListID=ControlListID from @CtrlLstTbl Where Taken=0

		exec spInsertMasterReportField @MasterReportID,@ControlListID,@EntryBy
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Update @CtrlLstTbl Set Taken=1 Where ControlListID=@ControlListID

		Set @Count = @Count + 1
		set @ControlListID = ''
	end

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO


Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentMasterReportFieldID',0)

GO

-- drop table tblMasterReportField
Create table tblMasterReportField(
MasterReportFieldID nvarchar(50) primary key,
MasterReportID nvarchar(50) foreign key references tblMasterReport(MasterReportID),
ControlListID nvarchar(50) foreign key references tblControlList(ControlListID),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO
-- drop proc spInsertMasterReportField
Create proc spInsertMasterReportField
@MasterReportID nvarchar(50),
@ControlListID nvarchar(50),
@EntryBy nvarchar(50)
as
begin

	Declare @MasterReportFieldID nvarchar(50)
	Declare @CurrentMasterReportFieldID numeric(18,0)
	Declare @MasterReportFieldIDPrefix as nvarchar(6)

	set @MasterReportFieldIDPrefix='MST-F-'

begin tran

	select @CurrentMasterReportFieldID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentMasterReportFieldID'
	
	set @CurrentMasterReportFieldID=isnull(@CurrentMasterReportFieldID,0)+1
	Select @MasterReportFieldID=dbo.generateID(@MasterReportFieldIDPrefix,@CurrentMasterReportFieldID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblMasterReportField(MasterReportFieldID,MasterReportID,ControlListID,EntryBy)
	Values(@MasterReportFieldID,@MasterReportID,@ControlListID,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentMasterReportFieldID where PropertyName='CurrentMasterReportFieldID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spGetReportHeaderByMasterID
@MasterReportID nvarchar(50)
as
begin
	Select MRF.ControlListID,CL.ReportingHead from tblMasterReportField MRF Left Join tblControlList CL ON MRF.ControlListID=CL.ControlListID
	Where MRF.MasterReportID = @MasterReportID
	order by CL.ReportingHead 
end

GO

Create proc spGetRptHeaderByChaseDefID
@ChaseDefinitionID nvarchar(50)
as
begin
	Select distinct ControlListID,ReportingHead from tblControlList 
	Where ChaseDefinitionID=@ChaseDefinitionID And IsActive=1
end

Select * from tblChaseInputValues 

GO

alter proc spGenFormattedReport
@MasterReportID nvarchar(50),
@DateFrom datetime,
@DateTo datetime
as
begin

	Declare @Count as int Set @Count = 0
	Declare @NCount as int Set @NCount = 0
	Declare @ChaseDefinitionID as nvarchar(50) Set @ChaseDefinitionID = ''
	Declare @GeneratedChaseID as nvarchar(50) Set @GeneratedChaseID = ''
	Declare @Cols as nvarchar(1000) Set @Cols = ''
	Declare @Sql as nvarchar(1000) Set @Sql = ''
	Declare @ChaseName as nvarchar(200) Set @ChaseName = ''

	Select @ChaseDefinitionID=ChaseDefinitionID from tblMasterReport Where MasterReportID=@MasterReportID

	Create table #MyTbl (
	GeneratedChaseID nvarchar(50),
	ChaseName nvarchar(200)
	);

	Declare @RptHeadTbl table (
	RptHead nvarchar(200),
	Taken Bit Default 0
	);

	Insert into @RptHeadTbl(RptHead)
	Select DISTINCT ReportingHead From tblMasterReportField MRF Left Join tblChaseInputValues CIV 
	ON MRF.ControlListID=CIV.ControlListID
	Where MasterReportID = @MasterReportID And CIV.ReportingHead is not null

	Declare @RCount as int Set @RCount=0
	Declare @RNCount As int Set @RNCount = 0
	Declare @RptHead as nvarchar(200) Set @RptHead = ''
	Declare @ActualHead as nvarchar(200) Set @ActualHead = ''
	DECLARE @Msql nvarchar(4000)


	-------------- Start Of Chase History Data Setup-------------
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
	---------------------------

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


	---------- End Of Chase History Data Setup------------------


	Select @RNCount = count(*) from @RptHeadTbl

	While @RCount < @RNCount
	begin

		Select top 1 @RptHead='['+RptHead+']',@ActualHead=RptHead from @RptHeadTbl Where Taken=0
	
		Set @Msql = 'alter table #MyTbl add ' + @RptHead + ' nvarchar(max); '

		EXEC sp_executesql @Msql
	
		update @RptHeadTbl Set Taken=1 Where RptHead=@ActualHead
		Set @RptHead = ''
		Set @ActualHead = ''
		Set @Msql = ''
		Set @RCount = @RCount + 1
	end

	Declare @GenChaseTbl table(
	GeneratedChaseID nvarchar(50),
	Taken Bit default 0
	);

	Insert into @GenChaseTbl(GeneratedChaseID)
	select GeneratedChaseID from tblGeneratedChase Where ChaseDefinitionID=@ChaseDefinitionID And InitiationDate >=@DateFrom And (TerminationDate<=@DateTo or TerminationDate is null)
	And ParentChaseID is null

	Select @NCount=Count(*) from @GenChaseTbl

	Set @Cols= Stuff((Select Distinct '],['+CIV.ReportingHead From tblMasterReportField MRF Left Join tblChaseInputValues CIV 
	ON MRF.ControlListID=CIV.ControlListID
	Where MasterReportID = @MasterReportID 
    for Xml Path(''),Type).value('.','VARCHAR(Max)'), 1, 2,'')+']'


	While @Count < @NCount
	begin
		
		Select top 1 @GeneratedChaseID=GeneratedChaseID from @GenChaseTbl Where Taken=0

		Select @ChaseName=CD.ChaseName from tblGeneratedChase GC Left Join tblChaseDefinition CD
		ON GC.ChaseDefinitionID=CD.ChaseDefinitionID Where GeneratedChaseID=@GeneratedChaseID

		Set @Sql= 'Insert into #MyTbl (GeneratedChaseID,ChaseName,'+@Cols+')'
		  +'Select '+ ''''+@GeneratedChaseID+''''+','+ ''''+@ChaseName+''''+','+@Cols + 'From (Select ReportingHead,Value+AdditionalValue as ''Value'' From tblChaseInputValues Where GeneratedChaseID='
          +''''+ @GeneratedChaseID +''''+')st pivot (MAX(Value) For ReportingHead in ('
          + @Cols + '))Pvt'


		exec(@Sql)

		Update @GenChaseTbl Set Taken=1 Where GeneratedChaseID=@GeneratedChaseID

		------------------------------ Start Of Chase History Data Input
		Insert into #MyTblChaseInfo(GeneratedChaseID,InitiatorName,InitiationDate,InitiatorRemarks,TimeTaken)
		Select GC.GeneratedChaseID, EI.EmployeeName,	Convert(nvarchar,InitiationDate,100),InitiatorRemarks,dbo.fnGetTimeTakenInChase(GC.GeneratedChaseID)
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
						+','+@VarTimeTaken+'='+Convert(nvarchar,@TimeTaken)+' Where GeneratedChaseID='+''''+@GeneratedChaseID+''''

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

		------------------------------End Of Chase History Data Input



		Set @Count = @Count + 1
		Set @GeneratedChaseID = ''
		Set @ChaseName = ''
		Set @i = 0
		Set @j = 0
		Set @k = 0
		Set @l = 0

	end

	
	Select * from #MyTbl left Join #MyTblChaseInfo On #MyTbl.GeneratedChaseID=#MyTblChaseInfo.GeneratedChaseID

	Drop table #MyTbl

	drop table #MyTblChaseInfo

end

exec spGenFormattedReport 'MSTR-00000004','5/1/2014','7/28/2014'

