/***************************************************************************************************
Comando IF
****************************************************************************************************
*/
SET SERVEROUTPUT ON;

/* Ejemplo 01
*******************************************************/
DECLARE
    salary NUMBER(8, 2) := 2500;
BEGIN
    IF salary = 2500 THEN
        dbms_output.put_line('Salario base: S/' || salary);
    ELSE
        dbms_output.put_line('Salario no mapeado');
    END IF;
END;
/

/* Ejemplo 02
*******************************************************/
DECLARE
    sales NUMBER := 25000;
    bonus NUMBER := 0;
BEGIN
    IF sales > 50000 THEN
        bonus := 1500;
    ELSIF sales > 3500 THEN
        bonus := 500;
    ELSIF sales > 20000 THEN
        bonus := 150;
    ELSE    
        bonus := 100;
    END IF;
    dbms_output.put_line('Sales = ' || sales || ', bonus = ' || bonus || '.');
END;
/
/* Ejemplo 03
*******************************************************
Debemos hacer un bloque PL/SQL an�nimo, donde declaramos una variable NUMBER y 
le ponemos alg�n valor.

Debe indicar si el n�mero es PAR o IMPAR. Es decir debemos usar IF..... ELSE 
para hacer el ejercicio.

Como pista, recuerda que hay una funci�n en SQL denominada MOD, que permite 
averiguar el resto de una divisi�n. 

Por ejemplo MOD(10,4) nos devuelve el resto de dividir 10 por 4.
*/
DECLARE
    age NUMBER := 33;
BEGIN
    IF MOD(age, 2) = 0 THEN
        dbms_output.put_line('La edad ' || age || ' es un n�mero par');
    ELSE 
        dbms_output.put_line('La edad ' || age || ' es un n�mero impar');
    END IF;
END;
/
/* Ejemplo 04
*******************************************************
Crear una variable CHAR(1) denominada TIPO_PRODUCTO.
Poner un valor entre "A" Y "E"
Visualizar el siguiente resultado seg�n el tipo de producto
  'A'  --> Electronica
  'B'  -->  Inform�tica
  'C'  --> Ropa
   'D' --> M�sica
   'E' --> Libros
Cualquier otro valor debe visualizar "El c�digo es incorrecto"
*/
DECLARE
    product_type CHAR(1);
BEGIN
    product_type := 'C';
    IF product_type = 'A' THEN
        dbms_output.put_line('Electr�nica');
    ELSIF product_type = 'B' THEN
        dbms_output.put_line('Inform�tica');
    ELSIF product_type = 'C' THEN
        dbms_output.put_line('Ropa');
    ELSIF product_type = 'D' THEN
        dbms_output.put_line('M�sica');
    ELSIF product_type = 'E' THEN
        dbms_output.put_line('Libros');
    ELSE
        dbms_output.put_line('El c�digo es incorrecto');
    END IF;
END;
/