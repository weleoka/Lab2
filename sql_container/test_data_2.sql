-- Create Database, Tables, and Load Test Data

-- Recreate Database
CREATE DATABASE Test_IT2;
USE Test_IT2;

-- Create Students table
CREATE TABLE Students(
	Student_ID varchar(8),
	Name varchar(40),
	Email varchar(50),
	Status tinyint,
	PRIMARY KEY (Student_ID)
);

-- Create Grades table
CREATE TABLE Grades(
	Student_ID varchar(8),
	Course varchar(40),
	Grade varchar(50),
	FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID)
);

-- Load test data - students
INSERT INTO Students(Student_ID, Name, Email, Status)
VALUES('TodBoo-2', 'Todd Booth 2', 'TodBoo-2@Student.Ltu.Se', 1);

-- Load test data - students
INSERT INTO Students(Student_ID, Name, Email, Status)
VALUES('TodBoo-1', 'Todd Booth', 'TodBoo-1@Student.Ltu.Se', 1);

INSERT INTO Students(Student_ID, Name, Email, Status)
VALUES('SveAnd-7', 'Sven Andersson', 'SveAnt-7@Student.Ltu.Se', 0);

-- Load test data - grades
INSERT INTO Grades(Student_ID, Course, Grade)
VALUES('TodBoo-2', 'I0015N', 'VG');

INSERT INTO Grades(Student_ID, Course, Grade)
VALUES('TodBoo-1', 'I0015N', 'G');

INSERT INTO Grades(Student_ID, Course, Grade)
VALUES('SveAnd-7', 'I0015N', 'VG');

-- List all rows
SELECT * FROM Students;
SELECT * FROM Grades;
