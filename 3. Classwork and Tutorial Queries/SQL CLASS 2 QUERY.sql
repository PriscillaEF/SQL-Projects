---Inner JOIN
---Retrieve the names of departments and the courses they offer

select departments.department_name, courses.course_name
from departments
inner join courses on courses.department = departments. department_id;

---Find the highest score in each course
select courses.course_name, max (scores.score) as highest_score
from courses
inner join scores on courses.course_id = scores.course_id
group by courses.course_name;

---get the list of teachers and the courses they teacher
select courses.course_name, teacher.teacher_name
from courses
inner join teacher on courses.course_id = teacher.teacher_course;

---Left join
--- What are the details of all students and any courses they might be enrolled in, including those not enrolled in any course?
select courses.course_name, scores.student_name,
from courses
left join scores on scores.course_id = courses.course_id;

---What are the details of all students, department name and any courses they might be enrolled in, including those not enrolled in any course?
select courses.course_name, scores.student_name, departments.department_name
from courses
left join scores on scores.course_id = courses.course_id
left join departments on courses.department = departments.department_id

---Calculate the average score of students for each course, even if some courses have no students
select courses.course_name, round (avg (scores.score), 2) as average_score
from courses
left join scores on courses.course_id = scores.course_id
group by courses.course_name;

--- Right Join
---Get a list of teachers and their courses, even if a teacher is not assigned to any course.
select teacher.teacher_name, courses.course_name
from courses
right join teacher on courses.course_id = teacher.teacher_course;

--- by-the-way question
select courses.course_name, scores.student_name, scores.score
from courses
left join scores on courses.course_id =scores.course_id
where course_name = 'Advanced Excel';

--- Find the total salary of teachers for each course, even if some courses don't have teachers assigned
select courses.course_name, sum(teacher.teacher_salary) as total_salary_of_teacher
from courses
right join teacher on courses.course_id = teacher.teacher_course
group by courses.course_name;


---Full Outer Join
--- Return a list of all courses and all students, showing students enrolled in courses and courses with no enrollments?
select scores.student_name, courses.course_name, courses.course_id
from scores
full outer join courses on courses.course_id = scores.course_id;

---- Change column name
alter table teacher
rename column teacher_course to course_id;

select * from teacher;
