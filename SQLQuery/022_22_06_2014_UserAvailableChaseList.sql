

alter proc spGetChaseDefListActiveByCatByUsr
@CategoryID nvarchar(50),
@SubCategoryID nvarchar(50),
@EmployeeID nvarchar(50)
as
begin

	Declare @CategoryIDParam as nvarchar(50) Set @CategoryIDParam = ''
	Declare @SubCategoryIDParam as nvarchar(50) Set @SubCategoryIDParam = ''
	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''

	Select @DepartmentID=DepartmentID from tblEmployeeInfo Where EmployeeID=@EmployeeID


	if 	@CategoryID = 'N\A'
		Set @CategoryIDParam = '%'
	else
		Set @CategoryIDParam = '%'+ @CategoryID +'%'
		
	if 	@SubCategoryID = 'N\A'
		Set @SubCategoryIDParam = '%'
	else
		Set @SubCategoryIDParam = '%'+ @SubCategoryID +'%'

	Select ChaseDefinitionID,ChaseName from tblChaseDefinition CD Where IsActive=1 
	And CategoryID like @CategoryIDParam And ( SubCategoryID like @SubCategoryIDParam or SubCategoryID is null)
	And ChaseDefinitionID in (Select ChaseDefinitionID from tblChaseOpenForDept O Where O.DepartmentID=@DepartmentID)
	order by ChaseName

end

-- exec spGetChaseDefListActiveByCatByUsr 'CAT-00000005','N\A','EMP-00000020'

GO

Create proc spGetChaseInstruction
@ChaseDefinitionID nvarchar(50)
as
begin
	Select isnull(PrimarySupportRep,'N\A') as 'PrimarySupportRep',Isnull(EI.EmployeeName,'N\A') as 'EmployeeName',
	isnull(ChaseInstruction,'N\A') as 'ChaseInstruction' from tblChaseDefinition CD Left Join tblEmployeeInfo EI On CD.PrimarySupportRep=EI.EmployeeID
	Where ChaseDefinitionID=@ChaseDefinitionID
end

GO

alter proc spRespChngMail
@ChaseDefinitionID nvarchar(50),
@InitiatorID nvarchar(50),
@AssignedToID nvarchar(50)
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
	Declare @Initiator as nvarchar(200) Set @Initiator = ''
	Declare @AssignedTo as nvarchar(200) Set @AssignedTo = ''
	Declare @SupervisorID as nvarchar(50) Set @SupervisorID = ''

	Select @SMTPServer=PropertyValue from tblAppSettings Where PropertyName='SMTPServer'
	Select @SMTPPort=PropertyValue from tblAppSettings Where PropertyName='SMTPPort'
	Select @SoftWareLink=PropertyValue from tblAppSettings Where PropertyName='SoftWareLink'

	Select @Initiator=EmployeeName from tblEmployeeInfo Where EmployeeID=@InitiatorID
	Select @AssignedTo=EmployeeName from tblEmployeeInfo Where EmployeeID=@AssignedToID
	Select @ChaseName=ChaseName from tblChaseDefinition Where ChaseDefinitionID=@ChaseDefinitionID
	
	Select @SupervisorID=CurrentSupervisor from tblEmployeeInfo Where EmployeeID=@InitiatorID

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
	<tr>
			<td>' + 'Prev. Rep'  + '</td>
			<td>' + @Initiator + '</td>
	</tr>
	<tr>
			<td>' + 'New Rep.'  + '</td>
			<td>' + @AssignedTo + '</td>
	</tr>
	<tr>
		<td>Software Link</td>
		<td><a href='+@SoftWareLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	Set @MailSubject = 'Chaser : Responsibility Change: From ('+@Initiator+') To (' + @AssignedTo + ' )'
	Select @MailFrom = MailAddress from tblEmployeeInfo Where EmployeeID=@InitiatorID
	Select @MailTo = MailAddress from tblEmployeeInfo Where EmployeeID=@AssignedToID
	Select @MailCC = MailAddress from tblEmployeeInfo Where EmployeeID=@SupervisorID
	
	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'Career@ulc.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'Career@ulc.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'Career@ulc.com' else @MailCC end as 'MailCC',
	'Debayan@ulc.com' as 'MailBCC',@SMTPServer as 'SMTPServer',@SMTPPort as 'SMTPPort'
end

