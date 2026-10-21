SELECT *
FROM scores

SELECT *
FROM courses

SELECT *
FROM departments

--To join scores table and courses table,
--Columns needed: course_id from scores table and course_id from courses table

SELECT *
FROM scores
JOIN courses
ON scores.course_id = courses.course_id

--Lets select 2 columns from each table
SELECT scores.student_id, scores.course_id, courses.course_id, courses.course_name
FROM scores
JOIN courses
ON scores.course_id = courses.course_id

--Lets alias the last query
SELECT s.student_id, s.course_id, c.course_id, c.course_name
FROM scores s
JOIN courses c
ON s.course_id = c.course_id

--1. List all students along with their course names and scores where scores are between 90 and 95,... 
--...for a B-grade scholarship
--Tables needed: courses and scores
--columns needed: course_id from scores table and course_id from courses table

SELECT s.student_name, c.course_name, s.score
FROM courses c
JOIN scores s
ON c.course_id = s.course_id
WHERE s.score BETWEEN 90 AND 95


--2. Show all courses along with any associated average scores
--Tables needed: courses and scores
--Columns needed:course_id from scores table and course_id from courses table

SELECT c.course_name, ROUND(AVG(s.score), 2) AS average_score
FROM courses c
LEFT JOIN scores s
ON c.course_id = s.course_id
GROUP BY c.course_name


--3. Display all department names and their total course units
--Tables needed: departments and courses
--Columns needed: department_id from departments table and department from courses table

--Q3 answer using a left join
SELECT d.department_name, SUM(c.course_unit) AS total_course_unit
FROM departments d
LEFT JOIN courses c
ON d.department_id = c.department
GROUP BY d.department_name

--Q3 answer using a right join
SELECT d.department_name, SUM(c.course_unit) AS total_course_unit
FROM courses c
RIGHT JOIN departments d
ON c.department = d.department_id
GROUP BY d.department_name


--4. Display a complete list of all courses and all teachers
--Tables needed: courses and teacher 
--columns needed: course_id from courses table and teacher_course from teacher table

SELECT c.course_name, t.teacher_name
FROM courses c
FULL JOIN teacher t
ON c.course_id = t.teacher_course

--5. List all unique courses and teachers' names in a single column

SELECT course_name FROM courses
union
SELECT teacher_name FROM teacher


--6. Find all unique course_ids and the department_ids from both the courses and departments tables



