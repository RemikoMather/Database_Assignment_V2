-- Database Assignment V2 - SQL Queries
-- This file contains SQL query examples demonstrating basic database operations

-- =====================================================
-- BASIC SELECT QUERIES
-- =====================================================

-- Query 1: Retrieve all students
SELECT * FROM Students;

-- Query 2: Retrieve specific columns from students
SELECT StudentID, FirstName, LastName, Email 
FROM Students;

-- Query 3: Retrieve students with specific criteria
SELECT FirstName, LastName, Major 
FROM Students 
WHERE Major = 'Computer Science';

-- Query 4: Retrieve students ordered by last name
SELECT StudentID, FirstName, LastName, GPA 
FROM Students 
ORDER BY LastName ASC;

-- =====================================================
-- FILTERING AND CONDITIONAL QUERIES
-- =====================================================

-- Query 5: Students with GPA above 3.5
SELECT FirstName, LastName, GPA 
FROM Students 
WHERE GPA > 3.5;

-- Query 6: Students enrolled after a specific date
SELECT FirstName, LastName, EnrollmentDate 
FROM Students 
WHERE EnrollmentDate > '2023-01-01';

-- Query 7: Students with specific majors
SELECT FirstName, LastName, Major 
FROM Students 
WHERE Major IN ('Computer Science', 'Mathematics', 'Engineering');

-- Query 8: Students with names starting with 'A'
SELECT FirstName, LastName 
FROM Students 
WHERE FirstName LIKE 'A%';

-- =====================================================
-- JOIN QUERIES (Demonstrating Relationships)
-- =====================================================

-- Query 9: Students with their enrolled courses
SELECT s.FirstName, s.LastName, c.CourseName, c.Credits
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;

-- Query 10: Courses with instructor information
SELECT c.CourseName, c.Credits, i.FirstName AS InstructorFirstName, 
       i.LastName AS InstructorLastName, d.DepartmentName
FROM Courses c
JOIN Instructors i ON c.InstructorID = i.InstructorID
JOIN Departments d ON i.DepartmentID = d.DepartmentID;

-- Query 11: Students enrolled in specific course
SELECT s.FirstName, s.LastName, s.Email
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Database Management';

-- =====================================================
-- AGGREGATE FUNCTIONS
-- =====================================================

-- Query 12: Count total number of students
SELECT COUNT(*) AS TotalStudents FROM Students;

-- Query 13: Average GPA of all students
SELECT AVG(GPA) AS AverageGPA FROM Students;

-- Query 14: Count students by major
SELECT Major, COUNT(*) AS StudentCount 
FROM Students 
GROUP BY Major;

-- Query 15: Total credits by course
SELECT CourseName, Credits 
FROM Courses 
ORDER BY Credits DESC;

-- =====================================================
-- ADVANCED QUERIES
-- =====================================================

-- Query 16: Students with highest GPA
SELECT FirstName, LastName, GPA 
FROM Students 
WHERE GPA = (SELECT MAX(GPA) FROM Students);

-- Query 17: Courses with enrollment count
SELECT c.CourseName, COUNT(e.StudentID) AS EnrollmentCount
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
ORDER BY EnrollmentCount DESC;

-- Query 18: Students not enrolled in any course
SELECT s.FirstName, s.LastName 
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;

-- Query 19: Instructors and their course load
SELECT i.FirstName, i.LastName, COUNT(c.CourseID) AS CourseCount
FROM Instructors i
LEFT JOIN Courses c ON i.InstructorID = c.InstructorID
GROUP BY i.InstructorID, i.FirstName, i.LastName;

-- =====================================================
-- UPDATE AND DELETE EXAMPLES (Commented for safety)
-- =====================================================

-- Update student GPA
-- UPDATE Students 
-- SET GPA = 3.8 
-- WHERE StudentID = 1;

-- Update student email
-- UPDATE Students 
-- SET Email = 'newemail@university.edu' 
-- WHERE StudentID = 2;

-- Delete enrollment record
-- DELETE FROM Enrollments 
-- WHERE StudentID = 3 AND CourseID = 2;

-- =====================================================
-- DATA ANALYSIS QUERIES
-- =====================================================

-- Query 20: Department with most students
SELECT d.DepartmentName, COUNT(s.StudentID) AS StudentCount
FROM Departments d
JOIN Instructors i ON d.DepartmentID = i.DepartmentID
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
JOIN Students s ON e.StudentID = s.StudentID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY StudentCount DESC;

-- Query 21: Students with multiple course enrollments
SELECT s.FirstName, s.LastName, COUNT(e.CourseID) AS CourseCount
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(e.CourseID) > 1;

-- =====================================================
-- NOTES AND EXPLANATIONS
-- =====================================================

/*
Query Explanations:

1. Basic SELECT queries demonstrate fundamental data retrieval
2. WHERE clauses show how to filter data based on conditions
3. JOIN operations illustrate relationships between tables
4. Aggregate functions (COUNT, AVG, MAX) provide data summaries
5. GROUP BY and HAVING clauses enable data grouping and filtering
6. Subqueries demonstrate advanced query techniques
7. LEFT JOIN shows how to include records even when no matches exist

These queries demonstrate the normalized database structure where:
- Students table contains student information
- Courses table contains course details
- Instructors table contains instructor information
- Departments table contains department data
- Enrollments table manages many-to-many relationships between students and courses

The queries progress from simple to complex, showing various SQL capabilities
and demonstrating how normalized tables work together to provide meaningful data.
*/
