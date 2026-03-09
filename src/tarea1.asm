; ==={ tarea 1 }===
; Una animacion simple con la interrupcion de video
; @autor: D

; El siguiente programa es una animacion simple que dibuja dos rectangulos de diferentes colores
; y los intercambia cada cierto tiempo, utilizando la interrupcion de video para dibujar los
; rectangulos, con un delay entre cada cambio el cual fue echo mediante ciclos.

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos

.code             ; Sección de código
main proc
    ; Objetivo: Dibujar dos pequeños rectangulos en la pantalla
    ; y hacer que se intercambien entre ellos cada x tiempo

    ; ===={ Animacion de carga totalmente inecesaria pero que se ve bonita }====
    mov cx, 60
    loading_screen:
        ; Como CX es usado para el ciclo, pero tambien sera usado para el scroll y para el Delay,
        ; necesito guardar el valor de cx antes de manipularlo.
        push cx
        
        ; recordemos que cx en este instante aun guarda el valor de 70 y 70 es un numero
        ; lo suficientemente pequeño cuyo valor en binario aun esta en la parte baja del
        ; registro, es decir, el valor de cx en binario es 0000 0000, 0100 0110.

        ; con lo anterior en mente y dado a que ch vale 70, el cual es usado para la 
        ; columna derecha, solo tengo que poner en 1 a ch (la cual es la fila superior)
        ; para lograr ese efecto de borde.
        mov ch, 1           ; Fila superior 0
        mov dh, 23          ; Fila inferior 23
        mov dl, cl          ; Columna derecha 

        ; Configuro los otros registros para el scroll
        mov ah, 06h
        mov al, 00h
        mov bh, 1Fh         ; Color (1 = azul, F = blanco)

        int 10h             ; Llamada a la interrupción de video para limpiar la pantalla

        ; esto de aqui es un delay, basicamente es un ciclo
        ; algo grande el cual ralentiza el flujo del programa,
        ; causando un efecto de aparicion entre los rectangulos.
        ; Prefiero hacer la pausa mediante una interrupcion.
        mov cx, 0FFFFh
        delay_1:
            loop delay_1

        ; Obtengo el valor original del ciclo para que el loop haga lo suyo
        ; y continuar hasta que cx sea 0
        pop cx
        loop loading_screen

    ; ===={ manejo el cursor para que parezca una boca, lo cual es inecesario) }====
    ; Posicionamiento del cursor (esto es como el gotoxy de C)
    mov ah, 02h    ; Función para mover el cursor
    mov bh, 0      ; Página de video
    mov dl, 20     ; Columna (0-79) x
    mov dh, 20     ; Fila (0-24) y
    int 10h        ; Llamada a la interrupción de video

    ; Coloco un estilo de cursor grueso
    mov ah, 01h    ; Función para configurar el cursor
    mov cl, 7Fh    ; Cursor visible y grueso
    mov ch, 0      ; Cursor visible y grueso
    int 10h        ; Llamada a la interrupción de video

    ; ===={ Ahora si, la tarea }====
    ; Lo que tengo que hacer es el dibujar dos rectangulos de diferentes colores, e intercambiarlos.
    ; Hagamos otro ciclo
    mov cx, 000Fh       ; tal vez unas 15 veces es suficiente
    animacion:
        ; primero, necesito guardar el valor del ciclo
        push cx
        ; Order original de los rectangulos:
        ; Primer rectangulo
        mov ah, 06h
        mov al, 00h
        mov bh, 0A0h        ; color de fondo verde claro

        mov cl, 10
        mov ch, 5
        mov dl, 25
        mov dh, 15
        int 10h             ; Llamada a la interrupción de video para limpiar la

        ; Segundo rectangulo
        mov ah, 06h
        mov al, 00h
        mov bh, 40h        ; color de fondo verde rojo

        mov cl, 35
        mov ch, 5
        mov dl, 50
        mov dh, 15
        int 10h             ; Llamada a la interrupción de video para limpiar la

        ; pausa mas prolongada
        mov cx, 00FFFh
        delay_2:
            push cx
            mov cx, 0FFh
            sub_delay:
                loop sub_delay
            pop cx
            loop delay_2

        ; Colores intercambiados
        ; Primer rectangulo
        mov ah, 06h
        mov al, 00h
        mov bh, 40h        ; color de fondo rojo

        mov cl, 10
        mov ch, 5
        mov dl, 25
        mov dh, 15
        int 10h             ; Llamada a la interrupción de video para limpiar la

        ; Segundo rectangulo
        mov ah, 06h
        mov al, 00h
        
        mov bh, 0A0h        ; color de fondo verde claro
        mov cl, 35
        mov ch, 5
        mov dl, 50
        mov dh, 15
        int 10h             ; Llamada a la interrupción de video para limpiar la

        ; pausa mas prolongada
        mov cx, 00FFFh
        delay_3:
            push cx
            mov cx, 0FFh
            sub_delay_2:
                loop sub_delay_2
            pop cx
            loop delay_3

        ; Recupero el valor del ciclo para continuar
        pop cx
        loop animacion

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end