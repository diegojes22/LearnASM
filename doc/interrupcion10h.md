# Interrupcion 10H

La interrupcion **10h** (o interrupcion **16** en numeracion decimal) es una interrupcion el cual proporciona servicios para la manipulacion de video. Estos servicios incluyen la configuración del modo de vídeo, la salida de caracteres y cadenas, y las primitivas gráficas (lectura y escritura de píxeles en modo gráfico). Para invocar las funciones de la interrupcion de video es necesario manipular el registro **`AH`** (Parte alta del registro **`AX`**), dependiendo del valor ingresado, se llamara determinada funcion la cual tomara como parametros el resto de regsitros generales (esto ultimo depende de cada funcion de la interrupcion).

Aqui un resumen de cada funcion del registro en formato de tabla:
| No. de Funcion | Codigo | Parametros | Descripcion |
|---|---|---|---|
| 00h | `MOV AH, 00H` | AL → Modo de video (valido en IBM Antiguo) | Establece el modo de video, aunque la manipulacion de esta funcion puede tener diferentes resultados|
| 01h | `MOV AH, 01H` | **CH** → Linea de incio<br>**CL** → Linea de fin<br> Ambos valores van desde el **0 a 7**, pero al agregar **20h** el cursor se torna invisible. | Establecemos el estilo del cursor, ya sea volviendolo mas fino o grueso, mas bajo o alto, que cubra todo el cuadro o que sea invisible. Para esta funcion se recomienda experimentar mucho con diferentes valores |
| 02h | `MOV AH, 02H` | **BH** → Display Page (se recomienda que el valor sea **0**)<br>**DH** → Fila (eje **y**)<br>**DL** → Columna (eje **x**) | Permite posicionar el cursor en diferentes zonas o coordenadas de la pantalla. Hay que considerar que el tamaño de la pantalla es de **79 x 24** si estamos en **modo de texto**, por lo que si los valores de los registros exceden dichas cifras es posible obtener resultados impredecibles. |
| 06h | `MOV AH, 06H` | **AL** → Numero de lineas que seran desplazadas hacia arriba (si colocas AL en 0, la pantalla se limpiara).<br>**BH** → Color que llenara las nuevas lineas en blanco (dependiendo del modo de video cambiara el comportamiento).<br>**CH** → Filas superiores (**y1**).<br>**CL** → Columnas izquierdas (**x1**).<br>**DH** → Filas inferiores (**y1**).<br>**DL** → Columnas derechas (**x2**). | Scroll Up: Desplaza el contenido de la ventana hacia arriba. Las líneas que salen por arriba se pierden y las nuevas líneas que aparecen por abajo se rellenan con el color de BH. Si AL=0, se limpia la ventana completa. |
| 07h | `MOV AH, 07H` | Los parametros son exactamente los mismos de la funcion anterior | Scroll Down: Desplaza el contenido de la ventana hacia abajo. Las líneas que salen por abajo se pierden y las nuevas líneas que aparecen por arriba se rellenan con el color de BH. Si AL=0, se limpia la ventana completa. |
| 09h | `MOV AH, 09H` | **AL** → Codigo ascii del caracter a imprimir<br>**CX** → Numero de veces a imprimir el caracter.<br>**BH** → Display Page, recomendable que este en **0**.<br>Atributo de color. Permite definir el color que se mostrara junto con el caracter | Permite imprimir un caracter (una letra) en la posicion del cursor |

## Ejemplos
Lo anterior puede parecer algo complicado y abstracto debido a que solo se menciona la teoria de lo que realiza cada funcion de video. Por ello, lo mejor y mas recomendable es probrar todo esto y jugar con los diferentes valores que se tienen. Por esto mismo, a continuacion se presentan algunos fragmentos de ccodigo que ejemplifican lo anterior.

> Muchas partes de esto estan implementados en diferentes archivos de codigo de la carpeta `src/`, por lo que consultarlos puede ser una buena referencia.

### Efectos de cursor
```asm
; Cursor bloque completo
MOV  AH, 01h    ; función: Set Cursor Type
MOV  CH, 00h    ; scan line inicio = 0 (arriba de la celda)
MOV  CL, 07h    ; scan line fin   = 7 (abajo de la celda)
INT  10h        ; llamar a BIOS Video
 
; Ocultar el cursor
MOV  AH, 01h
MOV  CH, 20h    ; bit 5 = 1 → cursor invisible
MOV  CL, 00h
INT  10h
 
; Cursor normal (restaurar)
MOV  AH, 01h
MOV  CH, 06h
MOV  CL, 07h
INT  10h
```

Esta tabla facilita el conocer los estilos de cursor disponibles:
| Efecto | CH | CL | Descripción |
|--------|----|----|-------------|
| Cursor normal (subrayado) | `06h` | `07h` | Línea en la parte inferior de la celda. Comportamiento predeterminado de DOS. |
| Cursor bloque | `00h` | `07h` | Rellena toda la celda del carácter. Mayor visibilidad. |
| Cursor mitad | `04h` | `07h` | Ocupa la mitad inferior de la celda. |
| Cursor fino | `07h` | `07h` | Línea extremadamente delgada, casi imperceptible. |
| Cursor oculto | `20h` | `00h` | El bit 5 de CH actúa como flag "cursor off". No se muestra ningún cursor. |

