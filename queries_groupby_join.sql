/* Query con GROUP BY: */
/* 1. Contare quanti iscritti ci sono stati ogni anno */
SELECT COUNT(*) AS `enrolled_students`, YEAR (`enrolment_date`)
FROM `students`
GROUP BY YEAR (`enrolment_date`);

/* 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio */
SELECT COUNT(*) AS `same_building_teachers_num`, `office_address` 
FROM `teachers`
GROUP BY `office_address`;

