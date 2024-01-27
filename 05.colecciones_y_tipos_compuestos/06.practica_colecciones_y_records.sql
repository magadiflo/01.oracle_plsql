/***************************************************************************************************
Pr�ctica de colecciones y records
****************************************************************************************************
*/
SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
Creamos un TYPE RECORD que tenga las siguientes columnas

    NAME VARCHAR2(100),
    SAL EMPLOYEES.SALARY%TYPE,
    COD_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE);

- Creamos un TYPE TABLE basado en el RECORD anterior.
- Mediante un bucle cargamos en la colecci�n los empleados. El campo NAME 
  debe contener FIRST_NAME y LAST_NAME concatenado.
- Para cargar las filas y siguiendo un ejemplo parecido que hemos visto en el 
  v�deo usamos el EMPLOYEE_ID que va de 100 a 206.
- A partir de este momento y ya con la colecci�n cargada, hacemos las siguientes 
  operaciones, usando m�todos de la colecci�n.

    Visualizamos toda la colecci�n
    Visualizamos el primer empleado
    Visualizamos el �ltimo empleado
    Visualizamos el n�mero de empleados
    Borramos los empleados que ganan menos de 7000 y visualizamos de nuevo la colecci�n
    Volvemos a visualizar el n�mero de empleados para ver cuantos se han borrado
*/
DECLARE
    TYPE employee_r IS RECORD(
        name VARCHAR2(100),
        salary employees.salary%TYPE,
        cod_department employees.department_id%TYPE
    );
    
    TYPE employees_t IS TABLE OF
    employee_r
    INDEX BY PLS_INTEGER;
    
    employees_array employees_t;
    count_employees NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO count_employees
    FROM employees;
    
    IF count_employees > 0 THEN
        FOR i IN 1..count_employees LOOP
            SELECT first_name || ' ' || last_name, salary, department_id
            INTO employees_array(i)
            FROM employees
            WHERE employee_id = i + 99;
        END LOOP;
        
        dbms_output.put_line('Usando m�todos de colecci�n');
        dbms_output.put_line('Visualizamos toda la colecci�n');
        dbms_output.put_line('-----------------------------------------------');
        FOR i IN employees_array.first..employees_array.last LOOP
            dbms_output.put_line(employees_array(i).name || ', ' || employees_array(i).salary || ' ' || employees_array(i).cod_department);
        END LOOP;
        
        dbms_output.put_line('-----------------------------------------------');
        dbms_output.put_line('Visualizamos el primer empleado');
        dbms_output.put_line('-----------------------------------------------');
        dbms_output.put_line(employees_array(employees_array.first).name || ', ' || employees_array(employees_array.first).salary || ' ' || employees_array(employees_array.first).cod_department);
        
        dbms_output.put_line('-----------------------------------------------');
        dbms_output.put_line('Visualizamos el �ltimo empleado');
        dbms_output.put_line('-----------------------------------------------');
        dbms_output.put_line(employees_array(employees_array.last).name || ', ' || employees_array(employees_array.last).salary || ' ' || employees_array(employees_array.last).cod_department);
        
        dbms_output.put_line('-----------------------------------------------');
        dbms_output.put_line('N�mero de empleados: ' || employees_array.count);
        dbms_output.put_line('-----------------------------------------------');
        
        dbms_output.put_line('-----------------------------------------------');
        dbms_output.put_line('Borrando empleados que ganan menos de 7000');
        dbms_output.put_line('-----------------------------------------------');
        FOR i IN employees_array.first..employees_array.last LOOP
            IF employees_array(i).salary < 7000 THEN
                dbms_output.put_line(employees_array(i).name || ' eliminado!');
                employees_array.delete(i);
            END IF;
        END LOOP;
        dbms_output.put_line('-----------------------------------------------');
        dbms_output.put_line('N�mero de empleados luego de la eliminaci�n: ' || employees_array.count);
        dbms_output.put_line('-----------------------------------------------');

    END IF;
    
    dbms_output.put_line('Fin del bloque');
END;
/