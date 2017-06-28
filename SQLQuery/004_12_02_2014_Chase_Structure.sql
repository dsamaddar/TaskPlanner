
Create table tblChaseStructure(
ChaseStructureID nvarchar(50) primary key,
ChaseStructure nvarchar(200),
ParentID nvarchar(50) foreign key references tblChaseStructure(ChaseStructureID),
AssignedUser
IsNotificationRequired bit default 1,
IsParallelProcess bit default 0,

);

GO

Create table tblChaseInfo(
ChaseID nvarchar(50) primary key,
ChaseStructureID nvarchar(50),

);