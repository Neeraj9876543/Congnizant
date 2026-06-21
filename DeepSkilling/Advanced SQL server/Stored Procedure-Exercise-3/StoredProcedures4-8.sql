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
SELECT * FROM Employees;
GO
