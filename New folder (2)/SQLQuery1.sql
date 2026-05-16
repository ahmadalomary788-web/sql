CREATE DATABASE Company;
USE Company;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,      
    department_name VARCHAR(50)        
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,        
    employee_name VARCHAR(50),         
    department_id INT,                   
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE EmployeeCards (
    card_id INT PRIMARY KEY,           
    employee_id INT UNIQUE,             
    issue_date DATE,                    
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,         
    project_name VARCHAR(50)            
);

CREATE TABLE EmployeeProjects (
    employee_id INT,
    project_id INT,
    PRIMARY KEY (employee_id, project_id), 
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

INSERT INTO Departments VALUES(1,'IT'),(2,'HR'),(3,'Finance');
INSERT INTO Employees VALUES(1,'Ahmad',1),(2,'Mohammad',1),(3,'Omar',2),(4,'Ali',NULL);
INSERT INTO EmployeeCards VALUES(1,1,'2024-01-01'),(2,2,'2024-01-05'),(3,3,'2024-02-01');
INSERT INTO Projects VALUES(1,'Website'),(2,'Mobile App'),(3,'Accounting System');
INSERT INTO EmployeeProjects VALUES(1,1),  (1,2),  (2,1),  (3,3);   

-- =========================================
-- 1-to-1 (1-1) Relationship: Employee & EmployeeCard
-- One employee has exactly one card, and one card belongs to one employee.
-- INNER JOIN: Returns employees who have a card issued to them.
-- =========================================
SELECT Employees.employee_name, EmployeeCards.issue_date
FROM Employees
INNER JOIN EmployeeCards
ON Employees.employee_id = EmployeeCards.employee_id;

-- =========================================
-- 1-to-Many (1-M) Relationship: Department & Employees
-- One department can have many employees, but an employee belongs to only one department.
-- INNER JOIN: Returns only employees who are assigned to a specific department.
-- =========================================
SELECT Employees.employee_name, Departments.department_name
FROM Employees
INNER JOIN Departments
ON Employees.department_id = Departments.department_id;

-- =========================================
-- Many-to-Many (M-N) Relationship: Employees & Projects
-- An employee can work on many projects, and a project can have many employees.
-- This requires joining three tables using the junction table (EmployeeProjects).
-- INNER JOIN: Returns employees and the projects they are actively working on.
-- =========================================
SELECT Employees.employee_name, Projects.project_name
FROM Employees
INNER JOIN EmployeeProjects
ON Employees.employee_id = EmployeeProjects.employee_id
INNER JOIN Projects
ON EmployeeProjects.project_id = Projects.project_id;

-- =========================================
-- 1-to-Many (1-M) Relationship (Same as above)
-- INNER JOIN: Returns only rows that have matching values in both tables.
-- =========================================
SELECT Employees.employee_name, Departments.department_name
FROM Employees
INNER JOIN Departments
ON Employees.department_id = Departments.department_id;

-- =========================================
-- 1-to-Many (1-M) Relationship: Department & Employees
-- LEFT JOIN: Returns ALL employees (left table), even if they are NOT assigned to any department (like 'Ali').
-- =========================================
SELECT Employees.employee_name, Departments.department_name
FROM Employees
LEFT JOIN Departments
ON Employees.department_id = Departments.department_id;

-- =========================================
-- 1-to-Many (1-M) Relationship: Department & Employees
-- RIGHT JOIN: Returns ALL departments (right table), even if they have NO employees (like 'Finance').
-- =========================================
SELECT Employees.employee_name, Departments.department_name
FROM Employees
RIGHT JOIN Departments
ON Employees.department_id = Departments.department_id;

-- =========================================
-- 1-to-Many (1-M) Relationship: Department & Employees
-- FULL JOIN: Returns ALL employees and ALL departments, matching them where possible. 
-- Shows employees without departments AND departments without employees.
-- =========================================
SELECT Employees.employee_name, Departments.department_name
FROM Employees
FULL JOIN Departments
ON Employees.department_id = Departments.department_id;