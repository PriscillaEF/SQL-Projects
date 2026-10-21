--Lets view the courses and scores table
SELECT *
FROM courses

SELECT *
FROM scores

--To join courses and scores we need 
--course_id column from courses table and course_id column from scores

SELECT *
FROM courses 
JOIN scores
ON courses.course_id = scores.course_id


SELECT c.course_id, s.student_id, c.course_unit, s.score, s.student_name
FROM courses c 
JOIN scores s
ON c.course_id = s.course_id


--lets look at the courses and departments table
SELECT *
FROM courses

SELECT *
FROM departments

--to join courses and departments we need:
--department column from courses table and department_id from departments table
SELECT c.department, d.department_id
FROM courses c
JOIN departments d
ON c.department = d.department_id

--1. List all students along with their course names and scores where scores are above 75
--Tables: courses and scores
--Columns: course_id from courses table and course_id from scores

SELECT s.student_name, c.course_name, s.score 
FROM courses c
JOIN scores s
ON c.course_id = s.course_id
WHERE s.score > 75

--2. Show all courses along with any associated average scores
--Tables: courses and scores
--Columns: course_id from courses table and course_id from scores

SELECT c.course_name, ROUND(AVG(s.score), 2) AS avg_score
FROM courses c
LEFT JOIN scores s
ON c.course_id = s.course_id
GROUP BY c.course_name


--3. List all students and their courses
SELECT s.student_name, c.course_name
FROM scores s
JOIN courses c
ON c.course_id = s.course_id

--4. Display a complete list of all courses and all teachers
--Tables: courses and teacher
--columns: course_id from courses table and teacher_course from teacher table

SELECT c.course_name, t.teacher_name
FROM courses c
FULL JOIN teacher t
ON c.course_id = t.teacher_course


--UNION
SELECT department_id FROM departments
union
SELECT department FROM courses

--5. List all unique courses and teachers' names in a single column
SELECT course_name FROM courses
union
SELECT teacher_name FROM teacher

--6. Find all unique course_ids and the department_ids from both the courses and departments tables
SELECT course_id FROM courses
UNION
SELECT department_id FROM departments





























