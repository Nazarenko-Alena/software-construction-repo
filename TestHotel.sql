
CREATE PROC TestHotel.Test_InsertPurchases
AS
BEGIN
	-- ���������� ���������
	EXEC tSQLt.FakeTable 'PurchasesByTheBuyer'

	-- ������ ���������

	DECLARE @ProductIdP int = 5,
	@CountOfProducts int = 12,
	@DateP char(12) = '2021-09-22',
	@SupplierId int = 2;
	EXEC InsertPurchases @ProductIdP, @CountOfProducts, @DateP, @SupplierId;

	-- �������� ����������

	-- ������� � ���������� ������������
	CREATE TABLE expected
	( 
		TotalCost float
	)

	INSERT expected (TotalCost)
	VALUES (46.2)

	-- ���������� ��������� ��������� � �����������
	EXEC tSQLt.AssertEqualsTable 
		'expected', 
		'PurchasesByTheBuyer', 
		'��������� InsertPurchases ������� ��������� total cost'

END

GO

CREATE PROC TestHotel.Test_deleteEmpl
AS
BEGIN

	-- ���������� ���������

	EXEC tSQLt.FakeTable 'ListOfEmployees'
	EXEC tSQLt.FakeTable 'ServiceRequest'

	INSERT ListOfEmployees (Surname, Name, DateOfBirth, DateOfEmployment) 
	VALUES 
	('Roberson', 'Barbara', '2000-12-22', '2021-12-22')

	INSERT ServiceRequest (Date,ReservationId,IdService, EmployeeId) 
	VALUES 
	('2000-12-22', 10, 3, 1)
	-- ������ ���������


	DECLARE @Surname varchar(50) = 'Roberson', 
	@Name varchar(50) = 'Barbara',
	@DateOfBirth char(12) =  '2000-12-22';
	EXEC deleteEmpl @Surname, @Name, @DateOfBirth;

	-- �������� ����������

	-- ������� � ���������� ������������
	CREATE TABLE expected
	( 
		ReservationId int,
		IdService int, 
		EmployeeId int
	)

	INSERT expected (ReservationId,IdService, EmployeeId)
	VALUES ( 10, 3, 1)

	-- ���������� ��������� ��������� � �����������
	EXEC tSQLt.AssertEqualsTable 
		'expected', 
		'ServiceRequest', 
		'��������� deleteEmpl ������� ������� ����������'

END

GO

CREATE PROC TestHotel.Test_InsertBooking
AS
BEGIN
	-- ���������� ���������
	EXEC tSQLt.FakeTable 'AboutBooking'
	-- ������ ���������
	DECLARE @IdRoom int = 101,
	@ArrivalDate char(15) = '2021-12-22',
	@DateOfDeparture char(15) = '2021-12-28',
	@ClientId int = 6;
	EXEC InsertBooking @IdRoom, @ArrivalDate, @DateOfDeparture, @ClientId;
	-- �������� ����������
	-- ������� � ���������� ������������
	CREATE TABLE expected
	( 
		IdRoom int,
		ArrivalDate char(15)
	)
	INSERT expected (IdRoom, ArrivalDate )
	VALUES (101, '2021-12-22')

	-- ���������� ��������� ��������� � �����������
	EXEC tSQLt.AssertEqualsTable 
		'expected', 
		'AboutBooking', 
		'��������� InsertBooking ������� ��������� ������������'

END

GO

CREATE PROC TestHotel.Test_InsertCat
AS
BEGIN
	-- ���������� ���������
	EXEC tSQLt.FakeTable 'AboutCategories'
	-- ������ ���������
	DECLARE @CategoryName varchar(50) = 'hjk',
	@ThePresenceOfATV varchar(10) = 'Yes',
	@ThePresenceOfABathroom varchar(10) = 'No',
	@NumberOfRooms int = 1,
	@RoomCapacity int = 3,
	@CostPerNight char(20) = '16$';
	EXEC InsertCat @CategoryName, @ThePresenceOfATV, @ThePresenceOfABathroom, @NumberOfRooms, @RoomCapacity, @CostPerNight;
	-- �������� ����������
	-- ������� � ���������� ������������
	CREATE TABLE expected
	( 
		CategoryName varchar(50),
		ThePresenceOfATV varchar(10),
		NumberOfRooms int
	)
	INSERT expected (CategoryName,ThePresenceOfATV, NumberOfRooms)
	VALUES ('hjk', 'Yes', 1)

	-- ���������� ��������� ��������� � �����������
	EXEC tSQLt.AssertEqualsTable 
		'expected', 
		'AboutCategories', 
		'��������� InsertCat ������� ��������� ���������'

END

GO

