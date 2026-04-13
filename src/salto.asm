; ==={ salto.asm }===
; Saltos incondicionales
; @autor: D
; En este programa aprenderemos a saltar :D
; O dicho de forma mas profesional, aprenderemos a usar la instruccion jmp, la cual nos permite saltar 
; a una etiqueta sin ninguna condicion, es decir, siempre se ejecutara el salto. Esto es muy util para 
; crear bucles infinitos, o para saltar a una parte del codigo que no queremos ejecutar por alguna razon, etc.

.model small      ; Modelo de memoria pequeño
.stack 100h       ; Tamaño de la pila
.data             ; Sección de datos
    message db 'Nico y la china', 13, 10, '$'
    len EQU $ - message 

.code             ; Sección de código
main proc
    ; Inicializar segmento de datos
    ; Ya se la saben ■_■
    mov ax, @data
    mov ds, ax

    ; Esto de aqui es un salto el cual nos redirije a una parte del
    ; codigo donde esta la etiqueta referenciada.
    ; En este caso, la etiqueta a donde daremos el salto es "endless",
    ; por lo que ira directamente a "endless" y se terminara el programa,
    ; y por ende el mensaje no se imprimira.
    
    ; Esto se puede cambiar a cualquier otra etiqueta definida en este programa.
    ; Pruebalo! :D
    jmp endless

    ; Imprimir un mensaje
    starting:
        mov ah, 09h
        mov dx, offset message
        mov cx, len
        int 21h

    ; Terminar el programa
    endless:
        mov ah, 4Ch
        int 21h

    ; Terminar programa
    mov ax, 4C00h
    int 21h
end