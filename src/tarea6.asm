; ==={ Tarea 6 }===
; Copiando solo ciertos caracteres de un texto a otro
; @autor: D

; Lo que vamos hacer en este programa es copiar solo ciertos caracteres de un texto a
; otro utilizando los registros de indice SI y DI.
; Para esto vamos a copiar cualquier valor diferente a la 'a'.

.model small
.stack 100h
.data
    msg1 db "Nico y Anelis$"  ; No te enojas Nico?
    msg2 db "espacio$"

    len equ $ - msg1

.code
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Inicializar registros indice
    mov si, offset msg1
    mov di, offset msg2

    mov cx, len
    repetir:
        mov al, [si]
        cmp al, 'a'
            je saltar
        
        mov [di], al
        inc di

        saltar:
        inc si

        mov al, [di]
        cmp al, '$'
            je continuar

        dec cx
        cmp cx, 0
            jne repetir

    continuar:

    mov ah, 09h
    mov dx, offset msg2
    int 21h
    
    ; terminar el programa
    mov ax, 4C00h
    int 21h
end