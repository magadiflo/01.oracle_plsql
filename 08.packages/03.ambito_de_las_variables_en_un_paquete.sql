/***************************************************************************************************
�mbito de las variables en un paquete
****************************************************************************************************
- La primera vez que se invoca a un paquete, �ste se abre y cont�a as� durante toda la sesi�n.
- Las variables p�blicas creadas dentro del spec del packete, permanecen con el mismo valor 
  durante toda la sesi�n, solo se eliminan si se borra durante el proceso (obviamente)
  o cuando salimos de la sesi�n.
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
*/
CREATE OR REPLACE PACKAGE package_sum
AS
    value NUMBER := 10;
END;
/

-- Usando el package
BEGIN
    /* Aqu� la variable 'value' del paquete contendr� el nuevo valor durante toda la sesi�n,
       es decir, tendra 30, pero si volvemos a ejecutar este bloque pl/sql el valor de value
       se volver� a sumar 20, teniendo a 50 como nuevo valor. Este proceso se repetir� hasta
       que finalice la sesi�n.
       
       Si finalizamos la sesi�n y volvemos a iniciar ejecutando ahora nuevamente este
       bloque pl/sql veremos que el valor que nos imprimir� ser� 30, es decir, se 
       reinician los valores de las variables p�blicas.*/
    package_sum.value := package_sum.value + 20;
    dbms_output.put_line(package_sum.value);
END;
/