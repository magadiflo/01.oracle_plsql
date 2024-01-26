/***************************************************************************************************
RAISE_APPLICATION_ERROR
****************************************************************************************************
Es una funci�n que nos permite devolver un excepci�n personalizada deteniendo la ejecuci�n
del bloque. Lanza la excepci�n con un c�digo de error y un mensaje personalizado. El c�digo
de error debe estar entre -20000 y -20999.

Es como lo errores que lanza ORACLE cuando ocurre alguna excepci�n.
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
*/
DECLARE
    id NUMBER;
    name VARCHAR2(200);
BEGIN
    id := 101;
    name := 'Ocean�a';
    
    IF id > 100 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El id no puede ser mayor que 100');
    ELSE
        INSERT INTO regions
        VALUES(id, name);
        
        COMMIT;
    END IF;
END;
/

/* Ejemplo 01
******************************************************
Modificar la practica anterior para disparar un error con RAISE_APPLICATION en 
vez de con PUT_LINE. 
*/
DECLARE
    LIMIT_MAX_ID EXCEPTION;
    id NUMBER;
    name VARCHAR2(200);
BEGIN
    id := 101;
    name := 'Ocean�a';
    
    IF id > 100 THEN
        RAISE LIMIT_MAX_ID;
    ELSE
        INSERT INTO regions
        VALUES(id, name);
        
        COMMIT;
    END IF;
EXCEPTION
    WHEN LIMIT_MAX_ID THEN
        RAISE_APPLICATION_ERROR(-20001, 'El id no puede ser mayor que 100');
    WHEN OTHERS THEN
        dbms_output.put_line('Error no reconocido');
END;
/

