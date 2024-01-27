/***************************************************************************************************
Colecciones: Arrays asociativos | Introducci�n
****************************************************************************************************
Las colecciones almacenan objetos del mismo tipo. Son parecido a los arrays de los lenguajes de
programaci�n, por ejemplo en java el ArrayList.

Colecciones
    1. Arrays asociativos (En este curso se ve este tipo de colecci�n)
    2. Nested tables
    3. Varrays

1. Arrays asociativos (INDEX BY tables)
Son colecciones PLSQL con dos columnas: primarky key, values
- Primary key: de tipo entero o cadena.
- Values: un tipo que puede ser escalar o record.


Sintaxis
--------
TYPE type_name IS TABLE OF 
{ column_type [NOT NULL] | variable%TYPE [NOT NULL] | table.column%TYPE [NOT NULL] | table%ROWTYPE }
INDEX BY { PLS_INTEGER | BINARY_INTEGER | VARCHAR2(X) };

variables type_name;

Acceso al array
---------------
- Para acceder al array usamos: array(N)                                    -> escalar
- Si es de un tipo complejo, por ejemplo employees, usamos: array(N).campo; -> rowtype

M�todos de los arrays
---------------------
- EXISTS(N): Detectar si existe un elemento.
- COUNT: N�mero de elementos.
- FIRST: Devuelve el �ndice m�s peque�o.
- Last: Devuelve el �ndice m�s alto.
- PRIOR(N): Devuelve el �ndice anterior a N.
- NEXT(N): Devuelve el �ndice posterior a N.
- DELETE: Borra todo.
- DELETE(N): Borra el �ndice N.
- DELETE(M,N): Borra de los �ndices M a N.
*/
SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
*/
DECLARE 
    -- Declaraci�n de un array asociativo
    TYPE departments_type IS TABLE OF
    departments.department_name%TYPE
    INDEX BY PLS_INTEGER;
    
    TYPE employees_type IS TABLE OF
    employees%ROWTYPE
    INDEX BY PLS_INTEGER;
    
    -- Definiendo variables del tipo array asociativo
    departments_array departments_type;
    employees_array employees_type;
BEGIN
    -- Tipo simple
    -- -------------------------------------------------------------------------
    departments_array(1) := 'Inform�tica';
    departments_array(2) := 'Recursos Humanos';
    
    dbms_output.put_line(departments_array(1));
    dbms_output.put_line(departments_array(2));
    dbms_output.put_line('Primera posici�n: ' || departments_array.first);
    dbms_output.put_line('Primera posici�n: ' || departments_array.last);
    
    IF departments_array.exists(3) THEN
        dbms_output.put_line(departments_array(3));
    ELSE
        dbms_output.put_line('El valor del �ndice 3 no existe');
    END IF;
    
    -- Tipo compuesto
    -- -------------------------------------------------------------------------
    SELECT *
    INTO employees_array(1)
    FROM employees
    WHERE employee_id = 100;
    
    dbms_output.put_line(employees_array(1).first_name);
END;
/