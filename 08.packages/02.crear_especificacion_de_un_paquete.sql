/***************************************************************************************************
Crear la especificaci�n de un paquete
****************************************************************************************************
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
Crear el SPEC de un package donde definamos dos variables,
uno para almacenar la edad y otro para almacenar un email.

Observar que �No tenemos body! y eso est� bien, ya que como dec�amos en 
el archivo anterior, el spec es obligatorio mientras que el body es opcional.
*/
CREATE OR REPLACE PACKAGE package_variables
AS
    -- Declaramos todos los objetos que ser�n p�blicos
    age NUMBER;
    email VARCHAR2(100);
END;
/

-- Usando package
BEGIN
    package_variables.age := 34;
    package_variables.email := 'martin@gmail.com';
    
    dbms_output.put_line('Edad: ' || package_variables.age);
    dbms_output.put_line('Email: ' || package_variables.email);
END;
/