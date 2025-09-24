-- Database Assignment V2 - Sample Data
-- This file contains sample data for the normalized university database

-- =====================================================
-- CREATE TABLES (DDL - Data Definition Language)
-- =====================================================

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    DepartmentHead VARCHAR(100) NOT NULL
);

-- Create Instructors table
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Major VARCHAR(100),
    GPA DECIMAL(3,2),
    EnrollmentDate DATE
);

-- Create Courses table
CREATE TABLE Courses (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

-- Create Enrollments table (Junction table for many-to-many relationship)
CREATE TABLE Enrollments (
    StudentID INT,
    CourseID VARCHAR(10),
    EnrollmentDate DATE,
    Grade VARCHAR(2),
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- =====================================================
-- INSERT SAMPLE DATA (DML - Data Manipulation Language)
-- =====================================================

-- Insert Departments
INSERT INTO Departments (DepartmentID, DepartmentName, DepartmentHead) VALUES
(1, 'Computer Science', 'Dr. Williams'),
(2, 'Mathematics', 'Dr. Davis'),
(3, 'Physics', 'Dr. Taylor'),
(4, 'Engineering', 'Dr. Anderson'),
(5, 'Business', 'Dr. Martinez');

-- Insert Instructors
INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID) VALUES
(1, 'Michael', 'Johnson', 'johnson@university.edu', 1),
(2, 'Sarah', 'Brown', 'brown@university.edu', 2),
(3, 'David', 'Wilson', 'wilson@university.edu', 3),
(4, 'Emily', 'Garcia', 'garcia@university.edu', 1),
(5, 'Robert', 'Miller', 'miller@university.edu', 2),
(6, 'Lisa', 'Jones', 'jones@university.edu', 4),
(7, 'James', 'Smith', 'smith@university.edu', 5),
(8, 'Maria', 'Rodriguez', 'rodriguez@university.edu', 3);

-- Insert Students
INSERT INTO Students (StudentID, FirstName, LastName, Email, Major, GPA, EnrollmentDate) VALUES
(1, 'John', 'Smith', 'john.smith@student.edu', 'Computer Science', 3.8, '2023-08-15'),
(2, 'Jane', 'Doe', 'jane.doe@student.edu', 'Mathematics', 3.9, '2023-08-15'),
(3, 'Bob', 'Johnson', 'bob.johnson@student.edu', 'Engineering', 3.7, '2023-08-16'),
(4, 'Alice', 'Williams', 'alice.williams@student.edu', 'Physics', 3.6, '2023-08-16'),
(5, 'Charlie', 'Brown', 'charlie.brown@student.edu', 'Computer Science', 3.5, '2023-08-17'),
(6, 'Diana', 'Davis', 'diana.davis@student.edu', 'Business', 3.4, '2023-08-17'),
(7, 'Edward', 'Wilson', 'edward.wilson@student.edu', 'Mathematics', 3.8, '2023-08-18'),
(8, 'Fiona', 'Garcia', 'fiona.garcia@student.edu', 'Physics', 3.7, '2023-08-18'),
(9, 'George', 'Miller', 'george.miller@student.edu', 'Engineering', 3.6, '2023-08-19'),
(10, 'Helen', 'Jones', 'helen.jones@student.edu', 'Business', 3.9, '2023-08-19');

-- Insert Courses
INSERT INTO Courses (CourseID, CourseName, Credits, InstructorID) VALUES
('CS101', 'Introduction to Programming', 3, 1),
('CS201', 'Data Structures', 3, 4),
('CS301', 'Database Management', 3, 1),
('MATH101', 'Calculus I', 4, 2),
('MATH201', 'Calculus II', 4, 5),
('MATH301', 'Linear Algebra', 3, 2),
('PHYS101', 'Physics I', 3, 3),
('PHYS201', 'Physics II', 3, 8),
('ENG101', 'Engineering Fundamentals', 3, 6),
('ENG201', 'Thermodynamics', 4, 6),
('BUS101', 'Introduction to Business', 3, 7),
('BUS201', 'Marketing Principles', 3, 7);

-- Insert Enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade) VALUES
-- John Smith (Computer Science)
(1, 'CS101', '2023-08-20', 'A'),
(1, 'MATH101', '2023-08-20', 'B+'),
(1, 'CS201', '2023-08-20', 'A-'),

-- Jane Doe (Mathematics)
(2, 'MATH101', '2023-08-20', 'A'),
(2, 'MATH201', '2023-08-20', 'A'),
(2, 'PHYS101', '2023-08-20', 'B+'),

-- Bob Johnson (Engineering)
(3, 'ENG101', '2023-08-21', 'B+'),
(3, 'MATH101', '2023-08-21', 'B'),
(3, 'PHYS101', '2023-08-21', 'B+'),

-- Alice Williams (Physics)
(4, 'PHYS101', '2023-08-21', 'A-'),
(4, 'MATH101', '2023-08-21', 'B+'),
(4, 'PHYS201', '2023-08-21', 'A'),

