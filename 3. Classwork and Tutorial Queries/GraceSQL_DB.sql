SELECT * 
FROM courses;

SELECT *
FROM departments;

SELECT *
FROM scores;

SELECT *
FROM teacher

--1. What courses are offered in the 'MS Excel' department?
--'MS EXCEL' department_id = DP1

SELECT *
FROM courses
WHERE department = 'DP1'

--2. How many courses are available in each department?
SELECT department, COUNT(course_id) AS no_of_courses
FROM courses
GROUP BY department

--3. What is the average score of all students in the 'Advanced Excel' course?
--'Advanced Excel' course id = EX103
SELECT AVG(score)
FROM scores
WHERE course_id = 'EX103'

--4. Which students scored more than 70 in any course?

SELECT student_name, score
FROM scores
WHERE score > 70

-- 5. Which courses offer more than 4 units?
SELECT *
FROM courses
WHERE course_unit > 4

--6. Identify departments where the average course unit is below 5.
SELECT department, AVG(course_unit) AS average_course_unit
FROM courses
GROUP BY department
HAVING AVG(course_unit) < 5


--7. What are the names and scores of all students in the 'Intermediate Excel' course?



--8. What is the rounded average salary of all teachers?
SELECT ROUND(AVG(teacher_salary), 0)
FROM teacher

--9. Which departments offer courses that are not included in the 'MS  Excel' and 'Power BI' departments?
-- Department ids = DP1, DP2
SELECT *
FROM courses
WHERE department NOT IN ('DP1', 'DP2')

--10. List all courses along with their corresponding units in descending  order of units.

SELECT course_name, course_unit
FROM courses
ORDER BY course_unit DESC

--11. How many unique scores can be identified in the database?

SELECT COUNT(DISTINCT score)
FROM scores

--12. How many times did each unique score occurr?
SELECT score, COUNT(score) as occurence_count
FROM scores
GROUP BY score

















