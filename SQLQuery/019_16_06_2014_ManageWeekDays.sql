

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentMngWeekDayID',0)

GO

Create table tblManageWeekdays(
MngWeekDayID nvarchar(50) primary key,
WeekDays nvarchar(50) unique(WeekDays),
FromHour nvarchar(10),
FromMinute nvarchar(10),
FromMeridiem nvarchar(10),
ToHour nvarchar(10),
ToMinute nvarchar(10),
ToMeridiem nvarchar(10),
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

alter proc spGetWeekDaysDetails
as
begin
	Select MngWeekDayID,WeekDays,FromHour,FromMinute,FromMeridiem,
	FromHour+':'+FromMinute+ ' ' + FromMeridiem as 'FromTime',
	ToHour,ToMinute,ToMeridiem,
	ToHour+':'+ToMinute+ ' ' + ToMeridiem as 'ToTime',
	EntryBy
	from tblManageWeekdays
end

GO

Create proc spInsertManageWeekdays
@WeekDays nvarchar(50),
@FromHour nvarchar(10),
@FromMinute nvarchar(10),
@FromMeridiem nvarchar(10),
@ToHour nvarchar(10),
@ToMinute nvarchar(10),
@ToMeridiem nvarchar(10),
@EntryBy nvarchar(50)
as
begin
	Declare @MngWeekDayID nvarchar(50)
	Declare @CurrentMngWeekDayID numeric(18,0)
	Declare @MngWeekDayIDPrefix as nvarchar(7)

	set @MngWeekDayIDPrefix='MNG-WD-'

begin tran
	
	select @CurrentMngWeekDayID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentMngWeekDayID'
	
	set @CurrentMngWeekDayID=isnull(@CurrentMngWeekDayID,0)+1
	Select @MngWeekDayID=dbo.generateID(@MngWeekDayIDPrefix,@CurrentMngWeekDayID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblManageWeekdays(MngWeekDayID,WeekDays,FromHour,FromMinute,FromMeridiem,ToHour,ToMinute,ToMeridiem,EntryBy)
	Values(@MngWeekDayID,@WeekDays,@FromHour,@FromMinute,@FromMeridiem,@ToHour,@ToMinute,@ToMeridiem,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentMngWeekDayID where PropertyName='CurrentMngWeekDayID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spUpdateManageWeekDays
@MngWeekDayID nvarchar(50),
@WeekDays nvarchar(50),
@FromHour nvarchar(10),
@FromMinute nvarchar(10),
@FromMeridiem nvarchar(10),
@ToHour nvarchar(10),
@ToMinute nvarchar(10),
@ToMeridiem nvarchar(10),
@EntryBy nvarchar(50)
as
begin
	Update tblManageWeekdays Set WeekDays=@WeekDays,FromHour=@FromHour,FromMinute=@FromMinute,FromMeridiem=@FromMeridiem,
	ToHour=@ToHour,ToMinute=@ToMinute,ToMeridiem=@ToMeridiem,EntryBy=@EntryBy
	Where MngWeekDayID=@MngWeekDayID
end