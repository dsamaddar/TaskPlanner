
/* For HRM DataBase */

alter proc spGetEmpInfoForChaser
@EmployeeID nvarchar(50)
as
begin
	Select EI.EmployeeID,EI.UserID,EI.UserType,EI.EmployeeName,isnull(EI.EmpCode,'') as 'EmpCode',isnull(EI.DateOfBirth,'1/1/1900') as 'DateOfBirth',
	isnull(EI.JoiningDate,'1/1/1900') as 'JoiningDate',isnull(EI.OfficialDesignationID,'N\A') as 'OfficialDesignationID',
	isnull(EI.DepartmentID,'N\A') as 'DepartmentID',isnull(EI.ULCBranchID,'N\A') as 'ULCBranchID',
	isnull(EI.CurrentSupervisor,'N\A') as 'CurrentSupervisor',isnull(EI.Status,'Active') as 'Status',
	isnull(EI.Email,'') as 'MailAddress',EB.MobileNo,EI.IsActive
	from tblEmployeeInfo EI Left Join tblEmployeeBasicInfo EB On EI.EmployeeID=EB.EmployeeID
	Where EI.EmployeeID=@EmployeeID --And isActive=1
end

-- exec spGetEmpInfoForChaser 'EMP-00000270'

GO

alter proc spGetNewlyAddedEmp
@EmpIDList nvarchar(4000)
as
begin
	
	Declare @EmpTbl table(
	EmployeeID nvarchar(50)
	);
	Insert into @EmpTbl(EmployeeID)
	Select 'EMP-0000'+Value from dbo.Split(',',@EmpIDList)

	Select EI.EmployeeID,EI.UserID,EI.Password as 'UserPassword',EI.UserType,EI.EmployeeName,isnull(EI.EmpCode,'') as 'EmpCode',
	Convert(nvarchar,Isnull(EI.DateOfBirth,'1/1/1900'),106) as 'DateOfBirth',Convert(nvarchar,isnull(EI.JoiningDate,'1/1/1900'),106) as 'JoiningDate',
	isnull(EI.OfficialDesignationID,'N\A') as 'DesignationID',
	isnull((Select DesignationName from tblDesignation D Where D.DesignationID=EI.OfficialDesignationID) ,'N\A')as 'Designation',
	isnull(EI.DepartmentID,'N\A') as 'DepartmentID',
	isnull((Select DeptName from tblDepartment DD Where DD.DepartmentID=EI.DepartmentID),'N\A') as 'Department',
	isnull(EI.ULCBranchID,'N\A') as 'ULCBranchID',
	isnull((Select ULCBranchName from tblULCBranch UB Where UB.ULCBranchID=EI.ULCBranchID),'N\A') as 'Branch',
	isnull(EI.CurrentSupervisor,'N\A') as 'CurrentSupervisor',
	isnull((Select EmployeeName from tblEmployeeInfo E Where E.EmployeeID=EI.CurrentSupervisor),'N\A') as 'Supervisor',
	isnull(EI.Status,'Active') as 'EmpStatus',isnull(EB.Email,'') as 'MailAddress',isnull(EB.MobileNo,'N\A') as 'MobileNo',
	Case IsActive When 1 Then 'YES' Else 'No' end as 'IsActive',
	isnull(EI.EntryBy,'system') as 'EntryBy',EI.EntryDate
	from tblEmployeeInfo EI Left Join tblEmployeeBasicInfo EB On EI.EmployeeID=EB.EmployeeID
	Where EI.EmployeeID not in (Select EmployeeID from @EmpTbl)
	
	order by EI.EmpCode
		
end

exec spGetNewlyAddedEmp '0002,0003,0005,0006,0007,0008,0009,0010,0011,0012,0013,0016,0017,0018,0019,0020,0021,0022,0023,0024,0025,0026,0027,0028,0029,0030,0031,0032,0033,0034,0035,0036,0037,0038,0039,0040,0041,0042,0043,0044,0045,0046,0047,0048,0049,0050,0051,0052,0053,0054,0055,0056,0057,0058,0059,0060,0061,0062,0063,0064,0065,0066,0067,0068,0069,0070,0071,0072,0074,0075,0076,0077,0078,0079,0080,0081,0082,0083,0084,0085,0087,0088,0089,0090,0091,0092,0093,0094,0095,0096,0097,0098,0099,0100,0101,0102,0103,0104,0105,0106,0107,0108,0109,0110,0111,0112,0113,0114,0115,0116,0117,0118,0119,0120,0121,0122,0123,0124,0125,0126,0127,0128,0129,0130,0131,0132,0133,0134,0135,0136,0137,0138,0139,0140,0141,0142,0143,0144,0145,0146,0147,0148,0149,0150,0151,0152,0153,0154,0155,0156,0157,0158,0159,0160,0161,0162,0163,0164,0165,0166,0167,0168,0169,0170,0171,0172,0173,0174,0175,0176,0177,0178,0179,0180,0181,0182,0183,0184,0185,0186,0187,0188,0189,0190,0191,0192,0193,0194,0195,0196,0197,0198,0199,0200,0201,0202,0203,0204,0205,0206,0207,0208,0209,0210,0211,0212,0213,0214,0215,0216,0217,0218,0219,0220,0221,0222,0223,0224,0225,0226,0227,0228,0229,0230,0231,0232,0233,0234,0235,0236,0237,0238,0239,0240,0243,0244,0245,0246,0247,0248,0249,0250,0251,0252,0253,0254,0255,0256,0257,0258,0259,0260,0261,0262,0263,0264,0265,0266,0267,0268,0269,0270,0271,0272,0273,0275,0277,0278,0281,0282,0283,0284,0286,0287,0288,0289,0290,0291,0292,0293,0294,0295,0296,0300,0301,0302,0304,0305,0306,0307,0308,0310,0311,0312,0313,0314,0315,0316,0317,0318,0319,0320,0321,0322,0323,0324,0325,0326,0327,0328,0329,0330,0331,0332,0333,0334,0335,0336,0337,0338,0339,0340,0341,0342,0343,0344,0345,0346,0347,0348,0349,0350,0351,0352,0353,0354,0355,0356,0388,0390'

