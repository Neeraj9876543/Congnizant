/* =====================================================
   EMPLOYEE MANAGEMENT SYSTEM - STORED PROCEDURES
   ===================================================== */

/* =====================================================
   DROP PROCEDURES IF THEY EXIST
   ===================================================== */

IF OBJECT_ID('sp_GetEmployeesByDepartment', 'P') IS NOT NULL
    DROP PROCEDURE sp_GetEmployeesByDepartment;
GO

IF OBJECT_ID('sp_InsertEmployee', 'P') IS NOT NULL
    DROP PROCEDURE sp_InsertEmployee;
GO

IF OBJECT_ID('sp_GetEmployeeCountByDepartment', 'P') IS NOT NULL
    DROP PROCEDURE sp_GetEmployeeCountByDepartment;
GO

IF OBJECT_ID('sp_GetTotalSalaryByDepartment', 'P') IS NOT NULL
    DROP PROCEDURE sp_GetTotalSalaryByDepartment;
GO

IF OBJECT_ID('sp_UpdateEmployeeSalary', 'P') IS NOT NULL
    DROP PROCEDURE sp_UpdateEmployeeSalary;
GO

IF OBJECT_ID('sp_GiveBonus', 'P') IS NOT NULL
    DROP PROCEDURE sp_GiveBonus;
GO

IF OBJECT_ID('sp_UpdateSalaryTransaction', 'P') IS NOT NULL
    DROP PROCEDURE sp_UpdateSalaryTransaction;
GO

IF OBJECT_ID('sp_DynamicEmployeeSearch', 'P') IS NOT NULL
    DROP PROCEDURE sp_DynamicEmployeeSearch;
GO

IF OBJECT_ID('sp_UpdateSalaryWithErrorHandling', 'P') IS NOT NULL
    DROP PROCEDURE sp_UpdateSalaryWithErrorHandling;
GO

/* =====================================================
   DROP TABLES
   ===================================================== */

IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;
GO

IF OBJECT_ID('Departments', 'U') IS NOT NULL
    DROP TABLE Departments;
GO

/* =====================================================
   CREATE TABLES
   ===================================================== */

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);
GO

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    JoinDate DATE,
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
GO

/* =====================================================
   INSERT SAMPLE DATA
   ===================================================== */

INSERT INTO Departments VALUES
(1,'HR'),
(2,'Finance'),
(3,'IT'),
(4,'Marketing');
GO

INSERT INTO Employees VALUES
(1,'John','Doe',1,5000.00,'2020-01-15'),
(2,'Jane','Smith',2,6000.00,'2019-03-22'),
(3,'Michael','Johnson',3,7000.00,'2018-07-30'),
(4,'Emily','Davis',4,5500.00,'2021-11-05');
GO

/* =====================================================
   EXERCISE 1
   STORED PROCEDURE TO GET EMPLOYEES BY DEPARTMENT
   ===================================================== */

CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

/* =====================================================
   EXERCISE 2
   MODIFIED PROCEDURE INCLUDING SALARY
   ===================================================== */

ALTER PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        Salary,
        DepartmentID
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

/* =====================================================
   EXERCISE 3
   INSERT EMPLOYEE PROCEDURE
   ===================================================== */

CREATE PROCEDURE sp_InsertEmployee
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE
AS
BEGIN
    INSERT INTO Employees
    VALUES
    (
        @EmployeeID,
        @FirstName,
        @LastName,
        @DepartmentID,
        @Salary,
        @JoinDate
    );
END;
GO

/* =====================================================
   EXERCISE 4
   EXECUTE PROCEDURE
   ===================================================== */

EXEC sp_GetEmployeesByDepartment 3;
GO

/* =====================================================
   EXERCISE 5
   EMPLOYEE COUNT BY DEPARTMENT
   ===================================================== */

CREATE PROCEDURE sp_GetEmployeeCountByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT COUNT(*) AS TotalEmployees
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

/* =====================================================
   EXERCISE 6
   OUTPUT PARAMETER
   ===================================================== */

