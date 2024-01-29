/***************************************************************************************************
Crear un cursor
****************************************************************************************************
�IMPORTANTE!
En otras bases de datos, los cursores nos permite ir hacia adelante, hacia atr�s, etc. en ORACLE eso
no es posible, es decir, el poder moverse en cualquier direcci�n que se quiera. En ORACLE podemos 
avanzar �nicamente hacia adelante, es decir, abrimos el cursor, leemos de manera secuecial y cerramos
el cursor.

Si quisi�ramos movermos en cualquier direcci�n debemos usar ARRAYS o tipos TABLES.
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
*/
DECLARE
    --1. declaramos el cursor
    CURSOR c_regions
    IS SELECT * 
        FROM regions;
        
    row_region regions%ROWTYPE;
BEGIN
    --2. abrimos el cursor
    OPEN c_regions;
    
    --3. Leemos datos del cursor
    FETCH c_regions INTO row_region;
    dbms_output.put_line(row_region.region_name);
    
    --4.cerramos el cursor
    CLOSE c_regions;
END;
/