/* =====================================================
   EMPLOYEE MANAGEMENT SYSTEM - SQL VIEWS EXERCISES
   ===================================================== */

/* =====================================================
   DROP VIEWS IF THEY EXIST
   ===================================================== */

IF OBJECT_ID('vw_EmployeeReport', 'V') IS NOT NULL
    DROP VIEW vw_EmployeeReport;
GO

IF OBJECT_ID('vw_EmployeeAnnualSalary', 'V') IS NOT NULL
    DROP VIEW vw_EmployeeAnnualSalary;
GO

IF OBJECT_ID('vw_EmployeeFullName', 'V') IS NOT NULL
    DROP VIEW vw_EmployeeFullName;
GO

IF OBJECT_ID('vw_EmployeeBasicInfo', 'V') IS NOT NULL
    DROP VIEW vw_EmployeeBasicInfo;
GO

/* =====================================================
   DROP TABLES IF THEY EXIST
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
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');
GO

INSERT INTO Employees VALUES
(101, 'John', 'Smith', 1, 50000, '2022-01-15'),
(102, 'Alice', 'Brown', 2, 60000, '2021-05-10'),
(103, 'David', 'Wilson', 3, 70000, '2020-08-20'),
(104, 'Emma', 'Johnson', 2, 55000, '2023-02-11'),
(105, 'Michael', 'Davis', 4, 65000, '2022-07-05');
GO

/* =====================================================
   EXERCISE 1
   CREATE SIMPLE VIEW
   ===================================================== */

CREATE VIEW vw_EmployeeBasicInfo
AS
SELECT
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    D.DepartmentName
FROM Employees E
INNER JOIN Departments D
ON E.DepartmentID = D.DepartmentID;
GO

/* =====================================================
   EXERCISE 2
   VIEW WITH FULL NAME
   ===================================================== */

CREATE VIEW vw_EmployeeFullName
AS
SELECT
    EmployeeID,
    FirstName,
    LastName,
    FirstName + ' ' + LastName AS FullName
FROM Employees;
GO

/* =====================================================
   EXERCISE 3
   VIEW WITH ANNUAL SALARY
   ===================================================== */

CREATE VIEW vw_EmployeeAnnualSalary
AS
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    Salary * 12 AS AnnualSalary
FROM Employees;
GO

/* =====================================================
   EXERCISE 4
   EMPLOYEE REPORT VIEW
   ===================================================== */

CREATE VIEW vw_EmployeeReport
AS
SELECT
    E.EmployeeID,
    E.FirstName + ' ' + E.LastName AS FullName,
    D.DepartmentName,
    E.Salary * 12 AS AnnualSalary,
    (E.Salary * 12) * 0.10 AS Bonus
FROM Employees E
INNER JOIN Departments D
ON E.DepartmentID = D.DepartmentID;
GO

/* =====================================================
   DISPLAY RESULTS
   ===================================================== */

PRINT '===== VIEW 1 : BASIC INFO =====';
SELECT * FROM vw_EmployeeBasicInfo;
GO

PRINT '===== VIEW 2 : FULL NAME =====';
SELECT * FROM vw_EmployeeFullName;
GO

PRINT '===== VIEW 3 : ANNUAL SALARY =====';
SELECT * FROM vw_EmployeeAnnualSalary;
GO

PRINT '===== VIEW 4 : EMPLOYEE REPORT =====';
SELECT * FROM vw_EmployeeReport;
GO
