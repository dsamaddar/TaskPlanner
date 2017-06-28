
-- drop view vwAllChaseStatus
Create view vwAllChaseStatus
as
SELECT        GC.GeneratedChaseID, RIGHT(GC.MasterChaseID, 6) AS Sequence, GC.ChaseDefinitionID, GC.MasterChaseID,
    (SELECT        CategoryName
    FROM            dbo.tblCategory AS C
    WHERE        (CategoryID = CD.CategoryID)) AS Category,
    (SELECT        SubCategory
    FROM            dbo.tblSubCategory AS SC
    WHERE        (SubCategoryID = CD.SubCategoryID)) AS SubCategory,
    (SELECT        ItemName
    FROM            dbo.tblItems AS I
    WHERE        (ItemID = CD.ItemID)) AS Item, dbo.fnGetEmpNameByID(dbo.fnGetContactPersonIDByMasterChaseID(dbo.fnGetMasterChaseID(GC.GeneratedChaseID))) 
AS ContactPerson, CD.ChaseName, GC.InitiatorID, dbo.fnGetEmpNameByID(GC.InitiatorID) AS Initiator, GC.InitiatorRemarks, GC.InitiationDate, 
dbo.fnGetLatestChaseStatus(GC.MasterChaseID) AS ChaseStatus, GC.AssignedToID, GC.VoiceDataCollectionID, dbo.fnGetEmpNameByID(GC.AssignedToID) 
AS AssignedTo, dbo.fnGetChaseInputValuesDesc(GC.MasterChaseID) AS Description, ISNULL(GC.FinalStatus, N'N\A') AS FinalStatus, GC.IsActive
FROM            dbo.tblGeneratedChase AS GC LEFT OUTER JOIN
dbo.tblChaseDefinition AS CD ON GC.ChaseDefinitionID = CD.ChaseDefinitionID

Select * from vwAllChaseStatus


alter proc spGetGlobalChaseView
as
begin
	Select GC.AssignedToID,EI.EmployeeName,
	(Select count(*) from  vwAllChaseStatus V Where V.ChaseStatus = 'Assigned' And V.AssignedToID=GC.AssignedToID) as 'Pending',
	(Select count(*) from vwAllChaseStatus V Where V.ChaseStatus = 'Forwarded' And V.AssignedToID=GC.AssignedToID) as 'Forwarded',
	(Select count(*) from vwAllChaseStatus V Where V.ChaseStatus = 'Terminated' And V.AssignedToID=GC.AssignedToID) as 'Done'
	from tblGeneratedChase GC Left Join tblEmployeeInfo EI On GC.AssignedToID=EI.EmployeeID 
	--Where GC.ParentChaseID is null
	group by GC.AssignedToID,EI.EmployeeName 
end


-- exec spGetGlobalChaseView

GO

Create proc spGetGlobalChaseViewByDept
@EmployeeID nvarchar(50)
as
begin

	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''
	Select @DepartmentID = DepartmentID from tblEmployeeInfo Where EmployeeID=@EmployeeID

	Select GC.AssignedToID,EI.EmployeeName,
	(Select count(*) from  vwAllChaseStatus V Where V.ChaseStatus = 'Assigned' And V.AssignedToID=GC.AssignedToID) as 'Pending',
	(Select count(*) from vwAllChaseStatus V Where V.ChaseStatus = 'Forwarded' And V.AssignedToID=GC.AssignedToID) as 'Forwarded',
	(Select count(*) from vwAllChaseStatus V Where V.ChaseStatus = 'Terminated' And V.AssignedToID=GC.AssignedToID) as 'Done'
	from tblGeneratedChase GC Left Join tblEmployeeInfo EI On GC.AssignedToID=EI.EmployeeID 
	Where AssignedToID in (
	Select distinct EmployeeID from tblEmployeeInfo Where DepartmentID=@DepartmentID
	)
	--Where GC.ParentChaseID is null
	group by GC.AssignedToID,EI.EmployeeName 
end

exec spGetGlobalChaseViewByDept 'EMP-00000020'

GO

