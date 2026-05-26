; @autor: D
; Actividad:
;   Crear un prgrama que lea un texto y quite los espacios que pueda haber en el mismo
.model small

.stack 100h

; ====== Macros
; Imprimir un mensaje en pantalla desde una variable
print macro msg
    mov ah, 09h
    mov dx, offset msg
    int 21h
endm

; ====== Variables
.data
    source_text     db  "          $"
    dest_text       db  "          ", 10, '$'

    len             equ 0Ah
    len_cnt         db  00h

    input_msg       db  "Ingresa un texto (Max 10 letras): ", 10, 09, "$"
    input_pin       db  ">$"
    out_msg         db  "Texto sin espacios: $"

    endl            db  10, '$'

.code

; ====== Procedimientos
; Inicializar segmento de datos.
; Si se usan variables debe ser lo primero en ser llamado
init_data PROC
    mov ax, @data
    mov ds, ax
ret
endp

read proc
    mov di, offset source_text
    mov len_cnt, 00h

    read_loop:
        ; leer del teclado
        mov ah, 01
        int 21h

        ; Comparar tecla
        cmp al, 0Dh
            je go_back
        cmp len_cnt, len
            jge go_back

        mov [di], al
        inc di
        inc len_cnt

        jmp read_loop

    go_back:
ret
endp

trim proc
    mov si, offset source_text
    mov di, offset dest_text

    mov len_cnt, 00h

    trim_loop:
        mov al, [si]

        cmp al, ' '
            je continue
        
        mov [di], al
        inc di

        continue:

        cmp len_cnt, len
            jge go_back_1

        inc si
        inc len_cnt
        jmp trim_loop

    go_back_1:
ret
endp

; ====== Main
main proc
    ; Codigo aqui
    call init_data

    ; Leer texto
    print input_msg
    print input_pin

    call read
    
    ; Quitar espacios
    call trim

    ; Mostrar texto resultante
    print endl
    print out_msg
    print dest_text

    print endl

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

endp
end main