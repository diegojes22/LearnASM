; ==={ mov.asm }===
; Mover ell cursor utilizando la interrupcion para leer una tecla.
; @autor: D

; Con las teclas de la flecha, mover el cursor en pantalla.
; Para salir del programa deberemos pulsar una tecla, como Esc.

.model small
.stack 100h
.data
    msg db 'Presione Esc para salir . . .$'

    coord_x db 5
    coord_y db 5

.code
main proc
    ; Inicializar segmento de datos
    mov ax, @data
    mov ds, ax

    ; establecer el estilo de cursor
    mov ah, 01h
    mov cx, 0Ah ; Cursor visible con forma de bloque
    int 10h

    move_cursor:
        ;// Mover el cursor a la posicion actual
        mov ah, 02h
        mov bh, 0
        mov dl, coord_x
        mov dh, coord_y
        int 10h

        ;// Limpiar pantalla
        mov ah, 06h
        mov al, 00h
        mov bh, 07h
        mov ch, 0      ; Fila superior (y1)
        mov cl, 0      ; Columna izquierda (x1)
        mov dh, 24     ; Fila inferior (y2)
        mov dl, 79     ; Columna derecha (x2)
        int 10h

        jmp main_loop

    main_loop:
        ;// Leer del teclado
        mov ah, 01h
        int 21h

        ;// Comparar teclas pulsadas (A W S D y las flechas del teclado)
        cmp al, 'W'
            je up_arrow
        cmp al , 72 ; Flecha hacia arriba
            je up_arrow

        cmp al, 'A'
            je left_arrow
        cmp al, 75 ; Flecha hacia la izquierda
            je left_arrow

        cmp al, 'S'
            je down_arrow
        cmp al, 80 ; Flecha hacia abajo
            je down_arrow

        cmp al, 'D'
            je right_arrow
        cmp al, 77 ; Flecha hacia la derecha
            je right_arrow

        cmp al, 01Bh ; Esc
            jne move_cursor
        jmp salida

    ;/// Control de movimiento del cursor
    left_arrow:
        ; si es menor a 1 no se mueve a la izquierda
        cmp coord_x, 0
            jle move_cursor
        dec coord_x
        jmp move_cursor

    right_arrow:
        ; si es mayor a 78 no se mueve a la derecha
        cmp coord_x, 78
            jge move_cursor
        inc coord_x
        jmp move_cursor

    up_arrow:
        ; si es menor a 1 no se mueve hacia arriba
        cmp coord_y, 0
            jle move_cursor
        dec coord_y
        jmp move_cursor

    down_arrow:
        ; si es mayor a 23 no se mueve hacia abajo
        cmp coord_y, 23
            jge move_cursor
        inc coord_y
        jmp move_cursor

    salida:
        ; Volver a limpiar la pantalla antes de salir
        ; Limpiar pantalla
        mov ah, 06h
        mov al, 00h
        mov bh, 07h
        mov ch, 0      ; Fila superior (y1)
        mov cl, 0      ; Columna izquierda (x1)
        mov dh, 24     ; Fila inferior (y2)
        mov dl, 79     ; Columna derecha (x2)
        int 10h

        ; Regresar el cursor a la esquina superior izquierda
        mov ah, 02h
        mov bh, 0
        mov dl, 0
        mov dh, 0
        int 10h

        ; Terminar el programa
        mov ax, 4C00h
        int 21h
end