

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentVoiceDataCollectionID',0)

GO

Create table tblVoiceDataCollection(
VoiceDataCollectionID nvarchar(50) primary key,
FacilityTypeID nvarchar(50) foreign key references tblFacilityType(FacilityTypeID),
ServiceManager nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
ClientID nvarchar(50) foreign key references tblClientInfo(ClientID),
AgreementInfoID nvarchar(50) foreign key references tblAgreementInfo(AgreementInfoID),
DataFrequency nvarchar(50),
CollectionDate datetime,
DataSource nvarchar(200),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

go

-- drop proc spGetVoiceDataColl
alter proc spGetVoiceDataColl
as
begin
	Select VoiceDataCollectionID,VD.FacilityTypeID,
	(Select FacilityType from tblFacilityType FT Where FT.FacilityTypeID= VD.FacilityTypeID) as 'Facility',
	(select EmployeeName from tblEmployeeInfo E Where E.EmployeeID= VD.ServiceManager) as 'ServiceManager',
	(Select ClientName from tblClientInfo C Where C.ClientID =VD.ClientID) as 'Client',
	(Select AgreementNo from tblAgreementInfo A Where A.AgreementInfoID=VD.AgreementInfoID) as 'Agreement',
	DataFrequency,Convert(nvarchar,CollectionDate,106) as 'Dated',DataSource,EntryBy
	from tblVoiceDataCollection VD 
	Order by CollectionDate desc
end

exec spGetVoiceDataColl

GO


Create proc spInsertVoiceDataCollection
@FacilityTypeID nvarchar(50),
@ServiceManager nvarchar(50),
@ClientID nvarchar(50),
@AgreementInfoID nvarchar(50),
@DataFrequency nvarchar(50),
@CollectionDate datetime,
@DataSource nvarchar(200),
@EntryBy nvarchar(50)
as
begin
	Declare @VoiceDataCollectionID nvarchar(50)
	Declare @CurrentVoiceDataCollectionID numeric(18,0)
	Declare @VoiceDataCollectionIDPrefix as nvarchar(3)

	set @VoiceDataCollectionIDPrefix='VD-'

begin tran
	
	select @CurrentVoiceDataCollectionID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentVoiceDataCollectionID'
	
	set @CurrentVoiceDataCollectionID=isnull(@CurrentVoiceDataCollectionID,0)+1
	Select @VoiceDataCollectionID=dbo.generateID(@VoiceDataCollectionIDPrefix,@CurrentVoiceDataCollectionID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblVoiceDataCollection(VoiceDataCollectionID,FacilityTypeID,ServiceManager,ClientID,AgreementInfoID,DataFrequency,CollectionDate,DataSource,EntryBy)
	Values(@VoiceDataCollectionID,@FacilityTypeID,@ServiceManager,@ClientID,@AgreementInfoID,@DataFrequency,@CollectionDate,@DataSource,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentVoiceDataCollectionID where PropertyName='CurrentVoiceDataCollectionID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0
ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end