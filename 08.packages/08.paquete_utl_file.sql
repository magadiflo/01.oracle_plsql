/***************************************************************************************************
Paquete: UTL_FILE
****************************************************************************************************
UTL_FILE, este paquete nos permite trabajar con ficheros externos a la base de datos, como poder leer
datos desde un archivo o poder exportar datos hacia un archivo.

Para que un usuario pueda utilizar el paquete UTL_FILE debemos darle los permisos adecuados. 
En nuestro caso, como estamos trabajando con el usuario hr, pues debemos darle los permisos que
requiere. 

Para eso, como estamos trabajando con Oracle 21c, necesitamos crear una nueva conexi�n con el 
usuario sys y rol sysdba.

A continuaci�n se muestran los datos de creaci�n de la conexi�n schema_sys:

Name: schema_sys
Username: sys
Password: magadiflo
Role: SYSDBA
Hostname: localhost
Port: 1521
Service name: XEPDB1

Una vez creada la conexi�n del usuario sys, abrimos un script en esa conexi�n y ejecutamos 
las siguientes instrucciones:

    (1) GRANT CREATE ANY DIRECTORY TO hr;      
    (2) GRANT EXECUTE ON SYS.UTL_FILE to hr;
    
(1) Le damos permiso para que pueda crear cualquier directorio. El DIRECTORY mapea un
    directorio f�sico del sistema operativo con un objeto DIRECTORY de ORACLE, de forma
    que, el usuario que trabaja con un DIRECTORY no tiene por qu� saber en qu� directorio
    f�sico de la m�quina est� almacen�ndose la informaci�n.
(2) Le damos permiso para ejecutar el paquete UTL_FILE que pertenece al usuario SYS.
*/

/*
Ahora que el usuario hr tiene los permisos necesario, empezaremos creando un objeto 
DIRECTORY al que llamaremos "magadiflo" y estar� apuntando al path 'M:\magadiflo'.
Es necesario crear el path manualmente.
*/
CREATE OR REPLACE DIRECTORY magadiflo AS 'M:\magadiflo';
/*
El el path M:\magadiflo crearemos un archivo de texto llamado file.txt
y agregaremos el siguiente contenido:

a
b
c
d
e
f
g

Listo, ahora crearemos el siguiente procedimiento almacenado sp_read_file:
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
*/
CREATE OR REPLACE PROCEDURE sp_read_file
AS 
    v_text VARCHAR2(32767);
    v_file UTL_FILE.FILE_TYPE;-- FILE_TYPE, es el tipo que est� definido dentro 
                              -- de UTL_FILE y devuelve los datos del fichero.
BEGIN
    -- ABRIMOS EL ARCHIVO
    -- magadiflo, nombre del directorio que creamos con la instrucci�n CREATE 
    -- OR REPLACE DIRECTORY para este usuario hr
    v_file := UTL_FILE.FOPEN('magadiflo', 'file.txt', 'R');
    
    -- TRABAJAMOS CON EL ARCHIVO
    LOOP
        BEGIN
            UTL_FILE.GET_LINE(v_file, v_text);
            dbms_output.put_line('Texto obtenido: ' || v_text);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                EXIT;
        END;
    END LOOP;
    
    -- CERRAMOS EL ARCHIVO
    UTL_FILE.FCLOSE(v_file);
END sp_read_file;
/


-- Ejecutando procedimiento almacenado
BEGIN
    sp_read_file;
END;
/