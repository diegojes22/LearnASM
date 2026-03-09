; ==={ letra.asm }===
; @autor: D
; Imprimir un solo caracter en pantalla
; usando la funcion 09h de la interrupcion 10h

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos

.code             ; Sección de código
main proc
    ; Codigo aqui
    mov ah, 09h   ; Función para imprimir un caracter
    mov al, 'H'   ; Caracter a imprimir, se recomienda colocar su codigo ascii
    mov cl, 01    ; Cantidad de veces que se imprimira el caracter
    mov bh, 0
    mov bl, 0Eh   ; Color del texto
    int 10h

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end