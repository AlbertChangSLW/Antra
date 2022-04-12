use AdventureWorks2019
go

--1.
select ProductID, Name, Color, ListPrice
from Production.Product

--2.
select ProductID, Name, Color, ListPrice
from Production.Product
where ListPrice = 0

--3.
select ProductID, Name, Color, ListPrice
from Production.Product
where Color is NULL

--4.
select ProductID, Name, Color, ListPrice
from Production.Product
where Color is not NULL

--5.
select ProductID, Name, Color, ListPrice
from Production.Product
where Color is not NULL and ListPrice > 0

--6.
select Name + ' ' + Color as [Name Color]
from Production.Product
where Color is not NULL

--7. has problem
select 'NAME: ' + Name + ' -- COLOR:' + Color as [Name Color]
from Production.Product
where  Name like '%Crankarm' or Name like 'Chainring%' order by ProductID

select 'NAME: ' + Name + ' -- COLOR:' + Color as [Name Color]
from Production.Product

--8.
select ProductID, Name
from Production.Product
where ProductID between 400 and 500

--9.
select ProductID, Name, Color
from Production.Product
where Color in ('Black', 'Blue')

--10.
select Name
from Production.Product
where Name like 'S%'

--11.
select Name, ListPrice
from Production.Product
where name like 'S%' order by Name

--12.
select Name, ListPrice
from Production.Product
where name like '[A,S]%' order by Name

--13.
select Name
from Production.Product
where Name like 'SPO[^K]%'

--14.
select Distinct Color
from Production.Product
order by Color desc

--15.
select Distinct ProductSubcategoryID, color
from Production.Product
where ProductSubcategoryID is not null and color is not null