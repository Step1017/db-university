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
SELECT `students`.`name`, `students`.`surname`, `degrees`.`name`
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

/* 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze */
SELECT `degrees`.`name`
FROM `degrees`
JOIN `departments`
ON `department_id` = `degrees`.`departments_id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';

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

