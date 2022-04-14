use AdventureWorks2019
go

--1.
select count(Name) as NumofProduct
from Production.Product

--2.
select  count(Name) NumofProductinSubcategory
from Production.Product
where ProductSubcategoryID is not null

--3.
select  ProductSubcategoryID, count(Name) CountedProducts
from Production.Product
group by ProductSubcategoryID

--4.
select count(Name) NumofProductnoinSubcategory
from Production.Product
where ProductSubcategoryID is null

--5.
select sum(quantity) SumofProductsQuantity
from Production.ProductInventory

--6.
select ProductID, sum(quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by ProductID
having sum(quantity) < 100

--7.
select Shelf ,ProductID, sum(quantity) as TheSum
from Production.ProductInventory
where LocationID = 40
group by Shelf, ProductID
having sum(quantity) < 100

--8.
select avg(quantity) AVGofProductsQuantity
from Production.ProductInventory
where LocationID = 10

--9.
select ProductID, Shelf, avg(quantity) TheAVG
from Production.ProductInventory
group by ProductID, Shelf

select Shelf, avg(quantity) AVGofProductsQuantity
from Production.ProductInventory
where LocationID = 10
group by Shelf

--10.
select ProductID, Shelf, avg(quantity) TheAVG
from Production.ProductInventory
where Shelf != 'N/A'
group by ProductID, Shelf

select Shelf, avg(quantity) TheAVG
from Production.ProductInventory
where Shelf != 'N/A'
group by Shelf

--11.
select Color, Class, count(*) TheCount, avg(ListPrice) AvgPrice
from Production.Product
where Color is not null and Class is not null
group by Color, Class

--12.
select c.Name, s.Name
from Person.CountryRegion c join Person.StateProvince s on c.CountryRegionCode = s.CountryRegionCode

--13.
select c.Name, s.Name
from Person.CountryRegion c join Person.StateProvince s on c.CountryRegionCode = s.CountryRegionCode
where c.Name in ('Germany', 'Canada')

use Northwind
go

--14.
select p.ProductName
from [Order Details] od join Orders o on od.OrderID = o.OrderID join Products p on p.ProductID = od.ProductID
where o.OrderDate > '19970413'
group by p.ProductName

--15.
select top 5 o.ShipPostalCode
from [Order Details] od join Orders o on od.OrderID = o.OrderID
where o.ShipPostalCode is not null
group by o.ShipPostalCode
order by sum(od.Quantity) desc

--16.
select top 5 o.ShipPostalCode
from [Order Details] od join Orders o on od.OrderID = o.OrderID
where o.ShipPostalCode is not null and o.OrderDate > '19970413'
group by o.ShipPostalCode
order by sum(od.Quantity) desc

--17.
select c.City, count(*) NumofCustomer
from Customers c
group by City

--18.
select c.City, count(*) NumofCustomer
from Customers c
group by City
having count(*)>2

--19.
select DISTINCt c.CompanyName
from Customers c join Orders o on c.CustomerID = o.CustomerID
where o.OrderDate > '19980101'

--20.
select c.CompanyName, max(o.OrderDate)
from Customers c join Orders o on c.CustomerID = o.CustomerID
group by c.CompanyName

--21.
select c.CompanyName, sum(od.Quantity)
from Customers c join Orders o on c.CustomerID = o.CustomerID join [Order Details] od on od.OrderID = o.OrderID
group by c.CompanyName

--22.
select o.CustomerID, sum(od.Quantity)
from Orders o join [Order Details] od on od.OrderID = o.OrderID
group by o.CustomerID
having sum(od.Quantity) > 100

--23.
select distinct su.CompanyName [Supplier Comany Name], s.CompanyName [Shipping Company Name]
from Suppliers su join Products p on su.SupplierID = p.SupplierID
                 join [Order Details] od on p.ProductID = od.ProductID
				 join Orders o on od.OrderID = o.OrderID
				 join Shippers s on s.ShipperID = o.ShipVia

--24.
select o.OrderDate, p.ProductName
from Products p join [Order Details] od on p.ProductID = od.ProductID join Orders o on od.OrderID = o.OrderID
order by o.OrderDate

--25.
select distinct e.FirstName + ' ' + e.LastName FullName, m.FirstName + ' ' + m.LastName FullName
from Employees e join Employees m on e.Title = m.Title
where e.EmployeeID != m.EmployeeID

--26.
select e.FirstName + ' ' + e.LastName FullName, count(m.EmployeeID) NumofReporter
from Employees e join Employees m on e.EmployeeID = m.ReportsTo
group by e.FirstName + ' ' + e.LastName
having count(m.EmployeeID)>2

--27.
select  isNull(s.City, c.City) City, ISNULL(s.CompanyName, c.CompanyName) Name, ISNULL(s.ContactName, c.ContactName) [Contact Name], ISNULL(s.Type, c.Type) Type
from (select City, CompanyName, ContactName, 'Suppliers' Type from Suppliers) s 
full join 
(select City, CompanyName, ContactName, 'Coustomer' Type from Customers) c 
on s.CompanyName=c.CompanyName 
