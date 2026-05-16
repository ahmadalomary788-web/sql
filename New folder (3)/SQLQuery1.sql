CREATE DATABASE UniversityDB;

USE UniversityDB;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    instructor VARCHAR(50)
);

CREATE TABLE Enrollment (
    student_id INT,
    course_id INT,
    semester VARCHAR(20),
    grade CHAR(2),

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Students VALUES (1, 'Ahmad', 23, 'Irbid');
INSERT INTO Students VALUES (2, 'Mohammad', 22, 'Irbid');
INSERT INTO Students VALUES (3, 'Ali', 20, 'Amman');
INSERT INTO Students VALUES (4, 'Yazan', 23, 'Zarqa');
INSERT INTO Students VALUES (5, 'Omar', 21, 'Irbid');
INSERT INTO Students VALUES (6, 'Hasan', 21, 'Amman');

INSERT INTO Courses VALUES (101, 'Database Systems', 'Dr.Hussien');
INSERT INTO Courses VALUES (102, 'Security', 'Dr. Haitham');
INSERT INTO Courses VALUES (103, 'Computer Networks', 'Dr. Mohammad');
INSERT INTO Courses VALUES (104, 'Operating Systems', 'Dr.safaa');

INSERT INTO Enrollment VALUES (1, 101, 'second 2026', 'A');
INSERT INTO Enrollment VALUES (1, 102, 'First 2026', 'C');
INSERT INTO Enrollment VALUES (2, 101, 'First 2025', 'A+');
INSERT INTO Enrollment VALUES (3, 103, 'Spring2026', 'B-');
INSERT INTO Enrollment VALUES (4, 104, 'Spring2026', 'D-');
INSERT INTO Enrollment VALUES (5, 101, 'Second 2026', 'F');

SELECT DISTINCT city
FROM Students;

SELECT 
    Students.student_name,
    Courses.course_name
FROM Enrollment
JOIN Students 
ON Enrollment.student_id = Students.student_id
JOIN Courses
ON Enrollment.course_id = Courses.course_id
WHERE Courses.course_name = 'Database Systems';

SELECT 
    student_id,
    course_id,
    grade
FROM Enrollment
WHERE grade = 'A';

SELECT 
    course_id,
    COUNT(student_id) AS total_students
FROM Enrollment
GROUP BY course_id;