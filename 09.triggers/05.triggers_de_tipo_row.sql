/***************************************************************************************************
Crear un triggers de tipo row
****************************************************************************************************
Un trigger del tipo row es aquel que se dispara por cada fila de la operaci�n.
Cuando se trabajan con triggers de tipo row se tienen dos tipos de datos disponibles:

- :OLD
- :NEW

Estos tipos de datos nos sirven para poder acceder a la informaci�n antes de ejecutar
la consulta SQL o despu�s de haberla ejecutado. Por ejemplo, si realizamos la 
consulta UPDATE de alguna tabla, con el :OLD obtenemos la informaci�n antigua y
con el :NEW obtenemos la nueva informaci�n con el que se quiere actualizar.

Veamos el siguiente cuadro para entender mejor:

OPERACI�N           :OLD                :NEW
--------------------------------------------------------
insert              null                valor del insert
update              valor anterior      valor nuevo
delete              valor anterior      null
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
Queremos que cada vez que se haga un insert o un update siempre las regiones
se guarden en may�scula.
*/
CREATE OR REPLACE TRIGGER tx_regions
BEFORE INSERT OR UPDATE OR DELETE
ON regions
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        /*
        Antes de que se vaya a la tabla regions y lo inserte, lo que hacemos
        aqu� es convertir a may�scula la informaci�n que trae el :NEW.region_name
        */
        :NEW.region_name := UPPER(TRIM(:NEW.region_name));
        
        -- Este es el insert pero del log.
        INSERT INTO logs(event, table_name, username)
        VALUES('insert', 'regions', USER);
    ELSIF UPDATING('region_name') THEN
        :NEW.region_name := UPPER(TRIM(:NEW.region_name));
    
        INSERT INTO logs(event, table_name, username)
        VALUES('update column region_name', 'regions', USER);
    ELSIF UPDATING('region_id') THEN   
        INSERT INTO logs(event, table_name, username)
        VALUES('update column region_id', 'regions', USER);
    ELSIF DELETING THEN
        INSERT INTO logs(event, table_name, username)
        VALUES('delete', 'regions', USER);
    END IF;
END tx_regions;
/

-- Probando trigger
INSERT INTO regions(region_id, region_name)
VALUES(5, 'Ant�rtida');

UPDATE regions
SET region_name = 'ocean�a'
WHERE region_id  = 5;

DELETE FROM regions WHERE region_id = 5;

SELECT *
FROM regions;

SELECT * 
FROM logs;

DESCRIBE logs;