.model small
.stack 100h

.data
    val1 db 0
    val2 db 0

.code
main proc
    mov ax, @data
    mov ds, ax

    mov val2, 0             ; Inicializamos el contador externo
    external_loop:
        mov val1, 0             ; <--- CRUCIAL: Reiniciar val1 para cada ciclo externo

        internal_loop:
            mov ah, 01h
            mov ch, val1
            mov cl, val2
            int 10h

            ; Tiempo de espera (Ajustado para ser visible pero no eterno)
            mov ah, 86h
            mov cx, 0Fh         
            mov dx, 93E0h       
            int 15h

            inc val1            ; Incremento directo de la variable
            cmp val1, 7
            jle internal_loop

        inc val2                ; Incremento directo de la variable
        cmp val2, 7
        jle external_loop

    ; Hacer el cursor invisible al terminar
    mov ah, 01h 
    mov ch, 20h
    mov cl, 00h
    int 10h
    
    ; Terminar el programa de forma segura
    mov ax, 4C00h
    int 21h
main endp                   ; Es buena práctica cerrar el procedimiento
end main                    ; Indicar el punto de entrada