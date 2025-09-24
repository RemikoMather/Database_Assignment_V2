# Database Normalization: Step-by-Step Process (1NF → 2NF → 3NF)

## Introduction
This document demonstrates the normalization process of a university database, showing the transformation from an unnormalized table through First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF).

## Original Unnormalized Table

Let's start with a poorly designed table that contains all student and course information in a single table:

### Student_Course_Info (Unnormalized)
| StudentID | StudentName | StudentEmail | StudentMajor | StudentGPA | CourseID | CourseName | CourseCredits | InstructorName | InstructorEmail | DepartmentName | DepartmentHead |
|-----------|-------------|--------------|--------------|------------|----------|------------|---------------|----------------|-----------------|----------------|----------------|
| 1 | John Smith | john@uni.edu | Computer Science | 3.8 | CS101 | Intro to Programming | 3 | Dr. Johnson | johnson@uni.edu | Computer Science | Dr. Williams |
| 1 | John Smith | john@uni.edu | Computer Science | 3.8 | MATH201 | Calculus II | 4 | Dr. Brown | brown@uni.edu | Mathematics | Dr. Davis |
| 2 | Jane Doe | jane@uni.edu | Mathematics | 3.9 | MATH201 | Calculus II | 4 | Dr. Brown | brown@uni.edu | Mathematics | Dr. Davis |
| 2 | Jane Doe | jane@uni.edu | Mathematics | 3.9 | PHYS101 | Physics I | 3 | Dr. Wilson | wilson@uni.edu | Physics | Dr. Taylor |
| 3 | Bob Johnson | bob@uni.edu | Engineering | 3.7 | CS101 | Intro to Programming | 3 | Dr. Johnson | johnson@uni.edu | Computer Science | Dr. Williams |

### Problems with Unnormalized Data:
1. **Data Redundancy**: Student information is repeated for each course enrollment
2. **Update Anomalies**: Changing a student's email requires updating multiple rows
3. **Insert Anomalies**: Cannot add a course without enrolling a student
4. **Delete Anomalies**: Deleting a student removes course information
5. **Storage Waste**: Duplicate data consumes unnecessary space

---

## First Normal Form (1NF)

### Definition
A table is in 1NF if:
- All columns contain atomic (indivisible) values
- Each column contains values of a single type
- Each column has a unique name
- The order of rows and columns doesn't matter

### Analysis
Our original table already meets 1NF requirements:
- ✅ All values are atomic
- ✅ Each column has a single data type
- ✅ Column names are unique
- ✅ No repeating groups

### 1NF Table (Same as Original)
The unnormalized table above is already in 1NF, but it still has significant redundancy issues.

---

## Second Normal Form (2NF)

### Definition
A table is in 2NF if:
- It is in 1NF
- All non-key attributes are fully functionally dependent on the primary key

### Analysis
Our current table has a composite primary key: (StudentID, CourseID)

**Functional Dependencies:**
- StudentID → StudentName, StudentEmail, StudentMajor, StudentGPA
- CourseID → CourseName, CourseCredits, InstructorName, InstructorEmail, DepartmentName, DepartmentHead
- (StudentID, CourseID) → (enrollment relationship)

**Problem**: Non-key attributes depend on only part of the primary key, violating 2NF.

### Solution: Decompose into Multiple Tables

#### Table 1: Students
| StudentID | StudentName | StudentEmail | StudentMajor | StudentGPA |
|-----------|-------------|--------------|--------------|------------|
| 1 | John Smith | john@uni.edu | Computer Science | 3.8 |
| 2 | Jane Doe | jane@uni.edu | Mathematics | 3.9 |
| 3 | Bob Johnson | bob@uni.edu | Engineering | 3.7 |

**Primary Key**: StudentID

#### Table 2: Courses
| CourseID | CourseName | CourseCredits | InstructorName | InstructorEmail | DepartmentName | DepartmentHead |
|----------|------------|---------------|----------------|-----------------|----------------|----------------|
| CS101 | Intro to Programming | 3 | Dr. Johnson | johnson@uni.edu | Computer Science | Dr. Williams |
| MATH201 | Calculus II | 4 | Dr. Brown | brown@uni.edu | Mathematics | Dr. Davis |
| PHYS101 | Physics I | 3 | Dr. Wilson | wilson@uni.edu | Physics | Dr. Taylor |

**Primary Key**: CourseID

#### Table 3: Enrollments
| StudentID | CourseID |
|-----------|----------|
| 1 | CS101 |
| 1 | MATH201 |
| 2 | MATH201 |
| 2 | PHYS101 |
| 3 | CS101 |

