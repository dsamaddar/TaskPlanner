
Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentCategoryID',0)

GO

-- drop table tblCategory
Create table tblCategory(
CategoryID nvarchar(50) primary key,
CategoryName nvarchar(200) unique(CategoryName),
Details nvarchar(500),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

alter proc spGetDetailsCategoryInfo
as
begin
	Select CategoryID,CategoryName,Details,Case IsActive When 1 Then 'YES' Else 'NO' end as 'IsActive',
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate'
	from tblCategory 
	order by CategoryName
end

-- exec spGetDetailsCategoryInfo

GO

Create proc spGetActiveCategoryList
as
begin
	Select CategoryID,CategoryName from tblCategory Where IsActive=1 order by CategoryName
end

GO

alter proc spUpdateCategory
@CategoryID nvarchar(50),
@CategoryName nvarchar(200),
@Details nvarchar(500),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Update tblCategory Set CategoryName=@CategoryName,Details=@Details,IsActive=@IsActive,EntryBy=@EntryBy
	Where CategoryID=@CategoryID
end

GO

-- drop proc spInsertCategory
Create proc spInsertCategory
@CategoryName nvarchar(200),
@Details nvarchar(500),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @CategoryID nvarchar(50)
	Declare @CurrentCategoryID numeric(18,0)
	Declare @CategoryIDPrefix as nvarchar(4)

	set @CategoryIDPrefix='CAT-'

begin tran
	
	select @CurrentCategoryID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentCategoryID'
	
	set @CurrentCategoryID=isnull(@CurrentCategoryID,0)+1
	Select @CategoryID=dbo.generateID(@CategoryIDPrefix,@CurrentCategoryID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblCategory(CategoryID,CategoryName,Details,IsActive,EntryBy)
	Values(@CategoryID,@CategoryName,@Details,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentCategoryID where PropertyName='CurrentCategoryID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentSubCategoryID',0)

GO

-- drop table tblSubCategory
Create table tblSubCategory(
SubCategoryID nvarchar(50) primary key,
CategoryID nvarchar(50) foreign key references tblCategory(CategoryID),
SubCategory nvarchar(200) unique(SubCategory),
Details nvarchar(500),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

alter proc spGetSubCategoryDetailsInfo
as
begin
	Select SC.SubCategoryID,SC.SubCategory,C.CategoryID,C.CategoryName,SC.Details,
	Case SC.IsActive When 1 Then 'YES' else 'NO' end as 'IsActive',
	Convert(nvarchar,SC.EntryDate,106) as 'EntryDate'
	from  tblSubCategory SC left Join tblCategory C  On SC.CategoryID=C.CategoryID
	order by SubCategory 
end

exec spGetSubCategoryDetailsInfo

GO

Create proc spGetSubCategoryListByCategory
@CategoryID nvarchar(50)
as
begin
	Select SubCategoryID,SubCategory from tblSubCategory Where CategoryID=@CategoryID
end

GO

alter proc spUpdateSubCategory
@SubCategoryID nvarchar(50),
@CategoryID nvarchar(50),
@SubCategory nvarchar(200),
@Details nvarchar(500),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Update tblSubCategory Set CategoryID=@CategoryID,SubCategory=@SubCategory,Details=@Details,
	IsActive=@IsActive,EntryBy=@EntryBy Where SubCategoryID=@SubCategoryID
end


GO

-- drop proc spInsertSubCategory
alter proc spInsertSubCategory
@CategoryID nvarchar(50),
@SubCategory nvarchar(200),
@Details nvarchar(500),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @SubCategoryID nvarchar(50)
	Declare @CurrentSubCategoryID numeric(18,0)
	Declare @SubCategoryIDPrefix as nvarchar(8)

	set @SubCategoryIDPrefix='SUB-CAT-'

begin tran
	
	select @CurrentSubCategoryID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentSubCategoryID'
	
	set @CurrentSubCategoryID=isnull(@CurrentSubCategoryID,0)+1
	Select @SubCategoryID=dbo.generateID(@SubCategoryIDPrefix,@CurrentSubCategoryID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblSubCategory(SubCategoryID,CategoryID,SubCategory,Details,IsActive,EntryBy)
	Values(@SubCategoryID,@CategoryID,@SubCategory,@Details,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentSubCategoryID where PropertyName='CurrentSubCategoryID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Insert into tblAppSettings(PropertyName,PropertyValue)Values('CurrentItemID',0)


GO
-- drop table tblItems
Create table tblItems(
ItemID nvarchar(50) primary key,
CategoryID nvarchar(50) foreign key references tblCategory(CategoryID),
SubCategoryID nvarchar(50) foreign key references tblSubCategory(SubCategoryID),
ItemName nvarchar(200) unique(ItemName),
Details nvarchar(500),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
); 

GO

Create proc spGetItemsBySubCategory
@SubCategoryID nvarchar(50)
as
begin
	Select ItemID,ItemName from tblItems Where SubCategoryID=@SubCategoryID
	And IsActive=1
	order by ItemName 
end

GO

Create proc spGetDetailsItems
as
begin
	Select I.ItemID,I.ItemName,C.CategoryID,C.CategoryName,SC.SubCategoryID, SC.SubCategory,I.Details,
	Case I.IsActive When 1 Then 'YES' else 'NO' end as 'IsActive',
	I.EntryBy,Convert(nvarchar,I.EntryDate,106) as 'EntryDate'
	from tblItems I left Join tblCategory C On I.CategoryID = C.CategoryID 
	Left Join tblSubCategory SC On I.SubCategoryID = SC.SubCategoryID
end

exec spGetDetailsItems

GO

Create proc spUpdateItems
@ItemID nvarchar(50),
@CategoryID nvarchar(50),
@SubCategoryID nvarchar(50),
@ItemName nvarchar(50),
@Details nvarchar(500),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin

	Update tblItems Set CategoryID=@CategoryID,SubCategoryID=@SubCategoryID,ItemName=@ItemName,Details=@Details,
	IsActive=@IsActive,EntryBy=@EntryBy
	Where ItemID=@ItemID 

end

GO

alter proc spInsertItems
@CategoryID nvarchar(50),
@SubCategoryID nvarchar(50),
@ItemName nvarchar(50),
@Details nvarchar(500),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @ItemID nvarchar(50)
	Declare @CurrentItemID numeric(18,0)
	Declare @ItemIDPrefix as nvarchar(8)

	set @ItemIDPrefix='ITM-'

begin tran
	
	select @CurrentItemID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentItemID'
	
	set @CurrentItemID=isnull(@CurrentItemID,0)+1
	Select @ItemID=dbo.generateID(@ItemIDPrefix,@CurrentItemID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblItems(ItemID,CategoryID,SubCategoryID,ItemName,Details,EntryBy)
	Values(@ItemID,@CategoryID,@SubCategoryID,@ItemName,@Details,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentItemID where PropertyName='CurrentItemID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end