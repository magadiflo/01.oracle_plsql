/***************************************************************************************************
Crear un procedimiento
****************************************************************************************************
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
*/
CREATE OR REPLACE PROCEDURE sp_print_value
AS --Se puede usar el IS o el AS. En mi caso para hacerlo similar a SQLServer, usar� el AS
    value NUMBER := 20;
BEGIN
    dbms_output.put_line(value);    
END sp_print_value; --Es recomentable terminar el con nombre del sp (no es obligatorio)
/

--1ra forma de ejecuci�n
EXEC sp_print_value;
/

--2da form  a de ejecuci�n
EXECUTE sp_print_value;
/
--3ra forma de ejecuci�n
BEGIN
    sp_print_value;
END;
/
