use Northwind
go

--1.
select Distinct e.City
from Customers c join Employees e on e.City = c.City

--2.a
select Distinct c.City
from Customers c
where c.City not in (select city from Employees)

--2.b
select distinct c.city
from Customers c full join Employees e on e.City = c.City
where e.City is null

--3.
select p.ProductName, sum(od.Quantity) TotalOrderQuantities
from [Order Details] od join Products p on p.ProductID = od.ProductID
group by p.ProductName

--4.
select c.City, sum(od.Quantity) TotalOrderQuantities
from Customers c join Orders o on c.CustomerID = o.CustomerID join [Order Details] od on od.OrderID = o.OrderID
group by c.City

--5.a
select c1.City
from Customers c1
group by c1.City
except
(
select c2.city
from Customers c2
group by c2.city
having count(*) = 1
union
select c3.City
from Customers c3
group by c3.City
having COUNT(*) = 0
)

--5.b
select distinct c.city
from Customers c join (select city from Customers group by city having count(*)>=2) dt on c.City=dt.City

--select c.City, count(*)
--from Customers c
--group by c.City
--having count(*)>=2

--6.
select ot.City, count(ot.ProductID) NumofProducts
from (select distinct c.City, od.ProductID
from Customers c join Orders o on c.CustomerID = o.CustomerID join [Order Details] od on od.OrderID = o.OrderID) ot
group by ot.City
having count(ot.ProductID) >= 2

--7.
select distinct c.CompanyName
from Customers c inner join Orders o on c.CustomerID = o.CustomerID
where c.City != o.ShipCity

--8.¡@I am not sure which city I should use(customer.city or orders.shipcity). so this is I use orders.shipcity
select top 5 od.ProductID, sum(od.Quantity) NumofTotalOrder, AVG(od.UnitPrice) AVGPrice,
(select top 1 o.ShipCity from Orders o join [Order Details] od1 on o.OrderID = od1.OrderID where od1.ProductID = od.ProductID group by o.ShipCity order by sum(od1.Quantity) desc)
from [Order Details] od
group by od.ProductID
order by NumofTotalOrder desc

-- this is I use customer.city
select top 5 p.ProductName, sum(od.Quantity) NumofTotalOrder, AVG(od.UnitPrice) AVGPrice,
(
select top 1 c.City
from Orders o join [Order Details] od1 on o.OrderID = od1.OrderID 
			  join Products p1 on p1.ProductID = od1.ProductID
			  join Customers c on c.CustomerID=o.CustomerID
where p.ProductName = p1.ProductName 
group by c.City 
order by sum(od1.Quantity) desc) MostOrderCity
from [Order Details] od join Products p on od.ProductID = p.ProductID
group by p.ProductName
order by NumofTotalOrder desc

--9.a
select e.City
from Employees e full join
(
select distinct ShipCity
from Orders
) sq on e.City = sq.ShipCity
where sq.ShipCity is null

--9.b
select e.City
from Employees e full join Orders o on e.City = o.ShipCity
where o.ShipCity is null

--10.if the result is null, it means there is not this city. if th result is a city, it means the city is exist.
--for this answer is null, so there is not this city.
select *
from
(select top 1 o.ShipCity
from Orders o
group by o.ShipCity
order by count(*) desc) ot
join
(select top 1 o.ShipCity
from [Order Details] od join Orders o on od.OrderID=o.OrderID
group by o.ShipCity
order by sum(od.Quantity)¡@desc) qt on ot.shipcity = qt. shipcity

--11.
--we can use distinct, group by. we might also can use union the table-self.