select * 
from courses;

select * 
from departments;

select *
from teacher;

select *
from scores;

-- clean the student_name column in scores

UPDATE scores
SET student_name = REGEXP_REPLACE(student_name, '[0-9]+', '', 'g');


-- Retrieve all course names and their units from the courses table.

select course_name, course_unit
from courses;

-- Find the names of all female teachers.

select teacher_name
from teacher
where sex = 'F';

-- List all students who scored more than 80 in any course.

select student_name, student_id, score
from scores
where score > 80;


-- Find the highest salary among all teachers.

select max(teacher_salary)
from teacher;

-- Calculate the average score for each course.

select course_id, round(avg(score), 2)
from scores
group by course_id;

-- Get the ID of the students that scored above average.

select student_id, score
from scores
where score > (select avg(score) as avg_score
from scores);

-- or

select avg(score) as avg_score
from scores;

select student_id, score
from scores
where score > 50.2519333333333333;

-- Find the department with the most number of courses and list the department
-- name along with the number of courses.

select department, count(course_id)
from courses
group by department
order by count(course_id) desc
limit 1;

-- Retrieve the student who has the highest total score across all courses.

select student_name, student_id, sum(score)
from scores
group by student_name, student_id
order by  sum(score) desc
limit 313;

-- OR
-- Step 1: Get the highest total score
WITH total_scores AS (
    SELECT student_name, student_id, SUM(score) AS total_score
    FROM scores
    GROUP BY student_name, student_id
),
max_score AS (
    SELECT MAX(total_score) AS highest_total
    FROM total_scores
)
-- Step 2: Select all students who have that score
SELECT ts.student_name, ts.student_id, ts.total_score
FROM total_scores ts
JOIN max_score ms ON ts.total_score = ms.highest_total;

-- Get the number of male and female teachers in the dataset.

select sex, count(*)
from teacher
group by sex;

-- Find the average unit count for courses across all departments where the unit
-- count is more than 2.

select avg(course_unit)
from courses
where course_unit > 2;

select department, avg(course_unit) as avg_unit_count
from courses
where course_unit > 2
group by department;





-- List the student names who scored the maximum score in each course (subquery)
select course_id, max(score)
from scores
group by course_id;

select student_name, (course_id),score
from scores
where (course_id, score) in (select course_id, max(score)
from scores
group by course_id);

-- find courses that have more than 5 students enrolled in them and 
-- calculate the average score for those courses

select course_id, avg(score)
from scores
where course_id in (select course_id
from scores
group by course_id
having count(student_name) > 5)
group by course_id;