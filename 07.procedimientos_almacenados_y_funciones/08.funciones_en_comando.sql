/***************************************************************************************************
Funciones de comando
****************************************************************************************************
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
*/

SELECT first_name, fn_calculate_tax(employee_id, 20) AS "20%"
FROM employees;