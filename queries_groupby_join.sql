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