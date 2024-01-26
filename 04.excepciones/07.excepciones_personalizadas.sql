/***************************************************************************************************
Excepciones personalizadas
****************************************************************************************************
Son excepciones desarrolladas por el propio usuario. Para lanzar una excepci�n se
usa la cl�usula RAISE.

RAISE, es una cl�usula que se usa en excepciones personalizadas y nos permite 
lanzarlas. Cuando RAISE lanza la excepci�n personalizada, esta se dirige al 
bloque EXCEPTION donde debemos capturarlo.

Cuando tenemos una excepci�n personalizada ORACLE no sabe en qu� momento lanzar
la excepci�n, as� que nosotros somos los responsables de indicarle expl�citamente
cu�ndo debe lanzarse, y eso se hace con la cl�usula RAISE.

Pasos para trabajar con excepciones personalizadas:

PASO 1. Declarar la excepci�n.
PASO 2. Determinar en qu� momento debe lanzarse la excepci�n.
PASO 3. Capturar la excepci�n.
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
En este ejemplo no podemos insertar id en la tabla regions mayores a 100, as� 
que debemos controlar dicha operaci�n.
*/
DECLARE
    LIMIT_REGION_ID EXCEPTION;                          -- PASO 1
    name regions.region_name%TYPE;
    id regions.region_id%TYPE;
BEGIN
    id := 101;
    name := 'Ocean�a';
    
    IF id > 100 THEN
        RAISE LIMIT_REGION_ID;                          -- PASO 2
    ELSE
        INSERT INTO regions(region_id, region_name)
        VALUES(id, name);
        
        COMMIT;
    END IF;
EXCEPTION
    WHEN LIMIT_REGION_ID THEN                           -- PASO 3
        dbms_output.put_line('La regi�n no puede tener un id mayor a 100');
    WHEN OTHERS THEN
        dbms_output.put_line('Error no definido');
END;
/

SELECT * 
FROM regions;

DELETE FROM regions WHERE region_id = 100;