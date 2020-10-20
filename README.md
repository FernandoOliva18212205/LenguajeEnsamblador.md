![](https://images.cooltext.com/5473615.png)

![](https://images.cooltext.com/5473616.png)
## Características generales de la arquitectura ARM
ARM es una arquitectura RISC (Reduced Instruction Set Computer=Ordenador
con Conjunto Reducido de Instrucciones) de 32 bits, salvo la versión del core ARMv8-
A que es mixta 32/64 bits (bus de 32 bits con registros de 64 bits). Se trata de una
arquitectura licenciable, quiere decir que la empresa desarrolladora ARM Holdings
diseña la arquitectura, pero son otras compañías las que fabrican y venden los chips,
llevándose ARM Holdings un pequeño porcentaje por la licencia.
### Registros
La arquitectura ARMv6 presenta un conjunto de 17 registros (16 principales más
uno de estado) de 32 bits cada uno.

__Registros Generales.__ Su función es el almacenamiento temporal de datos. Son los
13 registros que van R0 hasta R12.

__Registros Especiales.__ Son los últimos 3 registros principales: R13, R14 y R15.
Como son de propósito especial, tienen nombres alternativos.

__Registro CPSR.__ Almacena las banderas condicionales y los bits de control. Los
bits de control definen la habilitación de interrupciones normales (I), interrup-
ciones rápidas (F), modo Thumb 1
(T) y el modo de operación de la CPU.


![](images/Captura%20de%20pantalla%202020-10-19%20160622.jpg)

## El lenguaje ensamblador
El ensamblador es un lenguaje de bajo nivel que permite un control directo de
la CPU y todos los elementos asociados. Cada línea de un programa ensamblador
consta de una instrucción del procesador y la posición que ocupan los datos de esa
instrucción.
El ensamblador presenta una serie de ventajas e inconvenientes con respecto a
otros lenguajes de más alto nivel. Al ser un lenguaje de bajo nivel, presenta como
principal característica la flexibilidad y la posibilidad de acceso directo a nivel de
registro. En contrapartida, programar en ensamblador es laborioso puesto que los programas contienen un número elevado de líneas y la corrección y depuración de éstos se hace difícil.

## El entorno

![](images/Captura%20de%20pantalla%202020-10-19%20160611.jpg)

## Aspecto de un programa en ensamblador

* __Sección de datos.__ Viene identificada por la directiva .data. En esta zona se definen todas las variables que utiliza el programa con el objeto de reservar memoria para contener los valores asignados.

* __Sección de código.__ Se indica con la directiva .text, y sólo puede contener código o datos no modificables. Como todas las instrucciones son de 32 bits no hay que tener especial cuidado en que estén alineadas. 

### Datos
Los datos se pueden representar de distintas maneras. Para representar números tenemos 4 bases. La más habitual es en su forma decimal, la cual no lleva ningún delimitador especial.

### Símbolos
Como las etiquetas se pueden ubicar tanto en la sección de datos como en la de
código, la versatilidad que nos dan las mismas es enorme. En la zona de datos, las etiquetas pueden representar variables, constantes y cadenas. En la zona de código
podemos usar etiquetas de salto, funciones y punteros en la zona de datos.

### Instrucciones
De estos campos, sólo el nemónico (nombre de la instrucción) es obligatorio. En
la sintaxis del as cada instrucción ocupa una línea terminando preferiblemente con
el ASCII 10 (LF), aunque son aceptadas las 4 combinaciones: CR, LF, CR LF y LF
CR. Los campos se separan entre sí por al menos un carácter espacio (ASCII 32) o
un tabulador y no existe distinción entre mayúsculas y minúsculas.

### Directivas
Las directivas son expresiones que aparecen en el módulo fuente e indican al
compilador que realice determinadas tareas en el proceso de compilación. Son fácilmente distinguibles de las instrucciones porque siempre comienzan con un punto.

* Directivas de asignación
* Directivas de control
* Directivas de operando
* Directivas de Macros

## Rotaciones y desplazamientos
Las instrucciones de desplazamiento pueden ser lógicas o aritméticas.
Los desplazamientos lógicos desplazan los bit del registro fuente introduciendo
ceros (uno o más de uno). El último bit que sale del registro fuente se almacena en el
flag C. El desplazamiento aritmético hace lo mismo, pero manteniendo
el signo.

![](images/Captura%20de%20pantalla%202020-10-19%20161634.jpg)

Las instrucciones de rotación también desplazan, pero el bit que sale del valor
se realimenta.


![](https://images.cooltext.com/5473617.png)

## Modos de direccionamiento del ARM
En la arquitectura ARM los accesos a memoria se hacen mediante instrucciones específicas ldr y str (luego veremos las variantes ldm, stm y las preprocesadas push y pop).
El resto de instrucciones toman operandos desde registros o valores inmediatos, sin excepciones. En este caso la arquitectura nos fuerza a que trabajemos de
un modo determinado: primero cargamos los registros desde memoria, luego procesamos el valor de estos registros con el amplio abanico de instrucciones del ARM,
para finalmente volcar los resultados desde registros a memoria.

* __Direccionamiento inmediato.__ El operando fuente es una constante, formando parte de la instrucción.
* __Direccionamiento inmediato con desplazamiento o rotación.__ Es una variante del anterior en la cual se permiten operaciones intermedias sobre los registros.
* __Direccionamiento a memoria, sin actualizar registro puntero.__ Es la forma más sencilla y admite 4 variantes. Después del acceso a memoria ningún registro implicado en el cálculo de la dirección se modifica.
* __Direccionamiento a memoria, actualizando registro puntero.__ En este modo de direccionamiento, el registro que genera la dirección se actualiza con la propia dirección. 

## Tipos de datos

### Tipos de datos básicos.

| ARM           | Tipo en C                                                     | bits        | Rango                                                                           |
|---------------|---------------------------------------------------------------|-------------|---------------------------------------------------------------------------------|
| .byte         | unsigned char (signed) char                                   | 8 8         | 0 a 255 -128 a 127                                                              |
| .hword .short | unsigned short int (signed) short int                         | 16 16       | 0 a 65.535 -32.768 a 32767                                                      |
| .word .int    | unsigned int (signed) int unsigned long int (signed) long int | 32 32 32 32 | 0 a 4294967296 -2147483648 a 2147483647 0 a 4294967296 -2147483648 a 2147483647 |
| .quad         | unsigned long long (signed) long long                         | 64 64       | 0 a 2^64 -2^63 a 2^63 -1                                                        |

__Punteros.__ Un puntero siempre ocupa 32 bits y contiene una dirección de memoria.
En ensamblador no tienen tanta utilidad como en C, ya que disponemos de registros
de sobra y es más costoso acceder a las variables a través de los punteros que directamente

__Vectores.__ Todos los elementos de un vector se almacenan en un único bloque de
memoria a partir de una dirección determinada. Los diferentes elementos se almacenan en posiciones consecutivas, de manera que el elemento i está entre los i-1 e i+1.

__Matrices bidimensionales.__ Una matriz bidimensional de N×M elementos se almacena en un único bloque de memoria. Interpretaremos una matriz de N×M como
una matriz con N filas de M elementos cada una. Si cada elemento de la matriz
ocupa B bytes, la matriz ocupará un bloque de M ×N ×B bytes.

## Instrucciones de salto
Las instrucciones de salto pueden producir saltos incondicionales (b y bx) o
saltos condicionales. Cuando saltamos a una etiqueta empleamos b, mientras que
si queremos saltar a un registro lo hacemos con bx. La variante de registro bx la solemos usar como instrucción de retorno de subrutina, raramente tiene otros usos.

## Estructuras de control de alto nivel
Las estructuras for y while se pueden ejecutar un mínimo de 0 iteraciones (si
la primera vez no se cumple la condición). Para programar en ensamblador estas estructuras se utilizan instrucciones de salto condicional.


<a href="http://cooltext.com" target="_top"><img src="https://cooltext.com/images/ct_pixel.gif" width="80" height="15" alt="Cool Text: Logo and Graphics Generator" border="0" /></a>
