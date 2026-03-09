; ==={ tarea 1 - b }===
; Una animacion simple con la interrupcion de video (simplificado)
; @autor: D

; El siguiente programa es una animacion simple que dibuja dos rectangulos de diferentes colores
; y los intercambia cada cierto tiempo.

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos

.code             ; Sección de código
main proc
    ; ===={ manejo el cursor para que parezca una boca }====
    ; Posicionamiento del cursor (esto es como el gotoxy de C)
    mov ah, 02h    ; Función para mover el cursor
    mov bh, 0      
    mov dl, 20     ; Columna 
    mov dh, 20     ; Fila 
    int 10h        

    ; Coloco un estilo de cursor grueso
    mov ah, 01h    ; Función para configurar el cursor
    mov cl, 7Fh    ; Cursor visible y grueso
    mov ch, 0      ; Cursor visible y grueso
    int 10h        

    ; ===={ Ahora si, la tarea }====
    ; Primero pintamos un fondo bonito en azul mediante el Scroll
    mov ah, 06h        ; Función 6h - Scroll de ventana
    mov al, 00h
    mov bh, 1Fh         ; Color (1 = azul, F = blanco)
    mov ch, 1           
    mov dh, 23          
    mov dl, 60          
    mov cl, 1

    int 010h

    ; Lo que tengo que hacer es el dibujar dos rectangulos de diferentes colores, e intercambiarlos.
    ; Hagamos un ciclo
    mov cx, 000Fh       ; tal vez unas 15 veces es suficiente
    animacion:
        ; primero, necesito guardar el valor del ciclo
        push cx
        ; #### Order original de los rectangulos:
        ; Primer rectangulo
        mov ah, 06h         ; Funcion 6h - Scroll de ventana
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
        mov bh, 40h        ; color de fondo rojo

        mov cl, 35
        mov ch, 5
        mov dl, 50
        mov dh, 15
        int 10h             ; Llamada a la interrupción de video para limpiar la

        ; pausa prolongada
        mov cx, 00FFFh
        delay_2:
            push cx

            mov cx, 0FFh
            sub_delay:
                loop sub_delay

            pop cx
            loop delay_2

        ; #### Colores intercambiados
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

        ; otra pausa prolongada
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