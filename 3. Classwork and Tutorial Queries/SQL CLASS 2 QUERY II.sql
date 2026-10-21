---Inner Join
---Retrieve the names of departments and the courses they offer

select departments.department_name, courses.course_name
from courses
inner join departments on courses.department = departments.department_id;

select departments.department_name, courses.course_name
from courses
join departments on courses.department = departments.department_id;

--- Find the highest score in each course
select courses.course_name, max(scores.score) as highest_score
from courses
join scores on courses.course_id = scores.course_id
group by courses.course_name;

---get a list of teachers and the courses they teach
select courses.course_name, teacher.teacher_name
from courses
join teacher on courses.course_id = teacher.teacher_course;

---left join
---What are the details of all students and any courses they might be enrolled in, including those not enrolled in any course?
select courses.course_name, scores.student_name
from courses
left join scores on scores.course_id = courses.course_id;

--- Calculate the average score of students for each course, even if some courses have no students
select courses.course_name, round (avg(scores.score), 2) as average_score
from courses
left join scores on courses.course_id = scores.course_id
group by courses.course_name;

---right join
---Get a list of teachers and their courses, even if a teacher is not assigned to any course.
select teacher.teacher_name, courses.course_name
from teacher
right join courses on courses.course_id = teacher.teacher_course;

---- Return courses, students and scores especially "Advanced Excel".
select courses.course_name, scores.student_name, scores.score
from scores
right join courses on scores.course_id = courses.course_id
where courses.course_name = 'Advanced Excel';

--- Find the total salary of teachers for each course, even if some courses don't have teachers assigned
select courses.course_id, courses.course_name, sum (teacher.teacher_salary) as total_salary
from teacher
right join courses on teacher.teacher_course = courses.course_id
group by courses.course_name, courses.course_id;

---full outer join
---Get a list of teachers and their courses, even if a teacher is not assigned to any course.
select teacher.teacher_name, courses.course_name
from teacher
full outer join courses on courses.course_id = teacher.teacher_course;

----Return a list of all courses and all students, showing students enrolled in courses and courses with no enrollments?
select courses.course_id, scores.student_name, courses.course_name
from courses
full outer join scores on courses.course_id = scores.course_id;

---- courses, department and course_id
select courses.course_name, courses.course_id, departments.department_name
from courses
full outer join departments on courses.department = departments.department_id;

---- department, course and  teacher 
select departments.department_name, courses.course_name, teacher.teacher_name
from departments
full outer join courses on courses.department = departments.department_id
full outer join teacher on teacher.teacher_course = courses.course_id;

----What is the total number of students enrolled in each course, including courses with no students or students with no courses?
select courses.course_name, count(scores.student_id) as total_number_of_students
from courses
full outer join scores on courses.course_id = scores.course_id
group by courses.course_name;


