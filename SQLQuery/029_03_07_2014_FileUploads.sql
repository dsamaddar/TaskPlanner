
Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentMarketInfoID',0)

-- drop table tblMarketInfo
Create table tblMarketInfo(
MarketInfoID nvarchar(50) primary key,
EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
Client nvarchar(200),
DataStatus nvarchar(50),
CPDesignation nvarchar(50),
Remarks nvarchar(50),
Attachment nvarchar(200),
IsPrimaryRatingDone bit default 0,
PrimaryRating nvarchar(50),
PrimaryRemarks nvarchar(500),
IsFinalRatingDone bit default 0,
FinalRating nvarchar(50),
FinalRemarks nvarchar(500),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

alter proc spInsertMarketInfo
@EmployeeID nvarchar(50),
@Client nvarchar(200),
@DataStatus nvarchar(50),
@CPDesignation nvarchar(50),
@Remarks nvarchar(50),
@Attachment nvarchar(200),
@EntryBy nvarchar(50)
as
begin

	Declare @MarketInfoID nvarchar(50)
	Declare @CurrentMarketInfoID numeric(18,0)
	Declare @MarketInfoIDPrefix as nvarchar(4)

	set @MarketInfoIDPrefix='MKT-'

	select @CurrentMarketInfoID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentMarketInfoID'
	
	set @CurrentMarketInfoID=isnull(@CurrentMarketInfoID,0)+1
	Select @MarketInfoID=dbo.generateID(@MarketInfoIDPrefix,@CurrentMarketInfoID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblMarketInfo(MarketInfoID,EmployeeID,Client,DataStatus,CPDesignation,Remarks,Attachment,EntryBy)
	Values(@MarketInfoID,@EmployeeID,@Client,@DataStatus,@CPDesignation,@Remarks,@Attachment,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentMarketInfoID where PropertyName='CurrentMarketInfoID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

alter proc spMktPerAuthentication
@UserID nvarchar(50),
@UserPassword nvarchar(50)
as
begin
	Declare @EmployeeID as nvarchar(20) Set @EmployeeID = ''
	if exists(
		Select * from tblEmployeeInfo Where UserID=@UserID And UserPassword=@UserPassword
	)
	begin
		Select @EmployeeID = EmployeeID from tblEmployeeInfo Where UserID=@UserID And UserPassword=@UserPassword
	end
	else
	begin
		Set @EmployeeID = '-1'
	end

	Select @EmployeeID as 'EmployeeID'
	
end

GO

Create proc spGetMktInfoByEmpID
@EmployeeID nvarchar(50)
as
begin
	
	Select Client+' ['+CPDesignation+'] ['+ CONVERT(nvarchar,EntryDate,106)+']' as 'Client',Attachment  from tblMarketInfo Where EmployeeID=@EmployeeID
	order by EntryDate desc

end

exec spGetMktInfoByEmpID 'EMP-00000020'

GO

alter proc spGetPendingMktInfoPrimaryRating
as
begin
	Select EI.EmployeeName as 'Executive',
	(Select ULCBranchName from tblULCBranch UB Where UB.ULCBranchID=EI.ULCBranchID ) as 'Branch',
	Client,DataStatus,CPDesignation,Remarks,Attachment
	from tblMarketInfo MI Left Join tblEmployeeInfo EI ON MI.EmployeeID=EI.EmployeeID
	Where IsPrimaryRatingDone=0
end

exec spGetPendingMktInfoPrimaryRating

