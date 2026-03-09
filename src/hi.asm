; ==={ hi.asm }===
; Un programa basico que imprime un mensaje en pantalla
; @autor: D

; El siguiente programa es la introduccion para imprimir un mensaje en pantalla,
; para esto usaremos el segmento de datos para almacenar el mensaje a imprimir,
; o en otras palabras, variables.

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos
    msg db 'Nico y la China$' ; Mensaje a imprimir

.code             ; Sección de código
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Imprimir el mensaje
    mov dx, offset msg
    mov ah, 09h
    int 21h

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end