/***************************************************************************************************
Visualizar datos por pantalla
****************************************************************************************************
SET SERVEROUTPUT ON, habilita la salida por pantalla.

La barra / se limita a ejecutar el bloque actual, es decir, evita que otros
bloques an�nimos se ejecuten, centr�ndose �nicamente en la ejecuci�n del bloque
actual.

Por ejemplo: 
Si quitamos las barras / de ambos bloques an�nimos y nos posicionamos en el 
primer bloque an�nimo y ejecutamos Ctrl + enter, veremos que en consola nos
mostrar� un error, eso sucede porque est� ejecutandose todo el script. Entonces,
para limitarnos a ejecutar el bloque an�nimo actual, es que usamos la barra /
*/

SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hola ' || ' mundo!');
    DBMS_OUTPUT.PUT_LINE(3.141516);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Segundo bloque an�nimo ');
END;
/