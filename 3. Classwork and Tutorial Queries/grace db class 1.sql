--1 
SELECT course_name, dep
FROM courses 
WHERE department = 'MS Excel';

--2 
SELECT department, COUNT(*) AS course_count 
FROM courses 
GROUP BY department;

--3
SELECT AVG(score) AS average_score 
FROM student_scores 
WHERE course_name = 'Advanced Excel';

--4
SELECT student_name, course_name, score 
FROM student_scores 
WHERE score > 70;

SELECT student_name, course_id, score
FROM scores
WHERE Score > 70
ORDER BY score DESC;

--5
SELECT course_name, units 
FROM courses 
WHERE units > 4;

SELECT * 
FROM courses
WHERE course_unit > 4;

--6
SELECT department 
FROM courses 
GROUP BY department 
HAVING AVG(units) < 5;

--7
SELECT student_name, score 
FROM student_scores 
WHERE course_name = 'Intermediate Excel';

--8
SELECT ROUND(AVG(salary), 0) AS average_salary 
FROM teachers;

--9
SELECT department 
FROM courses 
WHERE department NOT IN ('DP1', 'DP2');
 
--10
SELECT course_name, units 
FROM courses 
ORDER BY units DESC;
