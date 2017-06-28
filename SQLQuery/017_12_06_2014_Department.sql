
Create proc spGetDeptList
as
begin
	Select distinct DepartmentID,DeptName from tblDepartment Where IsActive=1 order by DeptName 
end


