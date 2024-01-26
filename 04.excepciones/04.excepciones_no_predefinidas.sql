/***************************************************************************************************
Excepciones no predefinidas
****************************************************************************************************
Cuando hablamos de excepciones no predefinidas no estamos hablamos de excepciones 
de usuarios (excepciones personalizadas), sino m�s bien, son excepciones de ORACLE, 
que como no est�n predefinidas nosotros las queremos manipular, pero siguen siendo 
excepciones de ORACLE.

Recordar que todos los errores de ORACLE son n�meros negativos, menos el 100.
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
Para este ejemplo, vamos a usar la excepci�n no predefinida que surge cuando 
se usan funciones de agregaci�n (SUM(), COUNT(), AVG(), ETC.) que en ORACLE
est� definida como:

    ORA-00937 not a single-group group function
    
Para definir la excepci�n no personalizada debemos crear un objeto del tipo 
EXCEPTION, en nuestro caso crearemos el objeto al que le llamaremos EXCEPTION_GROUP.

A continuaci�n debemos usar la siguiente cl�usula: 
    PRAGMA EXCEPTION_INIT(nombre_de_la_excepci�n, c�digo_de_la_excepci�n);
    
PRAGMA, es una especie de orden al compilador de PLSQL, es decir, es como si le
dijera: "Oye, siempre que aparezca el c�digo_de_la_excepci�n, sustit�yelo por
el nombre_de_la_excepci�n".

En nuestro ejemplo, al usar PRAGMA con el EXCEPTION_INIT, estamos asociando el
EXCEPTION_GROUP con el c�digo -937, lo que significa que cuando ocurra la 
excepci�n de ORACLE c�n c�digo -937, podremos usar nuestra variable de excepci�n
EXCEPTION_GROUP en el bloque EXCEPTION.
*/
DECLARE
    EXCEPTION_GROUP EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCEPTION_GROUP, -937);
    id employees.employee_id%TYPE;
    salary_sum NUMBER;
BEGIN
    SELECT employee_id, SUM(salary)
    INTO id, salary_sum
    FROM employees;
    
    dbms_output.put_line(id);
EXCEPTION
    WHEN EXCEPTION_GROUP THEN
        dbms_output.put_line('Funci�n de grupo incorrecto');
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo procesar el bloque plsql');
END;