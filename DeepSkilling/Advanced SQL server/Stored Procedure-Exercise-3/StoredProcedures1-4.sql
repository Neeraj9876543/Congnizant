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
/*Exercise-1*/
CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO
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
PRINT 'EMPLOYEES IN IT DEPARTMENT';
EXEC sp_GetEmployeesByDepartment 3;
GO
