

Declare @Id Int, @Sql varchar(400),@Cols varchar(40)
Create Table #Temp
		(
		Order_Id Int,
		InventoryId	 Int,
		ItemType Varchar(40),
		total Int
		)
 
Insert into #Temp
Values(1,5,'Orange',5000),(1,4,'Apple',3000),(2,1,'Mango',3400),(2,5,'Orange',1700)
 
Set @Id=2  -- if you want records for id 1 set @Id=1

Select * from #Temp

Set @Cols= Stuff((Select Distinct '],['+ItemType From #Temp Where Order_Id=@Id 
           for Xml Path(''),Type).value('.','VARCHAR(Max)'), 1, 2,'')+']'

-- Select @Cols
 
Set @Sql= 'Select '+@Cols + 'From (Select ItemType,total From #Temp Where Order_Id='
          + Cast(@Id as Varchar) +')st pivot (Sum(total) For ItemType in ('
          + @Cols + '))Pvt'

Select  @Sql

Select [Mango],[Orange]From (Select ItemType,total From #Temp Where Order_Id=2)st 
pivot (sum(total) For ItemType in ([Mango],[Orange]))Pvt

--Exec(@Sql)
 
Drop Table #Temp 



