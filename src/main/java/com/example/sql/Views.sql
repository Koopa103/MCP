CREATE VIEW vw_course_min_grade AS
SELECT 
    c.course_id,
    c.course_code,
    c.course_name,
    c.minimum_required_grade
FROM Courses c;

-- SELECT minimum_required_grade
-- FROM vw_course_min_grade
-- WHERE course_code = 'CS

CREATE VIEW vw_major_concentrations AS
SELECT 
    m.major_id,
    m.major_name,
    mc.concentration_name
FROM Majors m
JOIN Major_Concentrations mc 
    ON m.major_id = mc.major_id;

-- SELECT concentration_name
-- FROM vw_major_concentrations
-- WHERE major_name = 'Computer Science';

CREATE VIEW vw_major_completion AS
SELECT 
    s.student_id,
    m.major_id,
    m.major_name,
    SUM(cr.credit_hours) AS completed_hours,
    m.total_required_hours,
    (m.total_required_hours - SUM(cr.credit_hours)) AS hours_remaining
FROM Students s
JOIN Enrollments e 
    ON s.student_id = e.student_id
JOIN Courses cr
    ON e.course_id = cr.course_id
JOIN Majors m
    ON s.major_id = m.major_id
WHERE e.grade_passed = 1  -- or e.final_grade >= 'C', etc.
GROUP BY 
    s.student_id, 
    m.major_id, 
    m.major_name, 
    m.total_required_hours;

-- SELECT hours_remaining
-- FROM vw_major_completion
-- WHERE student_id = 12345;


CREATE VIEW vw_student_classes AS
SELECT 
    s.student_id,
    c.course_code,
    c.course_name
FROM Students s
JOIN Enrollments e 
    ON s.student_id = e.student_id
JOIN Courses c 
    ON e.course_id = c.course_id
WHERE e.currently_enrolled = 1; 
-- Adjust the condition used to define “current”

-- SELECT *
-- FROM vw_student_classes
-- WHERE student_id = 12345;

CREATE VIEW vw_current_hours AS
SELECT 
    s.student_id,
    SUM(c.credit_hours) AS total_current_hours
FROM Students s
JOIN Enrollments e 
    ON s.student_id = e.student_id
JOIN Courses c 
    ON e.course_id = c.course_id
WHERE e.currently_enrolled = 1
GROUP BY s.student_id;

-- SELECT total_current_hours
-- FROM vw_current_hours
-- WHERE student_id = 12345;

CREATE VIEW vw_student_department AS
SELECT 
    s.student_id,
    d.dept_id,
    d.dept_name
FROM Students s
JOIN Majors m 
    ON s.major_id = m.major_id
JOIN Departments d 
    ON m.dept_id = d.dept_id;

-- SELECT dept_name
-- FROM vw_student_department
-- WHERE student_id = 12345;

CREATE VIEW vw_course_professors AS
SELECT 
    c.course_code,
    c.course_name,
    p.prof_id,
    p.first_name,
    p.last_name
FROM Courses c
JOIN Class_Sections cs
    ON c.course_id = cs.course_id
JOIN Professors p
    ON cs.prof_id = p.prof_id;

-- SELECT first_name, last_name
-- FROM vw_course_professors
-- WHERE course_code = 'CS375';

CREATE VIEW vw_student_majors AS
SELECT 
    s.student_id,
    m.major_id,
    m.major_name
FROM Students s
JOIN Student_Majors sm 
    ON s.student_id = sm.student_id
JOIN Majors m 
    ON sm.major_id = m.major_id;

-- SELECT major_name
-- FROM vw_student_majors
-- WHERE student_id = 12345;

CREATE VIEW vw_remaining_major_courses AS
SELECT 
    s.student_id,
    m.major_id,
    c.course_id,
    c.course_code,
    c.course_name
FROM Students s
JOIN Majors m
    ON s.major_id = m.major_id
JOIN Required_Courses rc
    ON m.major_id = rc.major_id
JOIN Courses c
    ON rc.course_id = c.course_id
WHERE NOT EXISTS (
    SELECT 1 
    FROM Enrollments e
    WHERE e.student_id = s.student_id 
      AND e.course_id = c.course_id
      AND e.grade_passed = 1
);

-- SELECT course_code, course_name
-- FROM vw_remaining_major_courses
-- WHERE student_id = 12345;

CREATE VIEW vw_department_enrollment_count AS
SELECT 
    s.student_id,
    d.dept_name,
    COUNT(*) AS total_enrollments
FROM Students s
JOIN Enrollments e 
    ON s.student_id = e.student_id
JOIN Courses c 
    ON e.course_id = c.course_id
JOIN Departments d 
    ON c.dept_id = d.dept_id
GROUP BY s.student_id, d.dept_name;

-- SELECT dept_name
-- FROM vw_department_enrollment_count
-- WHERE student_id = 12345
-- ORDER BY total_enrollments DESC
-- LIMIT 1;

CREATE VIEW vw_department_professors AS
SELECT 
    d.dept_id,
    d.dept_name,
    p.prof_id,
    p.first_name,
    p.last_name
