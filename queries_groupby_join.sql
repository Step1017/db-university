/* Query con GROUP BY: */
/* 1. Contare quanti iscritti ci sono stati ogni anno */
SELECT COUNT(*) AS `enrolled_students`, YEAR (`enrolment_date`)
FROM `students`
GROUP BY YEAR (`enrolment_date`);

