

Create proc spGetOfficialDesignation
as
begin
	SELECT DesignationID,DesignationName,DesignationLabel
	FROM tblDesignation
	where isActive =1 and DesignationType='Official' order by intOrder desc
end