FROM Departments d
JOIN Professors p
    ON d.dept_id = p.dept_id;

-- SELECT COUNT(prof_id) AS total_teachers
-- FROM vw_department_professors
-- WHERE dept_name = 'SITC';

CREATE VIEW vw_major_semester_courses AS
SELECT 
    m.major_id,
    m.major_name,
    msc.semester_number,
    c.course_code,
    c.course_name
FROM Majors m
JOIN Major_Semester_Courses msc
    ON m.major_id = msc.major_id
JOIN Courses c
    ON msc.course_id = c.course_id;

-- SELECT course_code, course_name
-- FROM vw_major_semester_courses
-- WHERE major_name = 'Computer Science' 
--   AND semester_number = 1;

CREATE VIEW vw_course_offerings AS
SELECT
    c.course_id,
    c.course_code,
    c.course_name,
    co.term,
    co.year
FROM Courses c
JOIN Course_Offerings co
    ON c.course_id = co.course_id;

-- SELECT term, year
-- FROM vw_course_offerings
-- WHERE course_code = 'CS375'
-- ORDER BY year, term
-- LIMIT 1; 

CREATE VIEW vw_major_required_courses_count AS
SELECT 
    m.major_id,
    m.major_name,
    COUNT(rc.course_id) AS total_required_courses
FROM Majors m
JOIN Required_Courses rc
    ON m.major_id = rc.major_id
GROUP BY m.major_id, m.major_name;

-- SELECT total_required_courses
-- FROM vw_major_required_courses_count
-- WHERE major_name = 'Computer Science';

CREATE VIEW vw_transferable_courses AS
SELECT 
    s.student_id,
    old_m.major_name AS old_major,
    new_m.major_name AS new_major,
    c.course_id,
    c.course_code,
    c.course_name
FROM Students s
JOIN Enrollments e 
    ON s.student_id = e.student_id
JOIN Courses c
    ON e.course_id = c.course_id
JOIN Majors old_m
    ON s.major_id = old_m.major_id
JOIN Majors new_m
    ON new_m.major_id <> old_m.major_id
JOIN Required_Courses rc
    ON new_m.major_id = rc.major_id
    AND rc.course_id = c.course_id
WHERE e.grade_passed = 1;

-- SELECT course_code, course_name
-- FROM vw_transferable_courses
-- WHERE student_id = 12345
--   AND new_major = 'Information Systems';

CREATE VIEW vw_student_class_rooms AS
SELECT 
    s.student_id,
    c.course_code,
    c.course_name,
    r.room_number,
    b.building_name
FROM Students s
JOIN Enrollments e 
    ON s.student_id = e.student_id
JOIN Class_Sections cs
    ON e.section_id = cs.section_id
JOIN Rooms r
    ON cs.room_id = r.room_id
JOIN Buildings b
    ON r.building_id = b.building_id
JOIN Courses c
    ON cs.course_id = c.course_id
WHERE e.currently_enrolled = 1;

-- SELECT course_code, room_number, building_name
-- FROM vw_student_class_rooms
-- WHERE student_id = 12345;

CREATE VIEW vw_major_professors AS
SELECT
    m.major_id,
    m.major_name,
    p.prof_id,
    p.first_name,
    p.last_name
FROM Majors m
JOIN Departments d
    ON m.dept_id = d.dept_id
JOIN Professors p
    ON d.dept_id = p.dept_id;

-- SELECT first_name, last_name
-- FROM vw_major_professors
-- WHERE major_name = 'Computer Science';

CREATE VIEW vw_required_gpa_calc AS
SELECT
    s.student_id,
    m.major_name,
    m.minimum_gpa_required,
    SUM(c.credit_hours) AS remaining_credits
    -- Possibly more columns for GPA logic
FROM Students s
JOIN Majors m
    ON s.major_id = m.major_id
JOIN Enrollments e
    ON s.student_id = e.student_id
JOIN Courses c
    ON e.course_id = c.course_id
WHERE e.currently_enrolled = 1
GROUP BY s.student_id, m.major_name, m.minimum_gpa_required;

CREATE VIEW vw_student_current_class_schedule AS
SELECT 
    s.student_id,
    c.course_code,
    c.course_name,
    cs.day_of_week,   -- e.g. 'MWF', 'TR'
    cs.start_time,
    cs.end_time,
    r.room_number,
    b.building_name
FROM Students s
JOIN Enrollments e 
    ON s.student_id = e.student_id
JOIN Class_Sections cs
    ON e.section_id = cs.section_id
JOIN Courses c
    ON cs.course_id = c.course_id
JOIN Rooms r
    ON cs.room_id = r.room_id
JOIN Buildings b
    ON r.building_id = b.building_id
WHERE e.currently_enrolled = 1;

-- SELECT course_code, day_of_week, start_time, end_time, room_number, building_name
-- FROM vw_student_current_class_schedule
-- WHERE student_id = 12345
--   AND day_of_week = 'MWF';