/* End For HRM DataBase */

GO

-- drop proc spSyncEmpInfo
alter proc spSyncEmpInfo
@EmployeeID nvarchar(50),
@UserID nvarchar(50),
@UserType nvarchar(50),
@EmployeeName nvarchar(200),
@EmpCode nvarchar(50),
@DateOfBirth datetime,
@JoiningDate datetime,
@DesignationID nvarchar(50),
@DepartmentID nvarchar(50),
@ULCBranchID nvarchar(50),
@CurrentSupervisor nvarchar(50),
@EmpStatus nvarchar(50),
@MailAddress nvarchar(50),
@MobileNo nvarchar(50),
@IsActive bit
as
begin
	
	if @DesignationID = 'N\A'
		Set @DesignationID = null

	if @DepartmentID = 'N\A'
		Set  @DepartmentID = null

	if @ULCBranchID = 'N\A'
		Set @ULCBranchID = null

	if @CurrentSupervisor = 'N\A'
		Set @CurrentSupervisor = null


	Update tblEmployeeInfo Set UserID=@UserID,UserType=@UserType,EmployeeName=@EmployeeName,EmpCode=@EmpCode,
	DateOfBirth=@DateOfBirth,JoiningDate=@JoiningDate,DesignationID=@DesignationID,
	DepartmentID=@DepartmentID,ULCBranchID=@ULCBranchID,CurrentSupervisor=@CurrentSupervisor,
	EmpStatus=@EmpStatus,MailAddress=@MailAddress,MobileNo=@MobileNo,IsActive=@IsActive
	Where EmployeeID=@EmployeeID

end

GO

-- drop proc spGetAllEmpIDList
alter proc spGetAllEmpIDList
as
begin
	Declare @EmpIDList as nvarchar(4000) Set @EmpIDList = ''
	Select @EmpIDList = @EmpIDList + RIGHT(EmployeeID,4)+',' from tblEmployeeInfo

	Set @EmpIDList = SUBSTRING( @EmpIDList,0,len(@EmpIDList))

	Select @EmpIDList as 'EmpIDList'
end

exec spGetAllEmpIDList

GO

Create proc spAddNewlyAddedEmp
@EmployeeID nvarchar(50),
@UserID nvarchar(50),
@UserPassword nvarchar(50),
@UserType nvarchar(50),
@EmployeeName nvarchar(200),
@EmpCode nvarchar(50),
@DateOfBirth datetime,
@JoiningDate datetime,
@DesignationID nvarchar(50),
@DepartmentID nvarchar(50),
@ULCBranchID nvarchar(50),
@CurrentSupervisor nvarchar(50),
@EmpStatus nvarchar(50),
@MailAddress nvarchar(50),
@MobileNo nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin

	if not exists (Select * from tblDesignation Where DesignationID=@DesignationID)
		Set @DesignationID = null

	if not exists(Select * from tblDepartment Where DepartmentID=@DepartmentID)
		Set @DepartmentID = null

	if not exists (Select * from tblULCBranch Where ULCBranchID=@ULCBranchID)
		Set @ULCBranchID = null

	if not exists(Select * from tblEmployeeInfo Where EmployeeID=@CurrentSupervisor)
		Set @CurrentSupervisor = null

	
	Insert into tblEmployeeInfo(EmployeeID,UserID,UserPassword,UserType,EmployeeName,EmpCode,DateOfBirth,
	JoiningDate,DesignationID,DepartmentID,ULCBranchID,CurrentSupervisor,EmpStatus,MailAddress,MobileNo,
	IsActive,EntryBy)
	Values(@EmployeeID,@UserID,@UserPassword,@UserType,@EmployeeName,@EmpCode,@DateOfBirth,
	@JoiningDate,@DesignationID,@DepartmentID,@ULCBranchID,@CurrentSupervisor,@EmpStatus,@MailAddress,@MobileNo,
	@IsActive,@EntryBy)

end