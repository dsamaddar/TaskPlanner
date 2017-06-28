
GO

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentEmployeeID',0)

GO

-- drop table tblEmployeeInfo
CREATE TABLE tblEmployeeInfo(
EmployeeID nvarchar(50) primary key,
UserID nvarchar(50) unique(UserID),
UserPassword nvarchar(50) ,
UserType nvarchar(50) ,
EmployeeName nvarchar(200) ,
EmpCode nvarchar(50) unique(EmpCode),
DateOfBirth datetime,
JoiningDate datetime ,
DesignationID nvarchar(50) foreign key references tblDesignation(DesignationID),
DepartmentID nvarchar(50) foreign key references tblDepartment(DepartmentID),
ULCBranchID nvarchar(50) foreign key references tblULCBranch(ULCBranchID),
CurrentSupervisor nvarchar(50),
EmpStatus nvarchar(50),
MobileNo nvarchar(50),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
)

GO

alter proc spGetActiveEmpList
as
begin
	Select EmployeeID, upper(EmployeeName)+ ' ('+isnull(EmpCode,'N\A')+')' as 'EmployeeName' from tblEmployeeInfo Where EmpStatus='Active'
	Order by EmployeeName
end

exec spGetActiveEmpList

GO

alter proc spInsertEmployeeInfo
@UserID nvarchar(50),
@UserPassword nvarchar(50) ,
@UserType nvarchar(50) ,
@EmployeeName nvarchar(200) ,
@EmpCode nvarchar(50),
@DateOfBirth datetime,
@JoiningDate datetime ,
@DesignationID nvarchar(50),
@DepartmentID nvarchar(50),
@ULCBranchID nvarchar(50),
@CurrentSupervisor nvarchar(50),
@EmpStatus nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @EmployeeID nvarchar(50)
	Declare @CurrentEmployeeID numeric(18,0)
	Declare @EmployeeIDPrefix as nvarchar(4)

	set @EmployeeIDPrefix='EMP-'

