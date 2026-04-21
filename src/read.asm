; ==={ read.asm }===
; Leer una tecla del teclado y mostrarla en la pantalla
; @autor: D

; Vamos a aprender a utilizar la interrupcion 09h y 21h
; para leer una tecla del teclado y mostrarla en la 
; pantalla utilizando la interrupcion 10h para mover el cursor.

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos
    msg db "Introduce una letra: $"

.code             ; Sección de código
main proc
    ; Inicializar segmento de datos
    mov ax, @data
    mov ds, ax

    ; Mostrar el mensaje
    mov ah, 09h
    lea dx, msg
    int 21h

    ; Leer del teclado
    mov ah, 01h
    int 21h

    ; Mover el cursor
    mov ah, 02h         ; Servicio (0x02h -> llamar gotoxy)
    mov bh, 00h         ; pantalla (0 -> pantalla actual)
    mov dh, 0Ah         ; fila o y (10)
    mov dl, 20          ; numero de columna o x (20)
    int 10h

    ; Mostrar el valor ingresado
    mov ah, 0ah
    mov bh, 00h
    mov bl, 0Ah
    mov cx, 1
    int 10h


    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end