CREATE PROC TestHotel.Test_InsertClient
AS
BEGIN
	-- ���������� ���������
	EXEC tSQLt.FakeTable 'ClientInfo'
	-- ������ ���������
	DECLARE @Surn char(50) = 'Fomin',
	@N char(50) = 'Maksim',
	@PhoneNumber char(15) = '89195352365';
	EXEC InsertClient @Surn, @N, @PhoneNumber;	
	-- �������� ����������
	-- ������� � ���������� ������������
	CREATE TABLE expected
	( 
		Surname char(50),
		Name char(50),
		PhoneNumber nchar(15)
	)
	INSERT expected (Surname, Name, PhoneNumber )
	VALUES ('Fomin', 'Maksim', '89195352365')

	-- ���������� ��������� ��������� � �����������
	EXEC tSQLt.AssertEqualsTable 
		'expected', 
		'ClientInfo', 
		'��������� InsertClient ������� ��������� ��������'

END

GO

CREATE PROC TestHotel.Test_ChangeCostServ
AS
BEGIN
	-- ���������� ���������
	EXEC tSQLt.FakeTable 'ServiceCatalog'
	-- ������ ���������
	DECLARE @Name varchar(50) = 'taxi',
	@Cost nchar(10) = 15;
	EXEC ChangeCostServ @Name, @Cost;	
	-- �������� ����������
	-- ������� � ���������� ������������
	CREATE TABLE expected
	( 
		NameOfService varchar(50),
		Cost nchar(10)
	)
	INSERT expected (NameOfService, Cost)
	VALUES ('taxi', 15)

	-- ���������� ��������� ��������� � �����������
	EXEC tSQLt.AssertEqualsTable 
		'expected', 
		'ServiceCatalog', 
		'��������� ChangeCostServ ������� ������ ��������� ������'

END

GO

CREATE PROC TestHotel.Test_ChangeCostMedic
AS
BEGIN
	-- ���������� ���������
	EXEC tSQLt.FakeTable 'Medicaments'
	-- ������ ���������
	DECLARE @Name varchar(50) = 'Aspirin',
	@Cost int = 13;
	EXEC ChangeCostMedic @Name, @Cost;	
	-- �������� ����������
	-- ������� � ���������� ������������
	CREATE TABLE expected
	( 
		Name varchar(50),
		Cost int
	)
	INSERT expected (Name, Cost)
	VALUES ('Aspirin', 13)

	-- ���������� ��������� ��������� � �����������
	EXEC tSQLt.AssertEqualsTable 
		'expected', 
		'Medicaments', 
		'��������� ChangeCostMedic ������� ������ ��������� ��������'

END

GO

CREATE PROC TestHotel.Test_ChangeCountIngredients
AS
BEGIN
	-- ���������� ���������
	EXEC tSQLt.FakeTable 'Ingredients'
	-- ������ ���������
	DECLARE @Name varchar(50) = 'Potatoes',
	@Quantity int = 58;
	EXEC ChangeCountIngredients @Name, @Quantity;	
	-- �������� ����������
	-- ������� � ���������� ������������
	CREATE TABLE expected
	( 
		Name varchar(50),
		Quantity int
	)
	INSERT expected (Name, Quantity)
	VALUES ('Potatoes', 58)

	-- ���������� ��������� ��������� � �����������
	EXEC tSQLt.AssertEqualsTable 
		'expected', 
		'Ingredients', 
		'��������� ChangeCountIngredients ������� ������ ���������� ������������ �� ������'

END


GO

CREATE PROC TestHotel.Test_CalcTotalOrderAmount
AS
BEGIN
	-- ���������� ���������
	EXEC tSQLt.FakeTable 'OrderMed'
	-- ������ ���������
	DECLARE @Name varchar(50) = 'Aspirin',
	@Quantity int = 3;
	EXEC CalcTotalOrderAmount @Name, @Quantity;	
	-- �������� ����������
	-- ������� � ���������� ������������
	CREATE TABLE expected
	( 
		TotalCost int
	)
	INSERT expected (TotalCost)
	VALUES (96)

	-- ���������� ��������� ��������� � �����������
	EXEC tSQLt.AssertEqualsTable 
		'expected', 
		'OrderMed', 
		'��������� CalcTotalOrderAmount ������� ��������� ����� ����� ������ ������������'

END


GO

CREATE PROC TestHotel.Test_AddAnswer
AS
BEGIN
	-- ���������� ���������
	EXEC tSQLt.FakeTable 'Reviews'
	-- ������ ���������
	DECLARE @Answer varchar(50) = 'Thank you for your feedback!',
	@IdReviews int = 2;
	EXEC AddAnswer @IdReviews, @Answer;	
	-- �������� ����������
	-- ������� � ���������� ������������
	CREATE TABLE expected
	( 
		Answer varchar(50)
	)
	INSERT expected (Answer)
	VALUES ('Thank you for your feedback!')

	-- ���������� ��������� ��������� � �����������
	EXEC tSQLt.AssertEqualsTable 
		'expected', 
		'Reviews', 
		'��������� AddAnswer ������� ��������� ����� �� �����'

END


GO

EXEC tSqlt.Run 'TestHotel'