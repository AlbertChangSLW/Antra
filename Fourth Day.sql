use Northwind
go

--1.
create view view_product_order_Chang
as
select p.ProductID, sum(od.Quantity) OrderQuantity
from [Order Details] od join Orders o on o.OrderID=od.OrderID 
join Products p on p.ProductID = od.ProductID
group by p.ProductID

--2.
Create proc sp_product_order_quantity_Chang
@ProductID int,
@QuantityofOrder int out
as 
begin
select @QuantityofOrder = count(*)
from Orders o join [Order Details] od on o.OrderID = od.OrderID
where od.ProductID = @ProductID
end

--3.
create proc sp_product_order_city_Chang
@ProdcutName varchar(40)
as
begin
select top 5 o.ShipCity, sum(od.Quantity) TotalofQuantity
from Products p join [Order Details] od on p.ProductID = od.ProductID
join Orders o on o.OrderID = od.OrderID
where p.ProductName = @ProdcutName
group by o.ShipCity
order by TotalofQuantity desc
end

--4.
create table city_Chang
(
ID int primary key identity(1,1),
City varchar(15)
)

create table people_Chang
(
ID int primary key identity(1,1),
Name varchar(30),
City int foreign key references city_Chang(ID) on delete set NULL
)

insert into city_Chang values ('Seattle')
insert into city_Chang values ('Green Bay')

insert into people_Chang values ('Aaron Rodgers', 2)
insert into people_Chang values ('Russell Wilson', 1)
insert into people_Chang values ('Jody', 2)

delete city_Chang
where City = 'Seattle'

insert into city_Chang values ('Madison')

update people_Chang
set City = 3
where city is null

create view Packers_AlbertChang
as
(
select p.Name
from people_Chang p join city_Chang c on p.City = c.ID
where c.City = 'Green Bay'
)

drop table people_Chang, city_Chang
drop view Packers_AlbertChang

--5.
create proc sp_birthday_employees_Chang
as
begin
select *
into birthday_employees_Chang
from Employees
where MONTH(BirthDate) = 2
end

exec sp_birthday_employees_Chang

drop table birthday_employees_Chang

--6.
--it because I create the new table and insert data form employee by using into 