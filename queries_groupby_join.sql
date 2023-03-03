/* Query con GROUP BY: */
/* 1. Contare quanti iscritti ci sono stati ogni anno */
SELECT COUNT(*) AS `enrolled_students`, YEAR (`enrolment_date`)
FROM `students`
GROUP BY YEAR (`enrolment_date`);

/* 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio */
SELECT COUNT(*) AS `same_building_teachers_num`, `office_address` 
FROM `teachers`
GROUP BY `office_address`;

/* 3. Calcolare la media dei voti di ogni appello d'esame */
SELECT `exam_id`, ROUND(AVG(`vote`)) AS 'average_votes' /* usato AVG per fare la media e ROUND per arrotondare */
FROM `exam_student`
GROUP BY `exam_id`;

/* 4. Contare quanti corsi di laurea ci sono per ogni dipartimento */
SELECT `department_id`, COUNT(*) AS `degrees_courses`
FROM `degrees`
GROUP BY `department_id`;


/* Query con JOIN: */
/* 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia */
SELECT students.id, students.surname, students.name, students.registration_number, students.enrolment_date, degrees.name AS degree_name
FROM `students`
JOIN degrees
ON students.degree_id = degrees.id
WHERE degrees.name = 'Corso di Laurea in Economia';

/* 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze */
SELECT degrees.id, degrees.name, degrees.level, departments.name AS department_name 
FROM `degrees`
JOIN departments
ON degrees.department_id = departments.id
WHERE degrees.level = 'Magistrale'
AND departments.name = 'Dipartimento di Neuroscienze';

/* 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44) */
SELECT courses.id, courses.name, courses.period, courses.year, courses.cfu, courses.degree_id, course_teacher.teacher_id
FROM `courses`
JOIN course_teacher
ON courses.id = course_teacher.course_id
JOIN teachers
ON course_teacher.teacher_id = teachers.id
WHERE teachers.name = 'Fulvio'
AND teachers.surname = 'Amato';

/* 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome */
SELECT students.id AS student_id, students.name, students.surname, students.registration_number, students.enrolment_date, degrees.name AS corso_di_laurea, departments.name AS dipartimento
FROM `students`
JOIN degrees
ON students.degree_id = degrees.id
JOIN departments
ON degrees.department_id = departments.id
ORDER BY students.surname, students.name;

/* 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti */ 
SELECT degrees.id, degrees.name, courses.name AS corso, teachers.surname AS cognome_insegnante, teachers.name AS nome_insegnante
FROM `degrees`
JOIN courses
ON degrees.id = courses.degree_id
JOIN course_teacher
ON courses.id = course_teacher.course_id
JOIN teachers
ON course_teacher.teacher_id = teachers.id
ORDER BY degrees.id ASC;

/* 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54) */
SELECT DISTINCT teachers.id, teachers.surname, teachers.name, departments.name AS dipartimento
FROM `teachers`
JOIN course_teacher
ON teachers.id = course_teacher.teacher_id
JOIN courses
ON course_teacher.course_id = courses.id
JOIN degrees
ON courses.degree_id = degrees.id
JOIN departments
ON degrees.department_id = departments.id
WHERE departments.name = 'Dipartimento di Matematica'
ORDER BY teachers.id;

/* 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami */
SELECT students.id, students.surname, students.name, students.registration_number, students.enrolment_date, COUNT(exam_student.exam_id) AS num_tentativi, MAX(exam_student.vote) AS voto_massimo
FROM `students`
JOIN exam_student
ON students.id = exam_student.student_id
JOIN exams
ON exam_student.exam_id = exams.id
GROUP BY exams.course_id, students.id, students.surname, students.name, students.registration_number, students.enrolment_date
HAVING voto_massimo >= 18
ORDER BY `voto_massimo` ASC;