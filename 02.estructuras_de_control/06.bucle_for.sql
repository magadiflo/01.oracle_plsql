/***************************************************************************************************
Bucle FOR
****************************************************************************************************
*/
SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
i, est� declarado de manera impl�cita dentro del FOR, es decir, no es necesario
declararlo. As�mismo, el i ser� del tipo PLS_INTEGER, que es un tipo de dato 
que ocupa menos que el NUMBER.
*/
BEGIN
    FOR i IN 5..10 LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
/

/* Ejemplo 01
******************************************************
i, est� declarado de manera impl�cita dentro del FOR siendo del tipo PLS_INTEGER,
es un tipo de dato que ocupa menos que el NUMBER.
*/
BEGIN
    FOR i IN REVERSE 5..15 LOOP
        dbms_output.put_line(i);
        EXIT WHEN i = 10;
    END LOOP;
END;
/