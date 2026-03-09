# Tabla de colores de MS-DOS

| Hex    | Color               | Hex    |  Color              |
|--------|---------------------|--------|---------------------|
| 0      | Negro               | 8      | Gris                |
| 1      | Azul                | 9      | Azul Claro          |
| 2      | Verde               | A      | Verde Claro         |
| 3      | Aqua                | B      | Aqua Claro          |
| 4      | Rojo                | C      | Rojo Claro          |
| 5      | Purpura             | D      | Rosa                |
| 6      | Amarillo            | E      | Amarillo Claro      |
| 7      | Blanco              | F      | Blanco Brillante    |

Esta tabla puede ser consultada al ingresar el comando `color ?` en el **cmd**

## Uso
Una de los usos para esta tabla de colores es cuando llamamos un Scroll Up, el cual nos permite darle a la consola diferentes colores. 
En el caso concreto del **Scroll**, debemos llamar configurar estos valores
```asm
    mov ah, 06h
    mov al, 00h
    mov bl, 00h
```
Pero la parte que nos interesa es el valor que puede tomar el registro `bl`.

**Dos** maneja el color de la siguiente forma:
- Para el color de fondo tomamos los 4 bits de la izquierda
- Para el color del texto tomamos los 4 bits de la derecha.

Ejemplo: 
```asm
mov     bl,     1Fh      ; Fondo azul con letras blancas
mov     bl,     71h      ; Fondo blanco con letras negras (modo claro =D )
mov     bl,     44h      ; Fondo rojo con texto rojo (poco legible)
```

> Lo anterior es especifico a MSDOS, y dependiendo de la interrupcion, el registro para configurar el color puede variar.