**Primary Key**: (StudentID, CourseID)
**Foreign Keys**: StudentID references Students(StudentID), CourseID references Courses(CourseID)

### Benefits of 2NF:
- ✅ Eliminated partial dependencies
- ✅ Reduced data redundancy
- ✅ Improved update efficiency
- ✅ Separated concerns logically

---

## Third Normal Form (3NF)

### Definition
A table is in 3NF if:
- It is in 2NF
- No non-key attribute is transitively dependent on the primary key

### Analysis
Looking at our 2NF tables:

**Students Table**: ✅ Already in 3NF (no transitive dependencies)

**Courses Table**: ❌ Has transitive dependencies:
- CourseID → InstructorName → InstructorEmail
- CourseID → DepartmentName → DepartmentHead

**Enrollments Table**: ✅ Already in 3NF (only key attributes)

### Solution: Further Decomposition

#### Table 1: Students (No Change)
| StudentID | StudentName | StudentEmail | StudentMajor | StudentGPA |
|-----------|-------------|--------------|--------------|------------|
| 1 | John Smith | john@uni.edu | Computer Science | 3.8 |
| 2 | Jane Doe | jane@uni.edu | Mathematics | 3.9 |
| 3 | Bob Johnson | bob@uni.edu | Engineering | 3.7 |

**Primary Key**: StudentID

#### Table 2: Departments
| DepartmentID | DepartmentName | DepartmentHead |
|--------------|----------------|----------------|
| 1 | Computer Science | Dr. Williams |
| 2 | Mathematics | Dr. Davis |
| 3 | Physics | Dr. Taylor |

**Primary Key**: DepartmentID

#### Table 3: Instructors
| InstructorID | InstructorFirstName | InstructorLastName | InstructorEmail | DepartmentID |
|--------------|--------------------|--------------------|-----------------|--------------|
| 1 | Dr. | Johnson | johnson@uni.edu | 1 |
| 2 | Dr. | Brown | brown@uni.edu | 2 |
| 3 | Dr. | Wilson | wilson@uni.edu | 3 |

**Primary Key**: InstructorID
**Foreign Key**: DepartmentID references Departments(DepartmentID)

#### Table 4: Courses
| CourseID | CourseName | CourseCredits | InstructorID |
|----------|------------|---------------|--------------|
| CS101 | Intro to Programming | 3 | 1 |
| MATH201 | Calculus II | 4 | 2 |
| PHYS101 | Physics I | 3 | 3 |

**Primary Key**: CourseID
**Foreign Key**: InstructorID references Instructors(InstructorID)

#### Table 5: Enrollments (No Change)
| StudentID | CourseID |
|-----------|----------|
| 1 | CS101 |
| 1 | MATH201 |
| 2 | MATH201 |
| 2 | PHYS101 |
| 3 | CS101 |

**Primary Key**: (StudentID, CourseID)
**Foreign Keys**: StudentID references Students(StudentID), CourseID references Courses(CourseID)

---

## Summary of Normalization Benefits

### Before Normalization (Unnormalized):
- ❌ Massive data redundancy
- ❌ Update anomalies
- ❌ Insert anomalies
- ❌ Delete anomalies
- ❌ Wasted storage space

### After 1NF:
- ✅ Atomic values
- ✅ Consistent data types
- ❌ Still has redundancy issues

### After 2NF:
- ✅ Eliminated partial dependencies
- ✅ Reduced redundancy significantly
- ✅ Improved data integrity
- ❌ Still has some transitive dependencies

### After 3NF:
- ✅ Eliminated transitive dependencies
- ✅ Minimized data redundancy
- ✅ Improved data integrity
- ✅ Efficient storage utilization
- ✅ Easier maintenance and updates
- ✅ Better query performance
- ✅ Scalable design

## Relationship Summary

The final normalized database consists of:

1. **Students** (1) ←→ (Many) **Enrollments** ←→ (Many) (1) **Courses**
2. **Instructors** (1) ←→ (Many) **Courses**
3. **Departments** (1) ←→ (Many) **Instructors**

This creates a well-structured relational database that:
- Eliminates redundancy
- Ensures data integrity
- Supports efficient querying
- Allows for easy maintenance and updates
- Scales well with growing data

## Conclusion

The normalization process transformed a single, problematic table into a well-designed relational database with five interconnected tables. Each normal form addressed specific issues:

- **1NF**: Ensured atomic values
- **2NF**: Eliminated partial dependencies
- **3NF**: Eliminated transitive dependencies

The result is a robust, efficient, and maintainable database structure that follows relational database best practices.