CREATE PROCEDURE sp_GetTotalSalaryByDepartment
    @DepartmentID INT,
    @TotalSalary DECIMAL(18,2) OUTPUT
AS
BEGIN
    SELECT
        @TotalSalary = SUM(Salary)
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

/* =====================================================
   EXERCISE 7
   UPDATE EMPLOYEE SALARY
   ===================================================== */

CREATE PROCEDURE sp_UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;
END;
GO

EXEC sp_UpdateEmployeeSalary 1, 5500.00;
GO

/* =====================================================
   EXERCISE 8
   GIVE BONUS
   ===================================================== */

CREATE PROCEDURE sp_GiveBonus
    @DepartmentID INT,
    @BonusAmount DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + @BonusAmount
    WHERE DepartmentID = @DepartmentID;
END;
GO

EXEC sp_GiveBonus 1, 500.00;
GO

/* =====================================================
   EXERCISE 9
   TRANSACTION PROCEDURE
   ===================================================== */

CREATE PROCEDURE sp_UpdateSalaryTransaction
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY

        BEGIN TRANSACTION;

        UPDATE Employees
        SET Salary = @NewSalary
        WHERE EmployeeID = @EmployeeID;

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        PRINT 'Transaction Failed';

    END CATCH
END;
GO

/* =====================================================
   EXERCISE 10
   DYNAMIC SQL
   ===================================================== */

CREATE PROCEDURE sp_DynamicEmployeeSearch
    @ColumnName VARCHAR(50),
    @Value VARCHAR(100)
AS
BEGIN

    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL =
    'SELECT * FROM Employees WHERE '
    + QUOTENAME(@ColumnName)
    + ' = '''
    + @Value + '''';

    EXEC sp_executesql @SQL;

END;
GO

/* =====================================================
   EXERCISE 11
   ERROR HANDLING
   ===================================================== */

CREATE PROCEDURE sp_UpdateSalaryWithErrorHandling
    @EmployeeID INT,
    @NewSalary DECIMAL(10,2)
AS
BEGIN

    BEGIN TRY

        UPDATE Employees
        SET Salary = @NewSalary
        WHERE EmployeeID = @EmployeeID;

        PRINT 'Salary Updated Successfully';

    END TRY

    BEGIN CATCH

        PRINT 'Custom Error Message';
        PRINT ERROR_MESSAGE();

    END CATCH

END;
GO

/* =====================================================
   TESTING ALL PROCEDURES
   ===================================================== */

PRINT 'EMPLOYEES IN IT DEPARTMENT';
EXEC sp_GetEmployeesByDepartment 3;
GO

PRINT 'INSERT NEW EMPLOYEE';
EXEC sp_InsertEmployee
     5,
     'Robert',
     'Brown',
     2,
     6500.00,
     '2023-01-10';
GO

SELECT * FROM Employees;
GO

PRINT 'EMPLOYEE COUNT';
EXEC sp_GetEmployeeCountByDepartment 2;
GO

DECLARE @TotalSalary DECIMAL(18,2);

EXEC sp_GetTotalSalaryByDepartment
     2,
     @TotalSalary OUTPUT;

PRINT 'TOTAL SALARY OF DEPARTMENT 2';
PRINT @TotalSalary;
GO

PRINT 'UPDATE SALARY';
EXEC sp_UpdateEmployeeSalary 2, 7500.00;
GO

PRINT 'BONUS GIVEN';
EXEC sp_GiveBonus 2, 500.00;
GO

PRINT 'TRANSACTION TEST';
EXEC sp_UpdateSalaryTransaction 3, 8500.00;
GO

PRINT 'DYNAMIC SQL TEST';
EXEC sp_DynamicEmployeeSearch
     'FirstName',
     'John';
GO

PRINT 'ERROR HANDLING TEST';
EXEC sp_UpdateSalaryWithErrorHandling
     1,
     9000.00;
GO

SELECT * FROM Employees;
GO
