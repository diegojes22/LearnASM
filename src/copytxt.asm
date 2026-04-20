; ==={ copytxt.asm }===
; Copiando un texto a otro
; @autor: D

; Vamos a copiar cadenas :D
; Para esto es necesario usar los registros de indice z

.model small      ; Modelo de memoria pequeño
.stack 100h       ; Tamaño de la pila
.data             ; Sección de datos
    txt1 db 'Nico$'
    txt2 db '$$$$$' ; cadena vacia donde vamos a copiar la letra

    len equ $ - txt1

.code             ; Sección de código
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    mov si, offset txt1
    mov di, offset txt2

    mov cx, len
    repetir:
        mov ah, [si]
        mov [di], ah ; Copiar el byte de txt1 a txt2  

        inc si
        inc di

        sub cx, 1

        cmp cx, 0
        jne repetir

    end_loop:
    ; Imprimir
    mov ah, 09h
    mov dx, offset txt2
    mov cx, len
    int 21h

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end