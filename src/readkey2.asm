; ==={ readkey2.asm }===
; Imprimir numeros del 0 al 9 con una pausa intermedia, y terminar el
; programa cuando se pulse una tecla.
; @autor: D
; En el siguiente programa vamos a imprimir los numeros del 0 al 9 en pantalla, con una pausa 
; intermedia entre cada numero, y terminar el programa cuando se pulse una tecla. Para esto 
; usaremos la funcion 0Bh de la interrupcion 21h, la cual nos devuelve en el registro al el 
; valor 0FFh si hay una tecla pulsada, o el valor 000h si no hay ninguna tecla pulsada. El 
; programa se ejecutara en un bucle infinito hasta que se pulse una tecla, momento en el 
; cual se terminara el programa.

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos
    msg db "Pulse una tecla para terminar el programa . . .", 0Ah,  "$"
    contador db 48

.code             ; Sección de código
main proc
    ; Preparar segmento de datos
    mov ax, @data
    mov ds, ax

    ; Imprimir mensaje de alerta
    mov ah, 09h
    mov dx, offset msg
    int 21h

    loop:
        ; Pausa entre cada iteracion del ciclo
        mov ah, 86h
        mov cx, 0005h
        mov dx, 4240h
        int 15h

        ; Impresion  de numeros del 0 al 9
        mov al, contador

        mov ah, 09h   ; Función para imprimir un caracter
        mov cl, 01    ; Cantidad de veces que se imprimira el caracter
        mov bh, 0
        mov bl, 0Eh   ; Color del texto
        int 10h

        inc al
        mov contador, al

        ; Si el contador llega a 9, lo reiniciamos a 0
        cmp al, 57 ; ASCII de '9' es 57
            jg contador_reset

    read_key:
        ; Detectar teclas
        ; si al = 000h no hay tecla pulsada
        ; si al = 0FFh si hay tecla pulsada
        ; Para esto tenemos que llamar la rutina
        ; 0Bh en el registro ah

        ; Llamamos la rutina de deteccion de teclas
        mov ah, 0Bh
        int 21h

        ; Si no hay tecla pulsada, volvemos a mostrar el mensaje
        cmp al, 0000h
            jz loop
        jmp endless

        contador_reset:
            mov contador, 48
            jmp read_key

    endless:
        ; Terminar el programa
        mov ax, 4C00h
        int 21h
end