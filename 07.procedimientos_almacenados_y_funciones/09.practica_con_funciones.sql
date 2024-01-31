/***************************************************************************************************
Pr�ctica con funciones
****************************************************************************************************
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
Crear una funci�n que tenga como par�metro un n�mero de departamento y que 
devuelve la suma de los salarios de dicho departamento. La imprimimos por pantalla.

- Si el departamento no existe debemos generar una excepci�n con dicho mensaje.
*/
CREATE OR REPLACE FUNCTION fn_sum_salary_by_department(
    p_department_id departments.department_id%TYPE
)
RETURN NUMBER
AS
    sum_salary NUMBER := 0;
    id departments.department_id%TYPE;
BEGIN

    -- Comprobamos que el departamento existe, caso contrario arrojar� la excepci�n en autom�tico
    SELECT department_id 
    INTO id
    FROM departments
    WHERE department_id = p_department_id;
    
    SELECT SUM(salary)
    INTO sum_salary
    FROM employees
    WHERE department_id = p_department_id;
    
    RETURN sum_salary;    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No se encontraron datos para ese id de departamento');
        RAISE_APPLICATION_ERROR(-20001, 'El departamento con id ' || p_department_id || ' no existe.');
        
END;
/

--Ejecutando funci�n
DECLARE
    sum_salary NUMBER := 0;
BEGIN
    sum_salary := fn_sum_salary_by_department(90);
    dbms_output.put_line('La suma del salario es: ' || sum_salary);
END;
/

/* Ejemplo 02
******************************************************
Modificar el programa anterior para incluir un par�metro de tipo OUT por el que 
vaya el n�mero de empleados afectados por la query. Debe ser visualizada en el 
programa que llama a la funci�n. De esta forma vemos que se puede usar este tipo
de par�metros tambi�n en una funci�n
*/
CREATE OR REPLACE FUNCTION fn_sum_salary_by_department_out(
    p_department_id departments.department_id%TYPE,
    p_affected_rows OUT NUMBER
)
RETURN NUMBER
AS
    sum_salary NUMBER := 0;
    id departments.department_id%TYPE;
BEGIN

    -- Comprobamos que el departamento existe, caso contrario arrojar� la excepci�n en autom�tico
    SELECT department_id 
    INTO id
    FROM departments
    WHERE department_id = p_department_id;
    
    SELECT SUM(salary), COUNT(salary)
    INTO sum_salary, p_affected_rows
    FROM employees
    WHERE department_id = p_department_id;
    
    RETURN NVL(sum_salary, 0);    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No se encontraron datos para ese id de departamento');
        RAISE_APPLICATION_ERROR(-20001, 'El departamento con id ' || p_department_id || ' no existe.');
        
END;
/

--Ejecutando funci�n
DECLARE
    sum_salary NUMBER;
    rows NUMBER;
BEGIN
    sum_salary := fn_sum_salary_by_department_out(100, rows);
    dbms_output.put_line('La suma del salario es: ' || sum_salary ||  ', en un total de ' || rows || ' registros.');
END;
/

/* Ejemplo 03
******************************************************
Crear una funci�n llamada FN_CREATE_REGION:

- A la funci�n se le debe pasar como par�metro un nombre de regi�n y debe 
  devolver un n�mero, que es el c�digo de regi�n que calculamos dentro de la funci�n.
- Se debe crear una nueva fila con el nombre de esa REGION
- El c�digo de la regi�n se debe calcular de forma autom�tica. Para ello se debe 
  averiguar cual es el c�digo de regi�n  m�s alto que tenemos en la tabla en ese 
  momento,  le sumamos 1 y el resultado lo ponemos como el c�digo para la nueva
  regi�n que estamos creando.
- Si tenemos alg�n problema debemos generar un error
- La funci�n debe devolver el n�mero que ha asignado a la regi�n
*/
CREATE OR REPLACE FUNCTION fn_create_region(
    p_region_name regions.region_name%TYPE
)
RETURN NUMBER
AS
    max_id NUMBER;
    name regions.region_name%TYPE;
BEGIN

    SELECT region_name 
    INTO name
    FROM regions
    WHERE region_name = p_region_name;

    IF LENGTH(TRIM(name)) > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La regi�n ' || p_region_name || ' ya est� registrado');
    END IF;

    SELECT MAX(region_id)
    INTO max_id
    FROM regions;
   
    max_id := max_id + 1;
   
    INSERT INTO regions(region_id, region_name)
    VALUES(max_id, p_region_name);
   
    COMMIT;
   
    RETURN max_id;
END;
/


--Ejecutando funci�n
DECLARE
    region_id NUMBER;
BEGIN
    region_id := fn_create_region('CASMA');
    dbms_output.put_line('Nuevo id registrado: ' || region_id);
END;
/
