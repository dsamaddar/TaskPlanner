
alter function fnGetDeptCodeByEmp(@EmployeeID nvarchar(50))
returns nvarchar(50)
begin
	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''
	Declare @DeptCode as nvarchar(50) Set @DeptCode = ''

	Select @DepartmentID = DepartmentID from tblEmployeeInfo Where EmployeeID=@EmployeeID

	Select @DeptCode = isnull(DeptCode,'N\A') from tblDepartment Where DepartmentID=@DepartmentID

	return Isnull(@DeptCode,'N\A')
end

-- Select dbo.fnGetDeptCodeByEmp('EMP-00000278')

GO

alter function fnFetchClientName(@ClientCode nvarchar(50),@DeptCode nvarchar(50))
returns nvarchar(200)
as
begin
	Declare @ClientName as nvarchar(200) Set @ClientName = ''
	Declare @CustomerId as int 

	Select @CustomerId = CustomerId from tblCustomerUserRelation Where UserId=@DeptCode And CustomerCode=@ClientCode

	Select @ClientName = CustomerName from tblCustomer Where CustomerId=@CustomerId

	return isnull(@ClientName,'UnRecognized')
end

GO

-- exec [spGetMktInfoByEmpID] 'EMP-00000278'

ALTER proc [dbo].[spGetMktInfoByEmpID]
@EmployeeID nvarchar(50)
as
begin
	
	Declare @DeptCode as nvarchar(50) Set @DeptCode = ''
	Set @DeptCode = dbo.fnGetDeptCodeByEmp(@EmployeeID)

	Select 
	dbo.fnFetchClientName(ClientCode,@DeptCode) +' ['+CPDesignation+'] ['+ CONVERT(nvarchar,EntryDate,106)+']' as 'Client',
	Attachment 
	from tblMarketInfo Where EmployeeID=@EmployeeID
	order by EntryDate desc

end


GO

-- exec spMktInfoFilterReport '1/1/1900','1/1/1900','N\A','N\A','All'

alter proc spMktInfoFilterReport
@DateFrom datetime,
@DateTo datetime,
@DataStatus nvarchar(50),
@CPDesignation nvarchar(50),
@Status nvarchar(50)
as
begin

	Declare @StatusParam as nvarchar(50) Set @StatusParam = ''
	Declare @DataStatusParam as nvarchar(50) Set @DataStatusParam = ''
	Declare @CPDesignationParam as nvarchar(50) Set @CPDesignationParam= ''
	
	If @Status = 'All'
		Set @StatusParam = '%'
	Else If @Status = 'Unrated'
		Set @StatusParam = 'Unrated'
	Else If @Status = '1'
		Set @StatusParam = '1'
	Else If @Status = '2'
		Set @StatusParam = '2'
	Else If @Status = '3'
		Set @StatusParam = '3'

	if @DataStatus = 'N\A'
		Set @DataStatusParam = '%'
	Else
		Set @DataStatusParam = '%' + @DataStatus + '%'

	If @CPDesignation = 'N\A'
		Set @CPDesignationParam = '%'
	Else
		Set @CPDesignationParam = '%' + @CPDesignation + '%'

	if @DateFrom = '1/1/1900' And @DateTo='1/1/1900'
	begin
		Select MI.MarketInfoID,EI.EmployeeName as 'RE',MI.ClientCode,dbo.fnFetchClientName(MI.ClientCode,dbo.fnGetDeptCodeByEmp(MI.EmployeeID)) as 'Client',
		MI.Remarks,MI.CPDesignation,MI.DataStatus,MI.PrimaryRating,MI.PrimaryRemarks,MI.Status,MI.Attachment,
		Convert(nvarchar,MI.EntryDate,106) as 'Dated'
		from tblMarketInfo MI Left Join tblEmployeeInfo EI On MI.EmployeeID=EI.EmployeeID
		Where MI.CPDesignation like @CPDesignationParam
		And MI.DataStatus like @DataStatusParam
		And MI.[Status] like @StatusParam
	end
	else
	begin
		Select MI.MarketInfoID,EI.EmployeeName as 'RE',MI.ClientCode,dbo.fnFetchClientName(ClientCode,dbo.fnGetDeptCodeByEmp(MI.EmployeeID)) as 'Client',
		MI.Remarks,MI.CPDesignation,MI.DataStatus,MI.PrimaryRating,MI.PrimaryRemarks,MI.Status,MI.Attachment,
		Convert(nvarchar,MI.EntryDate,106) as 'Dated'
		from tblMarketInfo MI Left Join tblEmployeeInfo EI On MI.EmployeeID=EI.EmployeeID
		Where MI.CPDesignation like @CPDesignationParam
		And MI.DataStatus like @DataStatusParam
		And MI.[Status] like @StatusParam
		And MI.EntryDate between @DateFrom And @DateTo
	end

end

ALTER proc [dbo].[spGetPendingMktInfoPrimaryRating]
as
begin
	Select MI.MarketInfoID,EI.EmployeeName as 'RE'
	,(Select ULCBranchName from tblULCBranch UB Where UB.ULCBranchID=EI.ULCBranchID ) as 'Branch'
	,dbo.fnFetchClientName(ClientCode,dbo.fnGetDeptCodeByEmp(MI.EmployeeID)) as 'Client',
	DataStatus,CPDesignation,Remarks,Attachment
	from tblMarketInfo MI Left Join tblEmployeeInfo EI ON MI.EmployeeID=EI.EmployeeID
	Where IsPrimaryRatingDone=0
end

exec [spGetPendingMktInfoPrimaryRating]

GO

-- Select * from tblMarketInfo

alter proc spPrimaryRatingMktInfo
@MarketInfoID nvarchar(50),
@PrimaryRating nvarchar(50),
@PrimaryRemarks nvarchar(50)
as
begin
	
	Update tblMarketInfo Set PrimaryRating=@PrimaryRating,PrimaryRemarks=@PrimaryRemarks,Status=@PrimaryRating,
	IsPrimaryRatingDone=1
	Where MarketInfoID = @MarketInfoID

end