
--1. What is each student's score category (High, Medium, Low) based on their actual scores, 
--with high greater than 70, low less that 50 and others, medium?

SELECT student_name, score, (CASE
								WHEN score > 70 THEN 'High'
								WHEN score < 50 THEN 'Low'
								ELSE 'Medium'
							END) AS score_category
FROM scores;

--2. What is the category of each course based on its unit count (Heavy, Moderate, Light)? 
--Courses with course units greater than 4 are heavy, greater than 3 are moderate, others low.

SELECT course_name, course_unit, CASE
									  WHEN course_unit > 4 THEN 'Heavy'
									  WHEN course_unit > 3 THEN 'Moderate'
									  ELSE 'Low'
								  END AS course_unit_category
FROM courses;


--3. What is the total number of course units for each department, with departments having no courses 
--assigned showing a total of 0 units?
--Tables needed: Courses table and departments table
--Columns needed: department from courses table and department_id from departments table

SELECT d.department_name, coalesce(SUM(c.course_unit), 0) AS total_course_units
FROM departments d
LEFT JOIN courses c
ON c.department = d.department_id
GROUP BY d.department_name;


--4. What are the names of teachers assigned to each course, with courses having no assigned
--teachers listed as "No Teachers Assigned"?
--Tables: courses table and teacher table
--columns: course_id column from courses and teacher_course from teacher

SELECT c.course_name, COALESCE(t.teacher_name,'No Teachers Assigned') AS teacher_name
FROM courses c
LEFT JOIN teacher t
ON c.course_id = t.teacher_course


--5. What is each teacher's salary formatted with a dollar sign?
SELECT teacher_name, CONCAT('$', CAST(teacher_salary AS VARCHAR))
FROM teacher


--6 Which students scored higher than the average score of all students?
SELECT *
FROM scores
WHERE score > (SELECT AVG(score)
			   FROM scores)


--Which students scored higher than the average score of all students in the 'MS Excel’ department?
-- tables: scores, departments, courses. We used courses table to join scores and departments tables
--Columns: scores.course_id, courses.course_id, departments.department_id, courses.department

SELECT *
FROM scores
WHERE score > ( SELECT AVG(s.score)
				FROM scores s
				FULL JOIN courses c
				ON s.course_id = c.course_id
				FULL JOIN departments d
				ON d.department_id = c.department
				WHERE d.department_name = 'MS Excel')


--8. What percentage do the units of each course represent of the total course units available 
--across all courses?

SELECT course_name, 
	   course_unit, 
	   CAST(course_unit AS float)/(SELECT SUM(course_unit) FROM courses) * 100 AS percentage
FROM courses














