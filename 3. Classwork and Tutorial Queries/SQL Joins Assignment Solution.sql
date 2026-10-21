--Assignment Solution

--What is the average number of course units for each department?

SELECT departments.department_name, AVG(courses.course_unit) AS average_course_units
FROM departments 
INNER JOIN courses ON departments.department_id = courses.department
GROUP BY departments.department_name;

--Which teachers are not currently assigned to any courses?

SELECT teacher.teacher_name
FROM teacher
LEFT JOIN courses ON teacher.teacher_course = courses.course_id
WHERE courses.course_id IS NULL;

--- Calculate the average score for each course, even if some students 
--- don't have associated scores

SELECT courses.course_name, AVG(scores.score) AS average_score
FROM scores
RIGHT JOIN courses ON scores.course_id = courses.course_id
GROUP BY courses.course_name;

--- Get all departments and their courses

SELECT departments.department_name, courses.course_name 
FROM departments 
FULL OUTER JOIN courses ON departments.department_id = courses.department;

