CREATE DATABASE fun;
USE  fun;
CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    Department VARCHAR(50)
);

INSERT INTO Employees VALUES (1, 'Ali', 4000, 'IT');
INSERT INTO Employees VALUES (2, 'Ahmad', 7000, 'CE');
INSERT INTO Employees VALUES (3, 'Omar', 3000, 'IT');
INSERT INTO Employees VALUES (4, 'khaled', 9000, 'Finance');
--Scalar Function
CREATE FUNCTION GetSalaryLevel (@Salary INT)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @Result VARCHAR(10);

    IF @Salary > 5000
        SET @Result = 'High';
    ELSE
        SET @Result = 'Low';

    RETURN @Result;
END;

SELECT Name, Salary, dbo.GetSalaryLevel(Salary) AS Level
FROM Employees;
--Table-Valued Function
CREATE FUNCTION GetEmployeesByDept (@Dept VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Employees
    WHERE Department = @Dept
);
SELECT * FROM GetEmployeesByDept('IT');
--Stored Procedure (SELECT)
CREATE PROCEDURE GetEmployeeById
    @Id INT
AS
BEGIN
    SELECT * FROM Employees WHERE Id = @Id;
END;
EXEC GetEmployeeById 2;
--Stored Procedure (INSERT)
CREATE PROCEDURE AddEmployee
    @Id INT,
    @Name VARCHAR(50),
    @Salary INT,
    @Dept VARCHAR(50)
AS
BEGIN
    INSERT INTO Employees (Id, Name, Salary, Department)
    VALUES (@Id, @Name, @Salary, @Dept);
END;
EXEC AddEmployee 5, 'Khaled', 6000, 'IT';
--Stored Procedure (UPDATE)
CREATE PROCEDURE UpdateSalary
    @Id INT,
    @Salary INT
AS
BEGIN
    UPDATE Employees
    SET Salary = @Salary
    WHERE Id = @Id;
END;

EXEC UpdateSalary 1, 8000;

--Stored Procedure (DELETE)
CREATE PROCEDURE DeleteEmployee
    @Id INT
AS
BEGIN
    DELETE FROM Employees
    WHERE Id = @Id;
END;
EXEC DeleteEmployee 3;