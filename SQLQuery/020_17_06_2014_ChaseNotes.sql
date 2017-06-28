
Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentChaseNoteID',0)

GO

Create table tblChaseNotes(
ChaseNoteID nvarchar(50) primary key,
GeneratedChaseID nvarchar(50) foreign key references tblGeneratedChase(GeneratedChaseID),
MasterChaseID nvarchar(50),
Notes nvarchar(4000),
Attachments nvarchar(200),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
)

GO


alter proc spInsertChaseNotes
@GeneratedChaseID nvarchar(50),
@MasterChaseID nvarchar(50),
@Notes nvarchar(4000),
@Attachments nvarchar(200),
@EntryBy nvarchar(50)
as
begin
	Declare @ChaseNoteID nvarchar(50)
	Declare @CurrentChaseNoteID numeric(18,0)
	Declare @ChaseNoteIDPrefix as nvarchar(3)

	set @ChaseNoteIDPrefix='CN-'

begin tran
	
	select @CurrentChaseNoteID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentChaseNoteID'
	
	set @CurrentChaseNoteID=isnull(@CurrentChaseNoteID,0)+1
	Select @ChaseNoteID=dbo.generateID(@ChaseNoteIDPrefix,@CurrentChaseNoteID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblChaseNotes(ChaseNoteID,GeneratedChaseID,MasterChaseID,Notes,Attachments,EntryBy)
	Values(@ChaseNoteID,@GeneratedChaseID,@MasterChaseID,@Notes,@Attachments,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentChaseNoteID where PropertyName='CurrentChaseNoteID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end


GO

alter proc spGetMasterChaseWiseNotes
@MasterChaseID nvarchar(50)
as
begin
	Select ChaseNoteID,Notes,isnull(Attachments,'N\A') as 'Attachments',EntryBy,EntryDate as 'Dated' 
	from tblChaseNotes Where MasterChaseID=@MasterChaseID
	order by EntryDate asc
end

GO

alter proc spChaseAddNotesMail
@MasterChaseID nvarchar(50),
@GeneratedChaseID nvarchar(50),
@Notes nvarchar(4000)
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

	Declare @InitiatorID as nvarchar(50) Set @InitiatorID = ''
	Declare @Initiator as nvarchar(200) Set @Initiator = ''
	Declare @AssignedToID as nvarchar(50) Set @AssignedToID = ''
	Declare @AssignedTo as nvarchar(50) Set @AssignedTo = ''
	Declare @CreatorID as nvarchar(50) Set @CreatorID = ''

	Select @SMTPServer=PropertyValue from tblAppSettings Where PropertyName='SMTPServer'
	Select @SMTPPort=PropertyValue from tblAppSettings Where PropertyName='SMTPPort'
	Select @SoftWareLink=PropertyValue from tblAppSettings Where PropertyName='SoftWareLink'

	Select @ChaseName=ChaseName from tblChaseDefinition Where ChaseDefinitionID =
	(Select ChaseDefinitionID from tblGeneratedChase Where MasterChaseID = @MasterChaseID)

	Select @InitiatorID=InitiatorID,@AssignedToID=AssignedToID from tblGeneratedChase Where GeneratedChaseID=@GeneratedChaseID

	Select @Initiator= EmployeeName from tblEmployeeInfo EI Where EI.EmployeeID=@InitiatorID
	Select @AssignedTo= EmployeeName from tblEmployeeInfo EI Where EI.EmployeeID=@AssignedToID

	Select @CreatorID=InitiatorID from tblGeneratedChase GC Where GeneratedChaseID = @MasterChaseID

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>Reporting Head</th>
		<th>Values</th>
	</tr>
	<tr>
		<td>Chase</td>	
		<td>' + @ChaseName + '</td>
	</tr>
	<tr>
		<td>Notes</td>	
		<td>' + @Notes + '</td>
	</tr>
	<tr>
		<td>Software</td>
		<td><a href='+@SoftWareLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	Set @MailSubject = 'Chaser : Notes Added By ('+@Initiator+')'
	Select @MailFrom = MailAddress from tblEmployeeInfo Where EmployeeID=@AssignedToID
	Select @MailTo = MailAddress from tblEmployeeInfo Where EmployeeID=@InitiatorID
	Select @MailCC = MailAddress from tblEmployeeInfo Where EmployeeID=@CreatorID
	
	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'Career@ulc.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'Career@ulc.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'Career@ulc.com' else @MailCC end as 'MailCC',
	'Debayan@ulc.com' as 'MailBCC',@SMTPServer as 'SMTPServer',@SMTPPort as 'SMTPPort'

end
