
Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentFacilityTypeID',0)

GO

Create table tblFacilityType(
FacilityTypeID nvarchar(50) primary key,
FacilityType nvarchar(200),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

alter proc spGetFacilityType
as
begin
	Select FacilityTypeID,FacilityType,Case IsActive When 1 then 'YES' Else 'NO' end as 'IsActive',
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate' from tblFacilityType
	order by FacilityType
end

GO

Create proc spGetActiveFacilityTypeList
as
begin
	Select FacilityTypeID,FacilityType from tblFacilityType Where IsActive=1 order by FacilityType
end

GO

/*
Select * from tblFacilityType
exec spInsertFacilityType 'CSF',1,'dsamaddar'
exec spInsertFacilityType 'DF',1,'dsamaddar'
*/
GO

Create proc spUpdateFacilityType
@FacilityTypeID nvarchar(50),
@FacilityType nvarchar(200),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Update tblFacilityType Set FacilityType=@FacilityType,IsActive=@IsActive,EntryBy=@EntryBy
	Where FacilityTypeID=@FacilityTypeID
end

GO

Create proc spInsertFacilityType
@FacilityType nvarchar(200),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @FacilityTypeID nvarchar(50)
	Declare @CurrentFacilityTypeID numeric(18,0)
	Declare @FacilityTypeIDPrefix as nvarchar(4)

	set @FacilityTypeIDPrefix='FCT-'

begin tran
	
	select @CurrentFacilityTypeID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentFacilityTypeID'
	
	set @CurrentFacilityTypeID=isnull(@CurrentFacilityTypeID,0)+1
	Select @FacilityTypeID=dbo.generateID(@FacilityTypeIDPrefix,@CurrentFacilityTypeID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblFacilityType(FacilityTypeID,FacilityType,IsActive,EntryBy)
	Values(@FacilityTypeID,@FacilityType,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentFacilityTypeID where PropertyName='CurrentFacilityTypeID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end