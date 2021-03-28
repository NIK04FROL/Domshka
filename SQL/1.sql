	--Задача 2
		SELECT 
			Month(OrderDate) as OrderMonth,
			SUM(SubTotal) as [Sum]
		FROM Sales.SalesOrderHeader
		GROUP BY Month(OrderDate)
		ORDER BY Month(OrderDate)
		
	
	--Задача 3
		SELECT TOP (10) a.City, COUNT(p.BusinessEntityID) as c
		 FROM Person.Person as p
		 JOIN Person.BusinessEntityAddress as b on p.BusinessEntityID = b.BusinessEntityID
		 JOIN Person.Address as a on b.AddressID = a.AddressID
		 WHERE p.PersonType = 'IN' AND a.City NOT IN (
				SELECT SC.City
				FROM Person.BusinessEntity as [key] 
					INNER JOIN Sales.Store as STORE on [key].BusinessEntityID = STORE.BusinessEntityID
					INNER JOIN Person.BusinessEntityAddress as sa on [key].BusinessEntityID = sa.BusinessEntityID
					INNER JOIN Person.Address as SC on sa.AddressID = SC.AddressID)
		GROUP BY a.City
		ORDER BY c DESC
		

	--Задача 4
		SELECT pe.LastName
			   ,pe.FirstName
			   ,pr.[Name]
			   ,sod.OrderQty
		FROM Sales.SalesOrderHeader as soh
			JOIN Sales.Customer as c on soh.CustomerID = c.CustomerID
			JOIN Person.Person as pe on c.PersonID = pe.BusinessEntityID
			JOIN Sales.SalesOrderDetail as sod on soh.SalesOrderID = sod.SalesOrderDetailID
			JOIN Production.Product as pr on sod.ProductID = pr.ProductID
		WHERE sod.OrderQty > 5
		ORDER BY pe.FirstName, sod.OrderQty DESC
		
		
	--Задача 5
		SELECT OrderDate
			   ,pe.LastName
			   ,pe.FirstName
			   ,CONCAT(pr.Name, N' Количество: ' , sod.OrderQty, N'шт.') as OrderContent
		FROM Sales.SalesOrderHeader as soh
			JOIN Sales.Customer as c on soh.CustomerID = c.CustomerID
			JOIN Person.Person as pe on c.PersonID = pe.BusinessEntityID
			JOIN Sales.SalesOrderDetail as sod on soh.SalesOrderID = sod.SalesOrderDetailID
			JOIN Production.Product as pr on sod.ProductID = pr.ProductID
		WHERE OrderDate = 
			(SELECT MIN(OrderDate)
			 FROM Sales.SalesOrderHeader as [inner]
			 WHERE [inner].CustomerID = soh.CustomerID)
		ORDER BY OrderDate DESC
		
		
	--Задача 6
		
		SELECT CONCAT(p1.LastName,' ', left(p1.FirstName,1),'.', left(p1.MiddleName,1)) as LeadName, s.HireDate as LeadHireDate, s.BirthDate as LeadBirthDate,
			   CONCAT(p2.LastName,' ', left(p2.FirstName,1),'.', left(p2.MiddleName,1)) as EmployeeName, m.HireDate as EmployeeHireDate, m.BirthDate as EmployeeBirthDate
		FROM HumanResources.Employee as s 
			JOIN HumanResources.Employee as m on m.OrganizationNode.GetAncestor(1) = s.OrganizationNode
			INNER JOIN Person.Person as p1 on s.BusinessEntityID = p1.BusinessEntityID
			INNER JOIN Person.Person as p2 on m.BusinessEntityID = p2.BusinessEntityID
		WHERE s.BirthDate > m.BirthDate AND s.HireDate > m.HireDate
		ORDER BY len(s.OrganizationNode.ToString()), s.OrganizationNode, p2.LastName, p2.FirstName
		
		
	--Задача 7
		CREATE PROCEDURE HumanResources.SingleMans (
			@FirstDate as date
			,@SecondDate as date
			,@cnt INT OUT)
		AS
		BEGIN
		SELECT *
		FROM HumanResources.Employee as e
		WHERE e.BirthDate BETWEEN @FirstDate AND @SecondDate AND e.MaritalStatus = 'S' AND e.Gender = 'M'
		SET @cnt = @@ROWCOUNT;
		END
