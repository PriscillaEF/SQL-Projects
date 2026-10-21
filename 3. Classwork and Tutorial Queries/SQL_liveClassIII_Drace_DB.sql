CREATE TABLE departments (
department_id VARCHAR(10) PRIMARY KEY,
department_name VARCHAR(255)
);

CREATE TABLE courses (
	course_id VARCHAR(10) PRIMARY KEY,
	course_name VARCHAR(255),
	course_unit INT,
	department VARCHAR(10),
	FOREIGN KEY (department) REFERENCES departments(department_id)
);

CREATE TABLE scores (
	student_id INT PRIMARY KEY,
	student_name VARCHAR(255),
	course_id VARCHAR(10),
	score INT,
	FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

SELECT *
FROM departments;

SELECT *
FROM courses;

SELECT *
FROM scores;


-- 1. Assist the Facilitators in assessing student and gain insight to student performance by categorizing student score.
-- • 90 and above: Excellent
-- • 80 to 89: Very Good
-- • 70 to 79: Good
-- • 60 to 69: Fair
-- • Below 60: Fail

-- DATA - scores
-- SQL Command - CASE & WHEN

SELECT student_name, score,
	CASE 
		WHEN score >= 90 THEN 'Excellent'
		WHEN score BETWEEN 80 AND 89 THEN 'Very Good'
		WHEN score BETWEEN 70 AND 79 THEN 'Good'
		WHEN score BETWEEN 60 AND 69 THEN 'Fair'
		ELSE 'Fail'
	END AS score_category
FROM scores;

-- 2. Identify students who have achieved scores above the overall average score among all students.
-- DATA - scores 
-- SQL CONCEPT - Subqueries

SELECT student_name, score
FROM scores
WHERE score > (SELECT AVG(score) FROM scores)
ORDER BY score;

-- 3. The manager has requested that all missing scores should be treated as 0, and all the information (student's name,
-- course, and the adjusted score) of these students should be displayed.
-- DATA - score
-- SQL CONCEPT - Coalesce

SELECT * 
from scores
order by score DESC; 

SELECT student_name, course_id, COALESCE(score,0) AS adjusted_score
FROM scores
ORDER BY score DESC;

-- 4. A report showing the student’s name and their score represented as text has been requested by management, provide
-- the report. Hint - convert the numerical scores of students into a textual representation and display the student's name
-- alongside this textual score?
-- DATA - scores
-- SQL CONCEPT - CAST

SELECT student_name, CAST(score AS VARCHAR(10))
FROM scores

-- 5. Provide a report classifying students into the following achievement levels based on their scores
-- • 90 and Above 90: Excellent Student
-- • 80 to 89: Great Student
-- • 70 to 79: Very Good Student
-- • 60 to 69: Good Student
-- • Below 60: Average Student
SELECT student_name, score,
	CASE
		WHEN score >= 90 THEN 'Excellent Student'
		WHEN score BETWEEN 80 and 89 THEN 'Great Student'
		WHEN score BETWEEN 70 and 79 THEN 'Very Good Student'
		WHEN score BETWEEN 60 and 69 THEN 'Good Student'
		ELSE 'Average Student'
	END AS achievement_level
FROM scores;

SELECT student_name, score,
	CASE
		WHEN score >= 90 THEN 'Excellent Student'
		WHEN score BETWEEN 80 and 90 THEN 'Great Student'
		WHEN score BETWEEN 70 and 79 THEN 'Very Good Student'
		WHEN score BETWEEN 60 and 69 THEN 'Good Student'
		ELSE 'Average Student'
	END 
FROM scores;


select student_name, score,
	case
		when score >= 90 then 'Excellent Student'
		when score between 80 and 90 then 'Great Student'
		when score between 70 and 79 then 'Very Good STudent'
		when score between 60 and 69 then 'Good Student'
		else 'Average Student'
	end
from scores;

SELECT student_name, score,
	CASE
		WHEN score >= 90 THEN 'Excellent Student'
		WHEN score BETWEEN 80 and 90 THEN 'Great Student'
		WHEN score BETWEEN 70 and 79 THEN 'Very Good Student'
		WHEN score BETWEEN 60 and 69 THEN 'Good Student'
		ELSE 'Average Student'
	END as Achievement_levels
 FROM scores;

-- 6. Identify the course with the highest average score as ‘Top Scoring courses’ among all courses.
SELECT course_id, AVG(score) AS "Top Scoring Course"
FROM scores
GROUP BY course_id
HAVING AVG(score) IS NOT NULL
ORDER BY "Top Scoring Course" DESC
LIMIT 1;

-- 7. For each student, display the course in which they scored the highest? If they haven't taken any courses,
-- display 'No Courses Taken'.
SELECT s.student_name, MAX(s.score) AS Score, COALESCE(c.course_name, 'No courses Taken') AS course
FROM scores s --left table
LEFT JOIN courses c    -- right table
ON s.course_id = c.course_id
GROUP BY s.student_name, c.course_name
ORDER BY MAX(s.score) DESC;

-- 8. Transform department IDs into a character data type and present them in conjunction with the
-- corresponding department names.
SELECT CAST(department_id AS TEXT), department_name 
FROM departments;


-- 9. Classify courses based on the quantity of students enrolled? The categories are:
-- • More than 5000 students: Popular
-- • 3000 to 5000 students: Moderate
-- • Fewer than 3000 students: Unpopular

SELECT course_id, 
	CASE
	WHEN COUNT(student_id) > 5000 THEN 'Popular'
	WHEN COUNT(student_id) BETWEEN 3000 AND 5000 THEN 'Moderate'
	ELSE 'Unpopular'
	END AS course_popularity
FROM scores
GROUP BY course_id;

-- 10. Calculate the average score for each course, and if a course has no scores from students, indicate the
-- average as 'N/A'

SELECT c.course_id, COALESCE(CAST(AVG(s.score) AS VARCHAR(10)), 'N/A') AS "Average_Score"
FROM courses c
LEFT JOIN scores s
ON c.course_id = s.course_id
GROUP BY c.course_id;