begin tran
	
	select @CurrentEmployeeID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentEmployeeID'
	
	set @CurrentEmployeeID=isnull(@CurrentEmployeeID,0)+1
	Select @EmployeeID=dbo.generateID(@EmployeeIDPrefix,@CurrentEmployeeID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblEmployeeInfo(EmployeeID,UserID,UserPassword,UserType,EmployeeName,EmpCode,DateOfBirth,
	JoiningDate,DesignationID,DepartmentID,ULCBranchID,CurrentSupervisor,EmpStatus,IsActive,EntryBy)
	Values(@EmployeeID,@UserID,@UserPassword,@UserType,@EmployeeName,@EmpCode,
	@DateOfBirth,@JoiningDate,@DesignationID,@DepartmentID,@ULCBranchID,@CurrentSupervisor,@EmpStatus,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentEmployeeID where PropertyName='CurrentEmployeeID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spUpdateEmpInfo
@EmployeeID nvarchar(50),
@UserID nvarchar(50),
@UserPassword nvarchar(50) ,
@UserType nvarchar(50) ,
@EmployeeName nvarchar(200) ,
@EmpCode nvarchar(50),
@DateOfBirth datetime,
@JoiningDate datetime ,
@DesignationID nvarchar(50),
@DepartmentID nvarchar(50),
@ULCBranchID nvarchar(50),
@CurrentSupervisor nvarchar(50),
@EmpStatus nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin

	if @DesignationID = 'N\A'
		Set @DesignationID = null

	if @DepartmentID = 'N\A'
		Set @DepartmentID = null

	if @ULCBranchID = 'N\A'
		Set @ULCBranchID = null

	if @CurrentSupervisor = 'N\A'
		Set @CurrentSupervisor = null
	
	Update tblEmployeeInfo Set UserID=@UserID,UserPassword=@UserPassword,UserType=@UserType,EmployeeName=@EmployeeName,
	EmpCode=@EmpCode,DateOfBirth=@DateOfBirth,JoiningDate=@JoiningDate,DesignationID=@DesignationID,
	DepartmentID=@DepartmentID,ULCBranchID=@ULCBranchID,CurrentSupervisor=@CurrentSupervisor,EmpStatus=@EmpStatus,
	IsActive=@IsActive,EntryBy=@EntryBy
	Where EmployeeID=@EmployeeID

end

GO

alter proc spCheckUserLogin
@UserID nvarchar(50),
@UserPassword nvarchar(50)
as
begin
	Select EmployeeID,UserID,UserType,EmployeeName,isnull(dbo.fnGetUserPermission(EmployeeID),'') as 'PermittedMenus' from tblEmployeeInfo
	Where UserID=@UserID And EmpStatus='Active'
end

-- exec spCheckUserLogin 'tahmed','tamim133'

-- Select * from tblEmployeeInfo Where UserID='dsamaddar' And UserPassword='dsamaddar'

GO

alter proc spGetAllEmpDetails
as
begin
	Select EI.EmployeeID,EI.UserID,EI.UserPassword,EI.UserType,EI.EmployeeName,EI.EmpCode,
	Convert(nvarchar,Isnull(EI.DateOfBirth,'1/1/1900'),106) as 'DateOfBirth',Convert(nvarchar,isnull(EI.JoiningDate,'1/1/1900'),106) as 'JoiningDate',
	isnull(DesignationID,'N\A') as 'DesignationID',
	isnull((Select DesignationName from tblDesignation D Where D.DesignationID=EI.DesignationID) ,'N\A')as 'Designation',
	isnull(EI.DepartmentID,'N\A') as 'DepartmentID',
	isnull((Select DeptName from tblDepartment DD Where DD.DepartmentID=EI.DepartmentID),'N\A') as 'Department',
	isnull(EI.ULCBranchID,'N\A') as 'ULCBranchID',
	isnull((Select ULCBranchName from tblULCBranch UB Where UB.ULCBranchID=EI.ULCBranchID),'N\A') as 'Branch',
	isnull(EI.CurrentSupervisor,'N\A') as 'CurrentSupervisor',
	isnull((Select EmployeeName from tblEmployeeInfo E Where E.EmployeeID=EI.CurrentSupervisor),'N\A') as 'Supervisor',
	EmpStatus,isnull(EI.MailAddress,'') as 'MailAddress',isnull(EI.MobileNo,'N\A') as 'MobileNo',
	Case IsActive When 1 Then 'YES' Else 'No' end as 'IsActive'
	,EntryBy,EntryDate
	from tblEmployeeInfo EI
	order by EI.EmpCode
end

exec spGetAllEmpDetails


GO

alter proc spGetEmployeeList
as
begin
	SELECT EmployeeID,EmployeeName + ' ( ' + isnull(EmpCode,'N\A') + ' )' as 'EmployeeName'
	FROM tblEmployeeInfo where IsActive =1
	order by EmployeeName
End

-- exec spGetEmployeeList

GO

alter proc spGetEmpDetailsByID
@EmployeeID nvarchar(50)
as
begin
	Select EmployeeName,UserID,EmpCode,EI.MailAddress,EI.MobileNo,
	Isnull((Select DesignationName from tblDesignation D Where D.DesignationID=EI.EmployeeID),'N\A') as 'Designation',
	Isnull((Select DeptName from tblDepartment DE Where DE.DepartmentID=EI.DepartmentID),'N\A') as 'Department',
	Isnull((Select ULCBranchName from tblULCBranch UB Where UB.ULCBranchID=EI.ULCBranchID),'N\A') as 'ULCBranchName',
	Isnull((Select EmployeeName from tblEmployeeInfo E Where E.EmployeeID=EI.CurrentSupervisor),'N\A') as 'Supervisor'
	from tblEmployeeInfo EI Where EmployeeID=@EmployeeID
end

exec spGetEmpDetailsByID 'EMP-00000020'

Select * from tblEmployeeInfo