/***************************************************************************************************
Atributos impl�citos
****************************************************************************************************

> SQL%ISOPEN, como un atributo impl�cito siempre nos devolver� "false", ya que el cursor es manejado
  por debajo, de manera transparence se abrir� y al final siempre estar� cerrado, mientras que si 
  hablamos de un cursor expl�cito, aqu� si nos servir� este atributo.
  
> SQL%FOUND

> SQL%NOTFOUND

> SQL%ROWCOUNT

- SQL, es el nombre que se le pone a los cursores impl�citos.
- Estos atributos impl�citos lo podemos consultar justo cuando hemos ejecutado el 
  cursor.
- Los atributos SQL%FOUND, SQL%NOTFOUND solo est�n disponibles para las sentencias:
  INSERT, UPDATE y DELETE. Para la sentencia SELECT no est�n disponibles, ya que
  si el SELECT no encuentra cierta fila, lanzar� una EXCEPTION de NOT_FOUND.
  
*/

SET SERVEROUTPUT ON;

/* Ejemplo 01
******************************************************
En el ejemplo siguiente vemos que el UPDATE ..... WHERE id = 1; es un cursor
impl�cito, es decir, ORACLE por debajo abrir� un cursor, ejecutar�, etc.. hasta
el punto donde nos retorna el control del script, por eso es que se le llama
cursor impl�cito.

Justo cuando hemos ejecutado el cursor impl�cito (en eset caso el UPDATE) los
atributos que mencionamos al inicio ser�n rellenados, as� que podemos ver sus
valores si los imprimimos justo a continuaci�n de la ejecuci�n del cursor 
impl�cito:
*/
BEGIN
    UPDATE test 
    SET name = 'probando'
    WHERE id = 1;
    
    dbms_output.put_line(SQL%ROWCOUNT);
    --Como el dbms_output.put_line() no admite booleanos, usaremos un if para ver los otros atributos.
    IF SQL%FOUND THEN
        dbms_output.put_line('Encontrado!');
    ELSIF SQL%NOTFOUND THEN
        dbms_output.put_line('Registro no encontrado!');
    END IF;
END;
/
