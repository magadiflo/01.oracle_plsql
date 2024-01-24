/***************************************************************************************************
Bloques an�nimos
****************************************************************************************************
El objeto b�sico de PL/SQL es un bloque.
Los bloques est�n divididos en las siguientes secciones:

DECLARE
BEGIN       (Obligatorio) Inicia el bloque
EXCEPTION
END;        (Obligatorio) Indica el fin del bloque. Debe terminar en ; para 
             indicare a PL/SQL que se ha terminado ese trozo de c�digo.


Para crear un bloque, en este caso un bloque an�nimo, solo son obligatorios tener
definidas las cl�usulas BEGIN y END;
*/

/* Ejemplo 01
******************************************************
- Entre el BEGIN y END colocaremos todos los comandos PL/SQL que estemos creando.
- Un bloque PL/SQL no puede estar vac�o, al menos debe haber un comando.
- El NULL, que le colocamos dentro nos servir� para poder ejecutar el bloque 
  sin que tenga contenido, de esa manera no nos mostrar� error.
*/

BEGIN
    NULL;
END;