-- drop proc spGetAssignedChaseByUserAndSts
ALTER proc [dbo].[spGetAssignedChaseByUserAndSts]
@EmployeeID nvarchar(50),
@ChaseStatus nvarchar(50)
as
begin
	
	Select GC.GeneratedChaseID,RIGHT(GC.MasterChaseID,6) as 'Sequence',GC.MasterChaseID,CD.ChaseName,
	dbo.fnGetEmpNameByID(dbo.fnGetContactPersonIDByMasterChaseID(dbo.fnGetMasterChaseID(GC.GeneratedChaseID))) AS 'ContactPerson',
	EI.EmployeeName as 'Initiator',Convert(nvarchar,GC.InitiationDate,100) as 'InitiationDate',
	GC.InitiatorRemarks,isnull(VD.DataSource,'N\A') as 'DataSource',
	dbo.fnGetChaseInputValuesDesc(GC.MasterChaseID) as 'Description',
	GC.ChaseStatus,GC.AssignedTo, dbo.fnGetChaseHistoryByGenChaseID(GC.GeneratedChaseID) AS 'AssignmentHistory',
	GC.FinalStatus 
	from vwAllChaseStatus GC left join tblChaseDefinition CD On GC.ChaseDefinitionID=CD.ChaseDefinitionID
	Left Join tblEmployeeInfo EI On GC.InitiatorID = EI.EmployeeID
	left Join tblVoiceDataCollection VD On GC.VoiceDataCollectionID = VD.VoiceDataCollectionID
	Where GC.AssignedToID=@EmployeeID And GC.ChaseStatus=@ChaseStatus
	order by GC.InitiationDate desc
end

-- exec spGetAssignedChaseByUserAndSts 'EMP-00000020','Forwarded'

GO

alter proc spGetTotalChaseForAssessment
@Year int
as
begin

	Declare @ChaseTbl table(
	MonthNo int,
	TotalChase int
	);

	Declare @i as int Set @i=1
	
	While @i <= 12
	begin

		Insert Into @ChaseTbl(MonthNo,TotalChase)
		Select distinct @i,
		(Select count(*) from vwAllChaseStatus G Where Month( InitiationDate)=@i And Year(InitiationDate)=@Year And ( Month(TerminationDate)=@i or TerminationDate is null))
		from tblGeneratedChase GC

		Set @i = @i + 1
	end

	Select
	Case MonthNo When 1 Then 'Jan' When 2 Then 'Feb' When 3 Then 'Mar' When 4 Then 'Apr' When 5 Then 'May' When 6 Then 'Jun' When 7 Then 'Jul' When 8 Then 'Aug'
	When 9 Then 'Sep' When 10 Then 'Oct' When 11 Then 'Nov' When 12 Then 'Dec' Else 'N\A' End as 'MonthName',
	TotalChase
	from @ChaseTbl
	

	
end

exec spGetTotalChaseForAssessment 2014

GO


alter proc spGetChaseViewGraphByUser
@EmployeeID nvarchar(50)
as
begin

	Select Distinct C.CategoryName,Count(*) as 'Count'
	from vwAllChaseStatus GC Left Join tblChaseDefinition CD On GC.ChaseDefinitionID=CD.ChaseDefinitionID
	left Join tblCategory C On CD.CategoryID=C.CategoryID
	Where GC.AssignedToID=@EmployeeID
	Group by C.CategoryName
end

-- exec spGetChaseViewGraphByUser 'EMP-00000020'

GO

alter proc spGetCategoryWiseGlobalView
as
begin
	Select MC.CategoryID,MC.Category,Count(*) as 'Count'
	from vwMasterChaseStatus  MC  
	Group by MC.CategoryID,MC.Category
end

exec spGetCategoryWiseGlobalView



alter proc spGetChaseDefWiseGraphicalData
@CategoryID nvarchar(50)
as
begin
	Select ChaseName as 'Chase',Count(*) as 'Count' from vwMasterChaseStatus Where CategoryID=@CategoryID
	Group by ChaseName
end

exec spGetChaseDefWiseGraphicalData 'CAT-00000004'