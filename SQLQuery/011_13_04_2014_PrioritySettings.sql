
Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentPriorityID',0)

GO

Create table tblPriority(
PriorityID nvarchar(50) primary key,
PriorityText nvarchar(200) unique(PriorityText),
Timing int,
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

Create proc spGetActivePriorityList
as
begin
	Select PriorityID,PriorityText from tblPriority Where IsActive=1
	order by PriorityText 
end

GO

alter proc spGetPriorityDetails
as
begin
	Select PriorityID,PriorityText,Timing,
	Case IsActive When 1 Then 'YES' else 'NO' end  as 'IsActive',
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate'
	from tblPriority order by Timing,EntryDate 
end

GO

Create proc spInsertPriority
@PriorityText nvarchar(200),
@Timing int,
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @PriorityID nvarchar(50)
	Declare @CurrentPriorityID numeric(18,0)
	Declare @PriorityIDPrefix as nvarchar(5)

	set @PriorityIDPrefix='PRIO-'

begin tran
	
	select @CurrentPriorityID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentPriorityID'
	
	set @CurrentPriorityID=isnull(@CurrentPriorityID,0)+1
	Select @PriorityID=dbo.generateID(@PriorityIDPrefix,@CurrentPriorityID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblPriority(PriorityID,PriorityText,Timing,IsActive,EntryBy)
	Values(@PriorityID,@PriorityText,@Timing,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentPriorityID where PropertyName='CurrentPriorityID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spUpdatePriority
@PriorityID nvarchar(50),
@PriorityText nvarchar(200),
@Timing int,
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Update tblPriority set PriorityText=@PriorityText,Timing=@Timing,IsActive=@IsActive,EntryBy=@EntryBy
	Where PriorityID=@PriorityID 
end

GO