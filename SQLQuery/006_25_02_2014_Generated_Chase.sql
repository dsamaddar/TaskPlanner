

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentGeneratedChaseID',0)

GO

-- drop table tblGeneratedChase
Create table tblGeneratedChase (
GeneratedChaseID nvarchar(50) primary key,
ChaseDefinitionID nvarchar(50) foreign key references tblChaseDefinition(ChaseDefinitionID),
VoiceDataCollectionID nvarchar(50) foreign key references tblVoiceDataCollection(VoiceDataCollectionID),
MasterChaseID nvarchar(50) foreign key references tblGeneratedChase(GeneratedChaseID),
ParentChaseID nvarchar(50) foreign key references tblGeneratedChase(GeneratedChaseID),
InitiatorID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
InitiationDate datetime default getdate(),
InitiatorRemarks nvarchar(500),
UploadedFile nvarchar(500),
AssignedToID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
Remarks nvarchar(500),
IsTerminated bit default 0,
TerminatorID  nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
TerminationDate datetime,
IsActive bit default 1,
ChaseProgress nvarchar(50),
ChaseStatus nvarchar(50),
ULCBranchID nvarchar(50) foreign key references tblULCBranch(ULCBranchID),
ContactPersonID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
ModeOfCommunication nvarchar(200),
PriorityID nvarchar(50) foreign key references tblPriority(PriorityID),
FinalStatus nvarchar(50),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

-- delete from tblGeneratedChase

GO

alter proc spInsertGeneratedChase
@ChaseDefinitionID	nvarchar(50),
@VoiceDataCollectionID nvarchar(50),
@ParentChaseID nvarchar(50),
@InitiatorID nvarchar(50),
@InitiatorRemarks nvarchar(500),
@AssignedToID nvarchar(50),
@ULCBranchID nvarchar(50),
@ContactPersonID nvarchar(50),
@ModeOfCommunication nvarchar(200),
@PriorityID nvarchar(50),
@EntryBy nvarchar(50)
as
begin
	Declare @GeneratedChaseID nvarchar(50)
	Declare @CurrentGeneratedChaseID numeric(18,0)
	Declare @GeneratedChaseIDPrefix as nvarchar(6)
	Declare @ChaseProgress as nvarchar(50) Set @ChaseProgress = '0%'
	Declare @ChaseStatus as nvarchar(50) Set @ChaseStatus = 'Assigned'

	set @GeneratedChaseIDPrefix='GEN-C-'

	if @ParentChaseID = 'N\A'
		Set @ParentChaseID = null

	if @ULCBranchID = 'N\A'
		Set @ULCBranchID = null

	if @ContactPersonID = 'N\A'
		Set @ContactPersonID = null

begin tran
	
	select @CurrentGeneratedChaseID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentGeneratedChaseID'
	
	set @CurrentGeneratedChaseID=isnull(@CurrentGeneratedChaseID,0)+1
	Select @GeneratedChaseID=dbo.generateID(@GeneratedChaseIDPrefix,@CurrentGeneratedChaseID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblGeneratedChase(GeneratedChaseID,ChaseDefinitionID,VoiceDataCollectionID,MasterChaseID,ParentChaseID,InitiatorID,InitiationDate,InitiatorRemarks,
	AssignedToID,ChaseProgress,ChaseStatus,ULCBranchID,ContactPersonID,ModeOfCommunication,PriorityID,FinalStatus,EntryBy)
	Values(@GeneratedChaseID,@ChaseDefinitionID,@VoiceDataCollectionID,@GeneratedChaseID,@ParentChaseID,@InitiatorID,getdate(),@InitiatorRemarks,
	@AssignedToID,@ChaseProgress,@ChaseStatus,@ULCBranchID,@ContactPersonID,@ModeOfCommunication,@PriorityID,'Open',@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentGeneratedChaseID where PropertyName='CurrentGeneratedChaseID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Select @GeneratedChaseID as 'GeneratedChaseID'

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO


alter proc spInsertGenGeneratedChase
@ChaseDefinitionID	nvarchar(50),
@ParentChaseID nvarchar(50),
@InitiatorID nvarchar(50),
@InitiatorRemarks nvarchar(500),
@AssignedToID nvarchar(50),
@ULCBranchID nvarchar(50),
@ContactPersonID nvarchar(50),
@ModeOfCommunication nvarchar(200),
@PriorityID nvarchar(50),
@EntryBy nvarchar(50)
as
begin
	Declare @GeneratedChaseID nvarchar(50)
	Declare @CurrentGeneratedChaseID numeric(18,0)
	Declare @GeneratedChaseIDPrefix as nvarchar(6)
	Declare @ChaseProgress as nvarchar(50) Set @ChaseProgress = '0%'
	Declare @ChaseStatus as nvarchar(50) Set @ChaseStatus = 'Assigned'

	set @GeneratedChaseIDPrefix='GEN-C-'

	if @ParentChaseID = 'N\A'
		Set @ParentChaseID = null

	if @ULCBranchID = 'N\A'
		Set @ULCBranchID = null

	if @ContactPersonID = 'N\A'
		Set @ContactPersonID = null

begin tran
	
	select @CurrentGeneratedChaseID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentGeneratedChaseID'
	
	set @CurrentGeneratedChaseID=isnull(@CurrentGeneratedChaseID,0)+1
	Select @GeneratedChaseID=dbo.generateID(@GeneratedChaseIDPrefix,@CurrentGeneratedChaseID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblGeneratedChase(GeneratedChaseID,ChaseDefinitionID,MasterChaseID,ParentChaseID,InitiatorID,InitiationDate,InitiatorRemarks,
	AssignedToID,ChaseProgress,ChaseStatus,ULCBranchID,ContactPersonID,ModeOfCommunication,PriorityID,FinalStatus,EntryBy)
	Values(@GeneratedChaseID,@ChaseDefinitionID,@GeneratedChaseID,@ParentChaseID,@InitiatorID,getdate(),@InitiatorRemarks,
	@AssignedToID,@ChaseProgress,@ChaseStatus,@ULCBranchID,@ContactPersonID,@ModeOfCommunication,@PriorityID,'Open',@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentGeneratedChaseID where PropertyName='CurrentGeneratedChaseID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Select @GeneratedChaseID as 'GeneratedChaseID'

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end


GO
-- Select * from tblGeneratedChase 

alter proc spUpdateChaseStatus
@MasterChaseID nvarchar(50),
@ParentChaseID nvarchar(50),
@InitiatorID nvarchar(50),
@UploadedFile nvarchar(500),
@AssignedToID nvarchar(50),
@Remarks nvarchar(500),
@ChaseProgress nvarchar(50),
@IsTerminated bit,
@EntryBy nvarchar(50)
as
begin

	Declare @VoiceDataCollectionID nvarchar(50) Set @VoiceDataCollectionID = ''
	Declare @GeneratedChaseID nvarchar(50)
	Declare @CurrentGeneratedChaseID numeric(18,0)
	Declare @GeneratedChaseIDPrefix as nvarchar(6)
	Declare @ChaseStatus as nvarchar(50) Set @ChaseStatus = ''
	
	set @GeneratedChaseIDPrefix='GEN-C-'

	Declare @ChaseDefinitionID as nvarchar(50) Set @ChaseDefinitionID = ''

begin tran

	select @CurrentGeneratedChaseID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentGeneratedChaseID'
	
	set @CurrentGeneratedChaseID=isnull(@CurrentGeneratedChaseID,0)+1
	Select @GeneratedChaseID=dbo.generateID(@GeneratedChaseIDPrefix,@CurrentGeneratedChaseID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Select @ChaseDefinitionID = ChaseDefinitionID,@VoiceDataCollectionID=VoiceDataCollectionID from tblGeneratedChase Where GeneratedChaseID=@ParentChaseID


	if @IsTerminated = 1
	begin
		Set @ChaseStatus = 'Terminated'
		Update tblGeneratedChase Set UploadedFile=@UploadedFile, Remarks=@Remarks,IsTerminated=@IsTerminated,TerminatorID=@InitiatorID,TerminationDate=Getdate(),
		IsActive=0,ChaseProgress=@ChaseProgress,ChaseStatus=@ChaseStatus
		Where GeneratedChaseID=@ParentChaseID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
		
		Update tblGeneratedChase Set FinalStatus='Closed' Where MasterChaseID=@MasterChaseID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
	end
	else
	begin

		Update tblGeneratedChase Set IsActive=0 Where GeneratedChaseID=@ParentChaseID

		Set @ChaseStatus = 'Forwarded'

		Insert into tblGeneratedChase(GeneratedChaseID,ChaseDefinitionID,VoiceDataCollectionID,MasterChaseID,ParentChaseID,InitiatorID,InitiationDate,InitiatorRemarks,UploadedFile,
		AssignedToID,ChaseProgress,ChaseStatus,EntryBy)
		Values(@GeneratedChaseID,@ChaseDefinitionID,@VoiceDataCollectionID,@MasterChaseID,@ParentChaseID,@InitiatorID,getdate(),@Remarks,@UploadedFile,
		@AssignedToID,@ChaseProgress,@ChaseStatus,@EntryBy)
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		update tblAppSettings set PropertyValue=@CurrentGeneratedChaseID where PropertyName='CurrentGeneratedChaseID'
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
	end

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentChaseInputValueID',0)

GO
-- drop table tblChaseInputValues
Create table tblChaseInputValues(
ChaseInputValueID nvarchar(50) primary key,
GeneratedChaseID nvarchar(50) foreign key references tblGeneratedChase(GeneratedChaseID),
ControlListID nvarchar(50) foreign key references tblControlList(ControlListID),
ReportingHead nvarchar(200),
Value nvarchar(4000),
AdditionalValue nvarchar(4000)
);

GO

alter proc spGetChaseInputvalues
@GeneratedChaseID nvarchar(50)
as
begin
	Select ReportingHead, Convert(varchar(max),Value)+ Convert(nvarchar(max),isnull(AdditionalValue,'')) as 'Value' from tblChaseInputValues Where GeneratedChaseID=@GeneratedChaseID
end

Select * from tblGeneratedChase 

-- exec spGetChaseInputvalues 'GEN-C-00000071'

GO

Select dbo.fnGetChaseInputValuesDesc('GEN-C-00000071')

Create function fnGetChaseInputValuesDesc (@GeneratedChaseID nvarchar(50))
returns nvarchar(4000)
as
begin
	 
	Declare @Details as nvarchar(4000) Set @Details = ''

	Declare @RptTbl table(
	ReportingHead nvarchar(200),
	Value nvarchar(4000),
	Taken bit default 0
	);

	Insert Into @RptTbl(ReportingHead,Value)
	Select ReportingHead, Convert(varchar(max),Value)+ Convert(nvarchar(max),isnull(AdditionalValue,'')) as 'Value'
	from tblChaseInputValues Where GeneratedChaseID=@GeneratedChaseID

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0 
	Declare @ReportingHead as nvarchar(200) Set @ReportingHead = ''
	Declare @Value as nvarchar(4000) Set @Value =''
	
	Select @NCount = count(*) from @RptTbl

	While @Count <= @NCount
	begin
		
		Select top 1 @ReportingHead=ReportingHead,@Value=Value from @RptTbl Where Taken=0

		Set @Details = @Details + @ReportingHead + ' : ' + @Value + CHAR(13)

		Update @RptTbl Set Taken=1 Where ReportingHead = @ReportingHead
		Set @Count = @Count + 1
	end

	return @Details


end





GO

-- drop proc spInsertChaseInputValues
alter proc spInsertChaseInputValues
@GeneratedChaseID nvarchar(50),
@ChaseDefinitionID nvarchar(50),
@ControlType nvarchar(50),
@ControlID nvarchar(50),
@Value nvarchar(4000),
@AdditionalValue nvarchar(4000)
as
begin
	Declare @ChaseInputValueID nvarchar(50)
	Declare @CurrentChaseInputValueID numeric(18,0)
	Declare @ChaseInputValueIDPrefix as nvarchar(4)
	Declare @ControlListID as nvarchar(50) Set @ControlListID = ''
	Declare @ReportingHead as nvarchar(200) Set @ReportingHead = ''

	set @ChaseInputValueIDPrefix='CIV-'

begin tran
	
	select @CurrentChaseInputValueID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentChaseInputValueID'
	
	set @CurrentChaseInputValueID=isnull(@CurrentChaseInputValueID,0)+1
	Select @ChaseInputValueID=dbo.generateID(@ChaseInputValueIDPrefix,@CurrentChaseInputValueID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	if @ControlType = 'RadioButtonList'
	begin
		Select @ReportingHead=ReportingHead,@ControlListID=ControlListID from tblControlList Where GroupControlID=@ControlID And ChaseDefinitionID=@ChaseDefinitionID
	end
	else if @ControlType = 'CheckBoxList' 
	begin
		Select @ReportingHead=ReportingHead,@ControlListID=ControlListID from tblControlList Where GroupControlID=@ControlID And ChaseDefinitionID=@ChaseDefinitionID And ControlValue=@Value
	end
	else if @ControlType = 'DropDownList' 
	begin
		Select @ReportingHead=ReportingHead,@ControlListID=ControlListID from tblControlList Where GroupControlID=@ControlID And ChaseDefinitionID=@ChaseDefinitionID And ControlValue=@Value
	end
	else
	begin
		Select @ReportingHead=ReportingHead,@ControlListID=ControlListID from tblControlList Where ControlID=@ControlID And ChaseDefinitionID=@ChaseDefinitionID
	end

	Insert into tblChaseInputValues(ChaseInputValueID,GeneratedChaseID,ControlListID,ReportingHead,Value,AdditionalValue)
	Values(@ChaseInputValueID,@GeneratedChaseID,@ControlListID,@ReportingHead,@Value,@AdditionalValue)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentChaseInputValueID where PropertyName='CurrentChaseInputValueID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO


Create proc spUpdateChaseInputValues
@GeneratedChaseID nvarchar(50),
@ChaseDefinitionID nvarchar(50),
@ControlType nvarchar(50),
@ControlID nvarchar(50),
@Value nvarchar(4000),
@AdditionalValue nvarchar(4000)
as
begin
	Declare @ChaseInputValueID as nvarchar(50) Set @ChaseInputValueID = ''
	Declare @ControlListID as nvarchar(50) Set @ControlListID = ''
begin tran

	if @ControlType = 'RadioButtonList'
	begin
		Select @ControlListID=ControlListID from tblControlList Where GroupControlID=@ControlID And ChaseDefinitionID=@ChaseDefinitionID
	end
	else if @ControlType = 'CheckBoxList' 
	begin
		Select @ControlListID=ControlListID from tblControlList Where GroupControlID=@ControlID And ChaseDefinitionID=@ChaseDefinitionID And ControlValue=@Value
	end
	else
	begin
		Select @ControlListID=ControlListID from tblControlList Where ControlID=@ControlID And ChaseDefinitionID=@ChaseDefinitionID
	end

	Select @ChaseInputValueID=ChaseInputValueID from tblChaseInputValues Where GeneratedChaseID=@GeneratedChaseID 
	And ControlListID=@ControlListID

	Update tblChaseInputValues Set Value=@Value, AdditionalValue=@AdditionalValue 
	Where ChaseInputValueID=@ChaseInputValueID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Select * from tblGeneratedChase 

-- exec spChaseGenearationMail 'GEN-C-00000022'
alter proc spChaseGenearationMail
@GeneratedChaseID nvarchar(50)
as
begin
	Declare @MailBody as nvarchar(4000) Set @MailBody = ''
	Declare @MailSubject as nvarchar(200) Set @MailSubject = ''
	Declare @MailTo as nvarchar(50) Set @MailTo = ''
	Declare @MailFrom as nvarchar(50) Set @MailFrom =''
	Declare @MailCC as nvarchar(50) Set @MailCC = ''
	Declare @SoftWareLink  as nvarchar(500) Set @SoftWareLink = ''
	Declare @SMTPServer as nvarchar(50) Set @SMTPServer = ''
	Declare @SMTPPort as nvarchar(50) Set @SMTPPort = ''

	Declare @ChaseName as nvarchar(500) Set @ChaseName = ''
	Declare @TempMailAddress as nvarchar(50) Set @TempMailAddress=''
	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
	Declare @Initiator as nvarchar(200) Set @Initiator = ''
	Declare @AssignedTo as nvarchar(200) Set @AssignedTo = ''
	Declare @CurrentSupervisor as nvarchar(50) Set @CurrentSupervisor = ''

	Declare @ChaseDefinitionID as nvarchar(50) set @ChaseDefinitionID = ''
	Declare @InitiatorID as nvarchar(50) Set @InitiatorID = ''
	Declare @AssignedToID as nvarchar(50) Set @AssignedToID = ''
	Declare @InformedParties as nvarchar(4000) Set @InformedParties = ''
	Declare @ReportingHead as nvarchar(200) Set @ReportingHead = ''
	Declare @Value as varchar(max) Set @Value = ''

	Declare @Branch as nvarchar(200) Set @Branch = ''
	Declare @ContactPerson as nvarchar(200) Set @ContactPerson = ''
	Declare @Priority as nvarchar(200) Set @Priority = ''
	Declare @ModeOfCommunication as nvarchar(200) Set @ModeOfCommunication = ''

	Select @SMTPServer=PropertyValue from tblAppSettings Where PropertyName='SMTPServer'
	Select @SMTPPort=PropertyValue from tblAppSettings Where PropertyName='SMTPPort'
	Select @SoftWareLink=PropertyValue from tblAppSettings Where PropertyName='SoftWareLink'

	Select @InitiatorID=InitiatorID,@AssignedToID=AssignedToID,@ChaseDefinitionID=ChaseDefinitionID,@ModeOfCommunication=ModeOfCommunication
	from tblGeneratedChase Where GeneratedChaseID=@GeneratedChaseID
	
	Select @ChaseName=ChaseName from tblChaseDefinition Where ChaseDefinitionID=@ChaseDefinitionID

	Select @Branch = ULCBranchName from tblULCBranch UB Where UB.ULCBranchID in 
	(Select ULCBranchID from tblGeneratedChase GC Where GC.GeneratedChaseID=@GeneratedChaseID)

	Select @Priority = PriorityText from tblPriority P Where P.PriorityID in (
	Select PriorityID from tblGeneratedChase GC Where GC.GeneratedChaseID=@GeneratedChaseID)
	
	Declare @ContactPersonID as nvarchar(50) Set @ContactPersonID = ''
	Declare @ContactPersonMailAddress as nvarchar(50) Set @ContactPersonMailAddress = ''

	Select @ContactPersonID = ContactPersonID from tblGeneratedChase GC Where GC.GeneratedChaseID=@GeneratedChaseID

	Select @ContactPerson=EmployeeName,@ContactPersonMailAddress=MailAddress from tblEmployeeInfo EI Where EI.EmployeeID=@ContactPersonID

	-- Mail CC Configuration
	Declare @EmpTbl table(
	EmployeeID nvarchar(50),
	Taken Bit default 0
	);

	Insert into @EmpTbl(EmployeeID)
	Select EmployeeID from tblInterestedReps Where ChaseDefinitionID=@ChaseDefinitionID And InterestType='Informed'

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount=0

	Select @NCount=Count(*) from @EmpTbl

	While @Count <= @NCount
	begin
		Select top 1 @EmployeeID=EmployeeID from @EmpTbl Where Taken=0 

		Select @TempMailAddress = MailAddress from tblEmployeeInfo Where EmployeeID=@EmployeeID

		if @MailCC = ''
			Set @MailCC = @TempMailAddress
		else
			Set @MailCC = @MailCC + ';'+ @TempMailAddress
		
		Update @EmpTbl Set Taken=1 Where EmployeeID=@EmployeeID
		Set @Count = @Count + 1 
		Set @TempMailAddress = ''
		Set @EmployeeID = ''
	end

	if @ContactPersonMailAddress <> ''
	begin
		Set @MailCC = @MailCC + ';'+ @ContactPersonMailAddress
	end
	-- End Of Mail CC Configuration
	
	Select @Initiator=EmployeeName from tblEmployeeInfo Where EmployeeID=@InitiatorID
	Select @AssignedTo=EmployeeName from tblEmployeeInfo Where EmployeeID=@AssignedToID

	Declare @ChaseValueTbl table(
	SLNo int identity(1,1),
	ReportingHead nvarchar(200),
	Value nvarchar(4000),
	AdditionalValue nvarchar(4000),
	Taken Bit default 0
	);

	Set @Count = 1
	Insert into @ChaseValueTbl(ReportingHead,Value,AdditionalValue)
	Select ReportingHead,Value,AdditionalValue from tblChaseInputValues Where GeneratedChaseID=@GeneratedChaseID

	Select @NCount=count(*) from @ChaseValueTbl

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr style=''color:Red;font-weight:bold''>
		<td>Token No:</td>
		<td>'+ right(@GeneratedChaseID,8) +'</td>
	</tr>
	<tr>
		<th>Reporting Head</th>
		<th>Values</th>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Chase'  + '</td>
			<td>' + @ChaseName + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Branch'  + '</td>
			<td>' + @Branch + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Contact Person'  + '</td>
			<td>' + @ContactPerson + '</td>
	</tr>
	<tr style=''color:Red;font-weight:bold''>
			<td>' + 'Priority'  + '</td>
			<td>' + @Priority + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Communication Method'  + '</td>
			<td>' + @ModeOfCommunication + '</td>
	</tr>
	'

	While @Count <= @NCount
	begin
		Select top 1 @ReportingHead=ReportingHead,@Value= Convert(varchar(max),Value)+ convert(varchar(max),AdditionalValue) from @ChaseValueTbl Where Taken=0
		Set @MailBody = @MailBody + 
		'<tr>
			<td>' + @ReportingHead  + '</td>
			<td>' + @Value + '</td>
		</tr>'

		update @ChaseValueTbl Set Taken=1 Where SLNo=@Count 
		Set @Count = @Count + 1
		Set @ReportingHead = ''
		Set @Value = ''
	end
	
	Set @MailBody = @MailBody + 
	'<tr>
		<td>Software Link</td>
		<td><a href='+@SoftWareLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	Set @MailSubject = 'Chaser : Chase Generated By ('+@Initiator+') : Assigned To (' + @AssignedTo + ' )'
	Select @MailFrom = MailAddress from tblEmployeeInfo Where EmployeeID=@InitiatorID
	Select @MailTo = MailAddress from tblEmployeeInfo Where EmployeeID=@AssignedToID
	
	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'Career@ulc.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'Career@ulc.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'Career@ulc.com' else @MailCC end as 'MailCC',
	'Debayan@ulc.com' as 'MailBCC',@SMTPServer as 'SMTPServer',@SMTPPort as 'SMTPPort'

end

GO

alter proc spChaseUpdateMail
@GeneratedChaseID nvarchar(50)
as
begin
	Declare @MailBody as nvarchar(4000) Set @MailBody = ''
	Declare @MailSubject as nvarchar(200) Set @MailSubject = ''
	Declare @MailTo as nvarchar(50) Set @MailTo = ''
	Declare @MailFrom as nvarchar(50) Set @MailFrom =''
	Declare @MailCC as nvarchar(50) Set @MailCC = ''
	Declare @SoftWareLink  as nvarchar(500) Set @SoftWareLink = ''
	Declare @SMTPServer as nvarchar(50) Set @SMTPServer = ''
	Declare @SMTPPort as nvarchar(50) Set @SMTPPort = ''

	Declare @ChaseName as nvarchar(500) Set @ChaseName = ''
	Declare @TempMailAddress as nvarchar(50) Set @TempMailAddress=''
	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
	Declare @Initiator as nvarchar(200) Set @Initiator = ''
	Declare @AssignedTo as nvarchar(200) Set @AssignedTo = ''
	Declare @CurrentSupervisor as nvarchar(50) Set @CurrentSupervisor = ''

	Declare @ChaseDefinitionID as nvarchar(50) set @ChaseDefinitionID = ''
	Declare @InitiatorID as nvarchar(50) Set @InitiatorID = ''
	Declare @AssignedToID as nvarchar(50) Set @AssignedToID = ''
	Declare @InformedParties as nvarchar(4000) Set @InformedParties = ''
	Declare @ReportingHead as nvarchar(200) Set @ReportingHead = ''
	Declare @Value as varchar(max) Set @Value = ''

	Declare @Branch as nvarchar(200) Set @Branch = ''
	Declare @ContactPerson as nvarchar(200) Set @ContactPerson = ''
	Declare @Priority as nvarchar(200) Set @Priority = ''
	Declare @ModeOfCommunication as nvarchar(200) Set @ModeOfCommunication = ''

	Select @SMTPServer=PropertyValue from tblAppSettings Where PropertyName='SMTPServer'
	Select @SMTPPort=PropertyValue from tblAppSettings Where PropertyName='SMTPPort'
	Select @SoftWareLink=PropertyValue from tblAppSettings Where PropertyName='SoftWareLink'

	Select @InitiatorID=InitiatorID,@AssignedToID=AssignedToID,@ChaseDefinitionID=ChaseDefinitionID,@ModeOfCommunication=ModeOfCommunication
	from tblGeneratedChase Where GeneratedChaseID=@GeneratedChaseID
	
	Select @ChaseName=ChaseName from tblChaseDefinition Where ChaseDefinitionID=@ChaseDefinitionID

	Select @Branch = ULCBranchName from tblULCBranch UB Where UB.ULCBranchID in 
	(Select ULCBranchID from tblGeneratedChase GC Where GC.GeneratedChaseID=@GeneratedChaseID)

	Select @Priority = PriorityText from tblPriority P Where P.PriorityID in (
	Select PriorityID from tblGeneratedChase GC Where GC.GeneratedChaseID=@GeneratedChaseID)
	
	Select @ContactPerson=EmployeeName from tblEmployeeInfo EI Where EI.EmployeeID In (Select ContactPersonID from tblGeneratedChase GC Where GC.GeneratedChaseID=@GeneratedChaseID)

	-- Mail CC Configuration
	Declare @EmpTbl table(
	EmployeeID nvarchar(50),
	Taken Bit default 0
	);

	Insert into @EmpTbl(EmployeeID)
	Select EmployeeID from tblInterestedReps Where ChaseDefinitionID=@ChaseDefinitionID And InterestType='Informed'

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount=0

	Select @NCount=Count(*) from @EmpTbl

	While @Count <= @NCount
	begin
		Select top 1 @EmployeeID=EmployeeID from @EmpTbl Where Taken=0 

		Select @TempMailAddress = MailAddress from tblEmployeeInfo Where EmployeeID=@EmployeeID

		if @MailCC = ''
			Set @MailCC = @TempMailAddress
		else
			Set @MailCC = @MailCC + ';'+ @TempMailAddress
		
		Update @EmpTbl Set Taken=1 Where EmployeeID=@EmployeeID
		Set @Count = @Count + 1 
		Set @TempMailAddress = ''
		Set @EmployeeID = ''
	end
	-- End Of Mail CC Configuration
	
	Select @Initiator=EmployeeName from tblEmployeeInfo Where EmployeeID=@InitiatorID
	Select @AssignedTo=EmployeeName from tblEmployeeInfo Where EmployeeID=@AssignedToID

	Declare @ChaseValueTbl table(
	SLNo int identity(1,1),
	ReportingHead nvarchar(200),
	Value nvarchar(4000),
	AdditionalValue nvarchar(4000),
	Taken Bit default 0
	);

	Set @Count = 1
	Insert into @ChaseValueTbl(ReportingHead,Value,AdditionalValue)
	Select ReportingHead,Value,AdditionalValue from tblChaseInputValues Where GeneratedChaseID=@GeneratedChaseID

	Select @NCount=count(*) from @ChaseValueTbl

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>Reporting Head</th>
		<th>Values</th>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Chase'  + '</td>
			<td>' + @ChaseName + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Branch'  + '</td>
			<td>' + @Branch + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Contact Person'  + '</td>
			<td>' + @ContactPerson + '</td>
	</tr>
	<tr style=''color:Red;font-weight:bold''>
			<td>' + 'Priority'  + '</td>
			<td>' + @Priority + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Communication Method'  + '</td>
			<td>' + @ModeOfCommunication + '</td>
	</tr>
	'

	While @Count <= @NCount
	begin
		Select top 1 @ReportingHead=ReportingHead,@Value= Convert(varchar(max),Value)+ convert(varchar(max),AdditionalValue) from @ChaseValueTbl Where Taken=0
		Set @MailBody = @MailBody + 
		'<tr>
			<td>' + @ReportingHead  + '</td>
			<td>' + @Value + '</td>
		</tr>'

		update @ChaseValueTbl Set Taken=1 Where SLNo=@Count 
		Set @Count = @Count + 1
		Set @ReportingHead = ''
		Set @Value = ''
	end
	
	Set @MailBody = @MailBody + 
	'<tr>
		<td>Software Link</td>
		<td><a href='+@SoftWareLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	Set @MailSubject = 'Chaser : Chase Updated By ('+@Initiator+') : Assigned To (' + @AssignedTo + ' )'
	Select @MailFrom = MailAddress from tblEmployeeInfo Where EmployeeID=@InitiatorID
	Select @MailTo = MailAddress from tblEmployeeInfo Where EmployeeID=@AssignedToID
	
	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'Career@ulc.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'Career@ulc.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'Career@ulc.com' else @MailCC end as 'MailCC',
	'Debayan@ulc.com' as 'MailBCC',@SMTPServer as 'SMTPServer',@SMTPPort as 'SMTPPort'

end

GO

alter proc spChaseTerminateMail
@GeneratedChaseID nvarchar(50),
@MasterChaseID nvarchar(50),
@InitiatorID nvarchar(50),
@Remarks nvarchar(500)
as
begin
	Declare @MailBody as nvarchar(4000) Set @MailBody = ''
	Declare @MailSubject as nvarchar(200) Set @MailSubject = ''
	Declare @MailTo as nvarchar(50) Set @MailTo = ''
	Declare @MailFrom as nvarchar(50) Set @MailFrom =''
	Declare @MailCC as nvarchar(50) Set @MailCC = ''
	Declare @SoftWareLink  as nvarchar(500) Set @SoftWareLink = ''
	Declare @SMTPServer as nvarchar(50) Set @SMTPServer = ''
	Declare @SMTPPort as nvarchar(50) Set @SMTPPort = ''
	Declare @Attachment as nvarchar(50) Set @Attachment = ''

	Declare @ChaseName as nvarchar(500) Set @ChaseName = ''
	Declare @Branch as nvarchar(200) Set @Branch = ''
	Declare @ContactPerson as nvarchar(200) Set @ContactPerson = ''
	Declare @Priority as nvarchar(200) Set @Priority = ''
	Declare @ModeOfCommunication as nvarchar(200) Set @ModeOfCommunication = ''

	Declare @ChaseDefinitionID as nvarchar(50) Set @ChaseDefinitionID = ''
	Declare @ContactPersonID as nvarchar(50) Set @ContactPersonID = ''
	Declare @Initiator as nvarchar(200) Set @Initiator = ''
	Declare @CreatorID as nvarchar(50) Set @CreatorID = '' 
	Declare @Creator as nvarchar(200) Set @Creator = ''

	Declare @ReportingHead as nvarchar(200) Set @ReportingHead = ''
	Declare @Value as varchar(max) Set @Value = ''
	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount=0

	Declare @ChaseDescription as nvarchar(1000) Set @ChaseDescription = ''
	Select @ChaseDescription = dbo.fnGetChaseInputValuesDesc(@MasterChaseID)

	Select @SMTPServer=PropertyValue from tblAppSettings Where PropertyName='SMTPServer'
	Select @SMTPPort=PropertyValue from tblAppSettings Where PropertyName='SMTPPort'
	Select @SoftWareLink=PropertyValue from tblAppSettings Where PropertyName='SoftWareLink'

	Select @Attachment=UploadedFile from tblGeneratedChase Where GeneratedChaseID=@GeneratedChaseID

	Select @ModeOfCommunication=ModeOfCommunication,@CreatorID=InitiatorID,@ChaseDefinitionID=ChaseDefinitionID from tblGeneratedChase Where GeneratedChaseID=@MasterChaseID

	Select @ChaseName=ChaseName from tblChaseDefinition Where ChaseDefinitionID=@ChaseDefinitionID

	Select @Branch = ULCBranchName from tblULCBranch UB Where UB.ULCBranchID in 
	(Select ULCBranchID from tblGeneratedChase GC Where GC.GeneratedChaseID=@MasterChaseID)

	Select @Priority = PriorityText from tblPriority P Where P.PriorityID in (
	Select PriorityID from tblGeneratedChase GC Where GC.GeneratedChaseID=@MasterChaseID)
	
	Select @ContactPersonID = ContactPersonID from tblGeneratedChase GC Where GC.GeneratedChaseID=@MasterChaseID

	Select @ContactPerson=EmployeeName from tblEmployeeInfo EI Where EI.EmployeeID=@ContactPersonID

	Select @Initiator= EmployeeName from tblEmployeeInfo EI Where EI.EmployeeID=@InitiatorID

	Select @Creator=EmployeeName from tblEmployeeInfo  EI Where EI.EmployeeID In(
	Select InitiatorID from tblGeneratedChase GC Where GeneratedChaseID = @MasterChaseID)

	Declare @ChaseValueTbl table(
	SLNo int identity(1,1),
	ReportingHead nvarchar(200),
	Value nvarchar(4000),
	AdditionalValue nvarchar(4000),
	Taken Bit default 0
	);

	Set @Count = 1
	Insert into @ChaseValueTbl(ReportingHead,Value,AdditionalValue)
	Select ReportingHead,Value,AdditionalValue from tblChaseInputValues Where GeneratedChaseID=@GeneratedChaseID

	Select @NCount=count(*) from @ChaseValueTbl

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>Reporting Head</th>
		<th>Values</th>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Chase'  + '</td>
			<td>' + @ChaseName + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Chase Description:'  + '</td>
			<td>' + @ChaseDescription + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Branch'  + '</td>
			<td>' + @Branch + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Contact Person'  + '</td>
			<td>' + @ContactPerson + '</td>
	</tr>
	<tr style=''color:Red;font-weight:bold''>
			<td>' + 'Priority'  + '</td>
			<td>' + @Priority + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Communication Method'  + '</td>
			<td>' + @ModeOfCommunication + '</td>
	</tr>'


	While @Count <= @NCount
	begin
		Select top 1 @ReportingHead=ReportingHead,@Value= Convert(varchar(max),Value)+ convert(varchar(max),AdditionalValue) from @ChaseValueTbl Where Taken=0
		Set @MailBody = @MailBody + 
		'<tr>
			<td>' + @ReportingHead  + '</td>
			<td>' + @Value + '</td>
		</tr>'

		update @ChaseValueTbl Set Taken=1 Where SLNo=@Count 
		Set @Count = @Count + 1
		Set @ReportingHead = ''
		Set @Value = ''
	end
	
	Set @MailBody = @MailBody + 

	'<tr>
			<td>' + 'Remarks'  + '</td>
			<td>' + @Remarks + '</td>
	</tr>
	<tr>
		<td>Software Link</td>
		<td><a href='+@SoftWareLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	Set @MailSubject = 'Chaser : Chase Terminated By ('+@Initiator+')'
	Select @MailFrom = MailAddress from tblEmployeeInfo Where EmployeeID=@InitiatorID
	Select @MailCC = MailAddress from tblEmployeeInfo Where EmployeeID=@CreatorID
	Select @MailTo = MailAddress from tblEmployeeInfo Where EmployeeID=@ContactPersonID
	
	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'Career@ulc.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'Career@ulc.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'Career@ulc.com' else @MailCC end as 'MailCC',
	'Debayan@ulc.com' as 'MailBCC',@SMTPServer as 'SMTPServer',@SMTPPort as 'SMTPPort',isnull(@Attachment,'') as 'Attachment'

end

GO

alter proc spChaseForwardMail
@MasterChaseID nvarchar(50),
@InitiatorID nvarchar(50),
@AssignedToID nvarchar(50),
@Remarks nvarchar(500),
@ChaseProgress nvarchar(50)
as
begin
	Declare @MailBody as nvarchar(4000) Set @MailBody = ''
	Declare @MailSubject as nvarchar(200) Set @MailSubject = ''
	Declare @MailTo as nvarchar(50) Set @MailTo = ''
	Declare @MailFrom as nvarchar(50) Set @MailFrom =''
	Declare @MailCC as nvarchar(50) Set @MailCC = ''
	Declare @SoftWareLink  as nvarchar(500) Set @SoftWareLink = ''
	Declare @SMTPServer as nvarchar(50) Set @SMTPServer = ''
	Declare @SMTPPort as nvarchar(50) Set @SMTPPort = ''

	Declare @ChaseName as nvarchar(500) Set @ChaseName = ''
	Declare @ChaseDefinitionID as nvarchar(50) Set @ChaseDefinitionID = ''
	Declare @Branch as nvarchar(200) Set @Branch = ''
	Declare @ContactPerson as nvarchar(200) Set @ContactPerson = ''
	Declare @Priority as nvarchar(200) Set @Priority = ''
	Declare @ModeOfCommunication as nvarchar(200) Set @ModeOfCommunication = ''

	Declare @Initiator as nvarchar(200) Set @Initiator = ''
	Declare @AssignedTo as nvarchar(200) Set @AssignedTo = ''

	Declare @ReportingHead as nvarchar(200) Set @ReportingHead = ''
	Declare @Value as varchar(max) Set @Value = ''
	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount=0

	Select @SMTPServer=PropertyValue from tblAppSettings Where PropertyName='SMTPServer'
	Select @SMTPPort=PropertyValue from tblAppSettings Where PropertyName='SMTPPort'
	Select @SoftWareLink=PropertyValue from tblAppSettings Where PropertyName='SoftWareLink'

	Select @ModeOfCommunication=ModeOfCommunication,@ChaseDefinitionID=ChaseDefinitionID from tblGeneratedChase Where GeneratedChaseID=@MasterChaseID

	Select @ChaseName=ChaseName from tblChaseDefinition Where ChaseDefinitionID=@ChaseDefinitionID

	Select @Branch = ULCBranchName from tblULCBranch UB Where UB.ULCBranchID in 
	(Select ULCBranchID from tblGeneratedChase GC Where GC.GeneratedChaseID=@MasterChaseID)

	Select @Priority = PriorityText from tblPriority P Where P.PriorityID in (
	Select PriorityID from tblGeneratedChase GC Where GC.GeneratedChaseID=@MasterChaseID)
	
	Select @ContactPerson=EmployeeName from tblEmployeeInfo EI Where EI.EmployeeID In (
	Select ContactPersonID from tblGeneratedChase GC Where GC.GeneratedChaseID=@MasterChaseID)

	Select @Initiator= EmployeeName from tblEmployeeInfo EI Where EI.EmployeeID=@InitiatorID
	Select @AssignedTo= EmployeeName from tblEmployeeInfo EI Where EI.EmployeeID=@AssignedToID

	Declare @ChaseValueTbl table(
	SLNo int identity(1,1),
	ReportingHead nvarchar(200),
	Value nvarchar(4000),
	AdditionalValue nvarchar(4000),
	Taken Bit default 0
	);

	Set @Count = 1
	Insert into @ChaseValueTbl(ReportingHead,Value,AdditionalValue)
	Select ReportingHead,Value,AdditionalValue from tblChaseInputValues Where GeneratedChaseID=@MasterChaseID

	Select @NCount=count(*) from @ChaseValueTbl

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>Reporting Head</th>
		<th>Values</th>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Chase'  + '</td>
			<td>' + @ChaseName + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Branch'  + '</td>
			<td>' + @Branch + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Contact Person'  + '</td>
			<td>' + @ContactPerson + '</td>
	</tr>
	<tr style=''color:Red;font-weight:bold''>
			<td>' + 'Priority'  + '</td>
			<td>' + @Priority + '</td>
	</tr>
	<tr style=''color:Green;font-weight:bold''>
			<td>' + 'Communication Method'  + '</td>
			<td>' + @ModeOfCommunication + '</td>
	</tr>'
	
	While @Count <= @NCount
	begin
		Select top 1 @ReportingHead=ReportingHead,@Value= Convert(varchar(max),Value)+ convert(varchar(max),AdditionalValue) from @ChaseValueTbl Where Taken=0
		Set @MailBody = @MailBody + 
		'<tr>
			<td>' + @ReportingHead  + '</td>
			<td>' + @Value + '</td>
		</tr>'

		update @ChaseValueTbl Set Taken=1 Where SLNo=@Count 
		Set @Count = @Count + 1
		Set @ReportingHead = ''
		Set @Value = ''
	end
	
	Set @MailBody = @MailBody + 
	
	'<tr>
			<td>' + 'Remarks'  + '</td>
			<td>' + @Remarks + '</td>
	</tr>
	<tr>
			<td>' + 'Chase Progress'  + '</td>
			<td>' + @ChaseProgress + '</td>
	</tr>
	<tr>
		<td>Software Link</td>
		<td><a href='+@SoftWareLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	Set @MailSubject = 'Chaser : Chase Forwarded By ('+@Initiator+') & Assigned To (' + @AssignedTo + ' )'
	Select @MailFrom = MailAddress from tblEmployeeInfo Where EmployeeID=@InitiatorID
	Select @MailTo = MailAddress from tblEmployeeInfo Where EmployeeID=@AssignedToID
	
	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'Career@ulc.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'Career@ulc.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'Career@ulc.com' else @MailCC end as 'MailCC',
	'Debayan@ulc.com' as 'MailBCC',@SMTPServer as 'SMTPServer',@SMTPPort as 'SMTPPort'

end

GO

Create proc spGetGenChaseInfoByID
@MasterChaseID nvarchar(50)
as
begin
	
	Declare @ChaseDefinitionID as nvarchar(50) Set @ChaseDefinitionID = ''

	Select @ChaseDefinitionID=ChaseDefinitionID from tblGeneratedChase Where MasterChaseID=@MasterChaseID

	Select @ChaseDefinitionID as 'ChaseDefinitionID'

end

exec spGetGenChaseInfoByID 'GEN-C-00000068'

GO

Create function fnGetBranchNameByID(@ULCBranchID nvarchar(50))
returns nvarchar(200)
as
begin
	Declare @ULCBranchName as nvarchar(200) Set @ULCBranchName = ''

	Select @ULCBranchName=ULCBranchName from tblULCBranch Where ULCBranchID=@ULCBranchID

	return @ULCBranchName
end

GO

alter proc spGetChaseContactDetails
@GeneratedChaseID nvarchar(50)
as
begin
	
	Declare @ContactPerson as nvarchar(200) Set @ContactPerson = ''
	Declare @Branch as nvarchar(50) Set @Branch = ''
	Declare @Email as nvarchar(50) Set @Email = ''
	Declare @MobileNo as nvarchar(50) Set @MobileNo = ''
	Declare @ContactStr as nvarchar(1000) Set @ContactStr = ''
	Declare @MasterChaseID nvarchar(50) Set @MasterChaseID = ''

	Select @MasterChaseID = MasterChaseID from tblGeneratedChase Where GeneratedChaseID=@GeneratedChaseID

	Select @ContactPerson = dbo.fnGetEmpNameByID( Isnull(ContactPersonID,InitiatorID)),
	@Branch = isnull( dbo.fnGetBranchNameByID(ULCBranchID),'N\A'),
	@Email = (Select MailAddress from tblEmployeeInfo Where EmployeeID= Isnull(ContactPersonID,InitiatorID)),
	@MobileNo = (Select MobileNo from tblEmployeeInfo Where EmployeeID= Isnull(ContactPersonID,InitiatorID))
	from tblGeneratedChase Where GeneratedChaseID=@MasterChaseID

	Set @ContactStr = @ContactPerson + ' | ' + @Branch + ' | ' + @Email + ' | ' + @MobileNo

	Select @ContactStr as 'ContactStr'

end

-- exec spGetChaseContactDetails 'GEN-C-00000081'

GO

alter proc spGetContactInfoByMasterID
@MasterChaseID nvarchar(50)
as
begin
	
	Declare @ULCBranchID as nvarchar(50) Set @ULCBranchID = ''
	Declare @ContactPersonID as nvarchar(50) Set @ContactPersonID = ''

	Select @ULCBranchID=isnull(ULCBranchID,'N\A'), @ContactPersonID=isnull(ContactPersonID,'N\A') 
	from tblGeneratedChase Where GeneratedChaseID=@MasterChaseID

	Select @ULCBranchID as 'ULCBranchID',@ContactPersonID as 'ContactPersonID'

end

-- exec spGetContactInfoByMasterID 'GEN-C-00000089'
GO

Create proc spUpdateContactInfoByMasterID
@MasterChaseID nvarchar(50),
@ULCBranchID nvarchar(50),
@ContactPersonID nvarchar(50)
as
begin
	
	if @ULCBranchID = 'N\A'
		Set @ULCBranchID = null

	if @ContactPersonID = 'N\A'
		Set @ContactPersonID = null

	Update tblGeneratedChase Set ULCBranchID=@ULCBranchID,ContactPersonID=@ContactPersonID 
	Where GeneratedChaseID=@MasterChaseID

end