> **Nota**<br>
> Los valores exactos de los scan lines pueden variar según el modo de video activo.<br>
> En modo texto estándar (modo 3), los scan lines van de 0 a 7 (CGA) o de 0 a 15 (VGA).<br>
> En DosBox el comportamiento es equivalente al modo texto CGA de 8 líneas por carácter.
 
### Movimiento de cursor
```asm
; Posicionar el cursor en la fila 5, columna 10
MOV  AH, 02h    ; función: Set Cursor Position
MOV  BH, 00h    ; página de video 0
MOV  DH, 05h    ; fila 5 (eje Y)
MOV  DL, 0Ah    ; columna 10 (eje X)
INT  10h

; Posicionar el cursor en la esquina superior izquierda (0, 0)
MOV  AH, 02h
MOV  BH, 00h
MOV  DH, 00h    ; fila 0
MOV  DL, 00h    ; columna 0
INT  10h

; Posicionar el cursor en el centro aproximado de la pantalla (12, 39)
MOV  AH, 02h
MOV  BH, 00h
MOV  DH, 0Ch    ; fila 12
MOV  DL, 27h    ; columna 39
INT  10h
```

> **Recordatorio**
> La pantalla en modo texto tiene un tamaño de 80 x 25 (columnas x filas), con índices de 0 a 79 en X y 0 a 24 en Y.
> Exceder estos rangos puede producir resultados impredecibles.

### Scroll Up / Limpiar pantalla
 
```asm
; Limpiar la pantalla completa (AL = 0 limpia toda la ventana)
MOV  AH, 06h    ; función: Scroll Up
MOV  AL, 00h    ; 0 = limpiar toda la ventana definida
MOV  BH, 07h    ; color de relleno: gris claro sobre negro (atributo estándar)
MOV  CH, 00h    ; fila superior y1 = 0
MOV  CL, 00h    ; columna izquierda x1 = 0
MOV  DH, 18h    ; fila inferior y2 = 24
MOV  DL, 4Fh    ; columna derecha x2 = 79
INT  10h
 
; Desplazar 2 líneas hacia arriba en una subventana (filas 5-15, columnas 0-79)
MOV  AH, 06h
MOV  AL, 02h    ; desplazar 2 líneas
MOV  BH, 07h    ; color de relleno de las líneas nuevas
MOV  CH, 05h    ; fila superior y1 = 5
MOV  CL, 00h    ; columna izquierda x1 = 0
MOV  DH, 0Fh    ; fila inferior y2 = 15
MOV  DL, 4Fh    ; columna derecha x2 = 79
INT  10h
```
 
> **Nota**<br>
> El atributo de color en `BH` sigue el formato estándar de texto: los 4 bits altos son el color de fondo y los 4 bits bajos el color del texto. Por ejemplo, `07h` = fondo negro, texto gris claro.
 
---
 
### Scroll Down
 
```asm
; Desplazar 1 línea hacia abajo en la pantalla completa
MOV  AH, 07h    ; función: Scroll Down
MOV  AL, 01h    ; desplazar 1 línea hacia abajo
MOV  BH, 07h    ; color de relleno de la línea nueva (arriba)
MOV  CH, 00h    ; fila superior y1 = 0
MOV  CL, 00h    ; columna izquierda x1 = 0
MOV  DH, 18h    ; fila inferior y2 = 24
MOV  DL, 4Fh    ; columna derecha x2 = 79
INT  10h
 
; Limpiar pantalla completa con scroll down (AL = 0)
MOV  AH, 07h
MOV  AL, 00h    ; 0 = limpiar toda la ventana definida
MOV  BH, 07h
MOV  CH, 00h
MOV  CL, 00h
MOV  DH, 18h
MOV  DL, 4Fh
INT  10h
```
 
> **Nota**<br>
> La diferencia con `06h` es la dirección del desplazamiento: `06h` mueve el contenido hacia **arriba** y las líneas nuevas aparecen abajo; `07h` mueve el contenido hacia **abajo** y las líneas nuevas aparecen arriba.
 
---
 
### Imprimir carácter
 
```asm
; Imprimir el carácter 'A' (41h) una vez, en blanco sobre negro
MOV  AH, 09h    ; función: Write Character and Attribute
MOV  AL, 41h    ; código ASCII de 'A'
MOV  BH, 00h    ; página de video 0
MOV  BL, 0Fh    ; atributo: texto blanco (0F) sobre fondo negro
MOV  CX, 01h    ; imprimir 1 vez
INT  10h
 
; Imprimir el carácter '*' (2Ah) 10 veces, en amarillo sobre azul
MOV  AH, 09h
MOV  AL, 2Ah    ; código ASCII de '*'
MOV  BH, 00h
MOV  BL, 1Eh    ; atributo: texto amarillo (E) sobre fondo azul (1)
MOV  CX, 0Ah    ; imprimir 10 veces
INT  10h
 
; Imprimir un carácter de línea horizontal (C4h) para dibujar una barra
MOV  AH, 09h
MOV  AL, 0C4h   ; carácter de línea horizontal del juego ASCII extendido
MOV  BH, 00h
MOV  BL, 07h    ; atributo estándar: gris sobre negro
MOV  CX, 50h    ; repetir 80 veces (ancho de pantalla)
INT  10h
```
 
> **Nota**<br>
> La función `09h` **no avanza el cursor** automáticamente después de imprimir. Si necesitas continuar escribiendo en la siguiente posición, debes mover el cursor manualmente con `02h`.<br>
> El atributo de `BL` sigue el mismo formato que `BH` en scroll: `[fondo(4 bits)][texto(4 bits)]`.