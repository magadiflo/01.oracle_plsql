/***************************************************************************************************
Par�metro tipo IN
****************************************************************************************************
- La palabra reservada IN indica que el par�metro que se est� colocando es de entrada.
- El par�metro tipo IN es el tipo de par�metro por defecto, no es necesario colocarlo.
- Los par�metros de entrada (IN) son solo de lectura, no pueden ser modificados.
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
*/
CREATE OR REPLACE PROCEDURE sp_calculate_tax(
    p_id IN employees.employee_id%TYPE, -- Colocamos expl�citamente el IN diciendo que es un par�metro de entrada
    p_tax NUMBER                        -- Aqu� el par�metro IN est� por defecto.
)
AS
    tax NUMBER := 0;
    salary NUMBER := 0;
BEGIN
    IF p_tax < 0 OR p_tax > 60 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El porcentaje debe estar entre 0 y 60');
    END IF;
    
    SELECT e.salary
    INTO salary
    FROM employees e
    WHERE e.employee_id = p_id;
    
    tax := salary * p_tax/100;
    
    dbms_output.put_line('Salario: ' || salary);
    dbms_output.put_line('Impuesto: ' || tax);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existe el empleado.');
END;
/

-- Ejecutando procedimiento
EXECUTE sp_calculate_tax(100, 20);
EXECUTE sp_calculate_tax(10, 20);
EXECUTE sp_calculate_tax(100, 90);

