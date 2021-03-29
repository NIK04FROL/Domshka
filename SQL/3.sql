
--Задача 1
	CREATE NONCLUSTERED INDEX Date_Index on Marketing.WebLog (SessionStart, ServerID)
	INCLUDE (SessionID, UserName)

	DROP INDEX Date_Index on Marketing.WebLog

	DECLARE @StartTime datetime2 = '2010-08-30 16:27';
	SELECT TOP(5000) wl.SessionID, wl.ServerID, wl.UserName
	FROM Marketing.WebLog AS wl
	WHERE wl.SessionStart >= @StartTime
	ORDER BY wl.SessionStart, wl.ServerID;
	GO
	
--Задача 2
	CREATE NONCLUSTERED INDEX StateCode_Index on Marketing.PostalCode (StateCode, PostalCode)

	SELECT PostalCode, Country
	FROM Marketing.PostalCode 
	WHERE StateCode = 'KY'
	ORDER BY StateCode, PostalCode;
	GO
	
--Задача 3
	CREATE NONCLUSTERED INDEX test_test on Marketing.Prospect (LastName, FirstName)

	CREATE NONCLUSTERED INDEX _dta_index_Prospect_10_229575856__K4_K1_2_3_5_6_7_8_9_10 ON Marketing.Prospect
(LastName ASC, ProspectID ASC)
INCLUDE ( 	[FirstName],
	[MiddleName],
	[CellPhoneNumber],
	[HomePhoneNumber],
	[WorkPhoneNumber],
	[Demographics],
	[LatestContact],
	[EmailAddress]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

DECLARE @Counter INT = 0;
WHILE @Counter < 350
BEGIN
	
	SELECT p.LastName, p.FirstName 
	FROM Marketing.Prospect AS p
	INNER JOIN Marketing.Salesperson AS sp
	ON p.LastName = sp.LastName
	ORDER BY p.LastName, p.FirstName;
	  
	SELECT * 
	FROM Marketing.Prospect AS p
	WHERE p.LastName = 'Smith';
	 SET @Counter += 1;
END;

	
--Задача 4
	CREATE NONCLUSTERED INDEX _dta_index_Product_10_149575571__K6_13 ON Marketing.Product
	(SubcategoryID ASC)
	INCLUDE (ProductModelID) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

	CREATE NONCLUSTERED INDEX _dta_index_ProductModel_10_197575742__K2_1 ON Marketing.ProductModel
	(ProductModel ASC)
	INCLUDE (ProductModelID) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

	SELECT
		c.CategoryName,
		sc.SubcategoryName,
		pm.ProductModel,
		COUNT(p.ProductID) AS ModelCount
	FROM Marketing.ProductModel pm
		JOIN Marketing.Product p
			ON p.ProductModelID = pm.ProductModelID
		JOIN Marketing.Subcategory sc
			ON sc.SubcategoryID = p.SubcategoryID
		JOIN Marketing.Category c
			ON c.CategoryID = sc.CategoryID
	GROUP BY c.CategoryName,
		sc.SubcategoryName,
		pm.ProductModel
	HAVING COUNT(p.ProductID) > 1
