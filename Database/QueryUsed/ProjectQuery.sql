

--============================================ HR MANAGEMENT SYSTEM DB======================================

--------------------------------- Definition ----------------------------

CREATE DATABASE HR;

USE HR;

-- Table 1

CREATE TABlE UserRole
(
	[Role Id] TINYINT PRIMARY KEY,
	[Role Name] VARCHAR(30),
	Pemissions VARCHAR(100)
);



-- Table 2

CREATE TABLE Employee
(
	EmployeeID INT PRIMARY KEY,
	FullName NVARCHAR(50) NOT NULL,
	Gender Char(1) CHECK (Gender IN ('M','F')),
	BirthDate DATE,
	Phone VARCHAR(15) UNIQUE,
	Email VARCHAR(50) UNIQUE,
	Address NVARCHAR(100),
	Status VARCHAR(30),
	HireDate DATE
)


-- Table 3


CREATE TABLE Departments
(
	DepartmentID INT PRIMARY KEY,
	DepartmentName VARCHAR(30) UNIQUE NOT NULL,
	Location NVARCHAR(100),
	ManagerID INT,
	FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID)
)



ALTER TABLE Departments
ALTER COLUMN ManagerID INT NULL;

-- Table 4

CREATE TABLE JOB
(
	JobID SMALLINT PRIMARY KEY,
	JobTitle VARCHAR(30) UNIQUE NOT NULL,
	JobDescription NVARCHAR(200),
	SalaryGrade VARCHAR(10)
)


CREATE TABLE Payroll
(
	PayrollID INT PRIMARY KEY,
	EmployeeID INT NOT NULL,
	Month DATE NOT NULL,
	BaseSalary DECIMAL(10 ,2),
	Bonus DECIMAL(10,2),
	Deductions DECIMAL(10,2),
	FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)

ALTER TABLE Payroll
ADD NetPay DECIMAL(10,2)

-- Table 6


CREATE TABLE Attendence
(
	RecordID INT PRIMARY KEY,
	EmployeeID INT NOT NULL,
	AttendanceDate DATE NOT NULL,
	CheckIn TIME(0) NOT NULL,
	CheckOut TIME(0) NOT NULL,
	HoursWorked DECIMAL(4,2) -- Calculated in program, up to 999 min
	FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)


-- ADDING THE FKs TO EMPLOYEE

ALTER TABLE Employee
ADD
	DepartmentID INT,
	JobID SMALLINT




ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Department
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)

ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Job
FOREIGN KEY (JobID) REFERENCES Job(JobID)

-------------------------------- Manipulation ------------------------------
INSERT INTO UserRole
VALUES
	(1, 'HR Manager', 'Full access to employee data, payroll, attendance, and roles management'),
	(2, 'Department Manager', 'Access to team attendance, view payroll summary, limited employee data'),
	(3, 'Employee', 'View own attendance and payroll records');


-- Test

SELECT * FROM UserRole;




INSERT INTO JOB (JobID, JobTitle, JobDescription, SalaryGrade)
VALUES 
(1, 'Software Engineer', 'Develops and maintains software applications.', 'G7'),

(2, 'Data Analyst', 'Analyzes data to help decision-making.', 'G6'),

(3, 'HR Manager', 'Manages human resources operations and policies.', 'G8'),

(4, 'System Administrator', 'Maintains and monitors IT infrastructure.', 'G7'),

(5, 'Product Manager', 'Oversees product planning and delivery.', 'G9');


SELECT * FROM Job




INSERT INTO Departments (DepartmentID, DepartmentName, Location)
VALUES 
(10, 'IT Department', 'Cairo HQ'),

(20, 'HR Department', 'Alexandria Office');

SELECT * FROM Departments



INSERT INTO Employee (EmployeeID, FullName, Gender, BirthDate, Phone, Email, Address, Status, HireDate, DepartmentID, JobID)
VALUES 
(102, 'Mohamed Adel', 'M', '1985-2-2', '01055432212', 'sara.adel@gmail.com', 'Nasr City, Cairo', 'Active', '2024-06-01', 10, 3);


SELECT * FROM Employee




INSERT INTO Attendence (RecordID, EmployeeID, AttendanceDate, CheckIn, CheckOut, HoursWorked)
VALUES 
(1, 101, '2025-07-08', '09:00:00', '17:30:00', 8.50),
(2, 102, '2025-07-08', '08:45:00', '16:15:00', 7.50);

SELECT * FROM Attendence;



INSERT INTO Payroll (PayrollID, EmployeeID, Month, BaseSalary, Bonus, Deductions)
VALUES
(1, 101, '2025-07-01', 12000.00, 1000.00, 500.00),
(2, 102, '2025-07-01', 9500.00, 500.00, 0.00);

SELECT * FROM Payroll;

