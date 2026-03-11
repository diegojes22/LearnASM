; ==={ IncDec.asm }===
; Operaciones de incremento y decrtemento, suma y resta
; @autor: D

; Lo que vamos a hacer es ejemplificar el uso de las operaciones
; de incremento y decremento, ademas de suma y resta, para esto
; nos ayudaremos de imprimir una letra. Facil!

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos

.code             ; Sección de código
main proc
    ; Primero hagamos esto
    mov cx, 'a'     ; Cargamos el codigo ascii de la a (el cual es 97) en cx
    push cx

    ; Hagamos una impresion rapida
    mov ah, 09h     ; Funcion para imprimir un caracter: llammosla PRINT CHART
    mov al, cl      ; Movemos el caracter de nuestro registro cx a la parte baja de ax
    mov bh, 0
    mov bl, 07h     ; Fondo negro con letras blancas
    mov cl, 2
    int 10h

    ; El resultado esperado en la consola es 'a'
    ; pero . . . Y si lo incrementamos?
    pop cx
    inc cx  

    ; Si nos vamos a la tabla del codigo ascii, pasamos de un 97
    ; a un 98, y dicho valor pertenece a la B, por lo que
    ; ahora imprimira una 'b'. Veamos si es cierto.
    push cx

    mov ah, 09h     ; PRINT CHAR
    mov al, cl      ; Movemos el caracter de nuestro registro cx a la parte baja de ax
    mov bh, 0
    mov bl, 0Eh     ; Cambiemos el color a un fondo negro con letras amarillas
    mov cl, 1
    int 10h

    ; En efecto, el resultado es una 'b' amarilla

    ; Hagamos algo mas loco, que tal si usamos un ciclo, incrementamos un
    ; valor a partir de la 'b', y vemos que obtenemos.
    ; Pero antes, movamos un poco la pantalla
    mov ah, 06h ; subir texto
    mov al, 2
    mov bh, 0

    mov cl, 0
    mov ch, 24
    mov dl, 70
    mov dh, 24
    int 10h

    ; Ahora, hagamos una locura
    pop dx
    mov cx, 5       ; unos 5 incrementos de 2 en 2

    incremento:
        add dx, 2
        loop incremento

    ; Ok, hagamos una impresion para ver que sale
    mov al, dl  ; primero, muevo el valor de la letra a la parte baja de ax

    mov ah, 09h     ; PRINT CHAR
    mov bh, 0
    mov bl, 0Ah     ; Cambiemos el color a un fondo negro con letras verdes brillantes
    mov cl, 1
    int 10h

    ; Obtuvimos una 'l' verde, Porque?
    ; Facil! Considerando que teniamos 'b' con un valor de 98, al hacer 
    ; 5 incrementos de 2 en 2 obtendremos 108, el cual es el codigo ascii
    ; de la 'l'. Lo anterios lo podemos ver reflejado por la siguient
    ; operacion matematica:
    ;       98 + (5 * 2) = 108
    ;               o
    ;    valor_ascii + (loop * inc)
    ; Simplemente, epico.
    
    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end