-- Charlie Brown (Computer Science)
(5, 'CS101', '2023-08-22', 'B'),
(5, 'MATH101', '2023-08-22', 'B-'),
(5, 'CS201', '2023-08-22', 'B+'),

-- Diana Davis (Business)
(6, 'BUS101', '2023-08-22', 'A-'),
(6, 'BUS201', '2023-08-22', 'B+'),
(6, 'MATH101', '2023-08-22', 'B'),

-- Edward Wilson (Mathematics)
(7, 'MATH101', '2023-08-23', 'A'),
(7, 'MATH201', '2023-08-23', 'A-'),
(7, 'MATH301', '2023-08-23', 'A'),

-- Fiona Garcia (Physics)
(8, 'PHYS101', '2023-08-23', 'B+'),
(8, 'PHYS201', '2023-08-23', 'A-'),
(8, 'MATH201', '2023-08-23', 'B+'),

-- George Miller (Engineering)
(9, 'ENG101', '2023-08-24', 'B'),
(9, 'ENG201', '2023-08-24', 'B+'),
(9, 'MATH101', '2023-08-24', 'B-'),

-- Helen Jones (Business)
(10, 'BUS101', '2023-08-24', 'A'),
(10, 'BUS201', '2023-08-24', 'A-'),
(10, 'MATH101', '2023-08-24', 'A-');

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================

-- Verify data insertion
SELECT 'Departments' as TableName, COUNT(*) as RecordCount FROM Departments
UNION ALL
SELECT 'Instructors', COUNT(*) FROM Instructors
UNION ALL
SELECT 'Students', COUNT(*) FROM Students
UNION ALL
SELECT 'Courses', COUNT(*) FROM Courses
UNION ALL
SELECT 'Enrollments', COUNT(*) FROM Enrollments;

-- =====================================================
-- SAMPLE QUERIES TO TEST THE DATA
-- =====================================================

-- Query 1: Show all students with their majors
SELECT StudentID, FirstName, LastName, Major, GPA 
FROM Students 
ORDER BY Major, LastName;

-- Query 2: Show all courses with instructor information
SELECT c.CourseID, c.CourseName, c.Credits, 
       i.FirstName + ' ' + i.LastName AS InstructorName,
       d.DepartmentName
FROM Courses c
JOIN Instructors i ON c.InstructorID = i.InstructorID
JOIN Departments d ON i.DepartmentID = d.DepartmentID
ORDER BY d.DepartmentName, c.CourseName;

-- Query 3: Show student enrollments with grades
SELECT s.FirstName + ' ' + s.LastName AS StudentName,
       c.CourseName,
       e.Grade,
       c.Credits
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
ORDER BY s.LastName, c.CourseName;

-- Query 4: Show enrollment statistics by department
SELECT d.DepartmentName,
       COUNT(DISTINCT c.CourseID) AS CoursesOffered,
       COUNT(e.StudentID) AS TotalEnrollments
FROM Departments d
JOIN Instructors i ON d.DepartmentID = i.DepartmentID
JOIN Courses c ON i.InstructorID = c.InstructorID
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY TotalEnrollments DESC;

-- Query 5: Show students with highest GPAs
SELECT TOP 5 FirstName, LastName, Major, GPA
FROM Students
ORDER BY GPA DESC;

-- =====================================================
-- ADDITIONAL SAMPLE DATA FOR TESTING
-- =====================================================

-- Add more sample enrollments for comprehensive testing
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade) VALUES
(1, 'CS301', '2024-01-15', 'A'),
(2, 'MATH301', '2024-01-15', 'A-'),
(3, 'ENG201', '2024-01-16', 'B+'),
(4, 'MATH201', '2024-01-16', 'A'),
(5, 'CS301', '2024-01-17', 'B+');

-- =====================================================
-- NOTES AND COMMENTS
-- =====================================================

/*
This sample dataset demonstrates:

1. Normalized Database Structure:
   - 5 tables representing different entities
   - Proper primary and foreign key relationships
   - No data redundancy

2. Realistic University Data:
   - 5 departments with department heads
   - 8 instructors across different departments
   - 10 students with various majors
   - 12 courses across different departments
   - Multiple enrollments showing student-course relationships

3. Data Integrity:
   - All foreign key constraints are satisfied
   - Realistic GPA values (3.4 - 3.9)
   - Proper email formats
   - Consistent naming conventions

4. Query Testing:
   - Sample queries demonstrate various SQL operations
   - JOIN operations across multiple tables
   - Aggregate functions and grouping
   - Sorting and filtering examples

5. Scalability:
   - Structure supports easy addition of new records
   - Relationships allow for complex queries
   - Normalized design prevents data anomalies

This dataset can be used to test all the queries in queries.sql
and demonstrates the benefits of the normalized database structure
described in normalization.md.
*/
