; @autor: D
; Actividad:
;    Crear un programa que que lea una cadena del teclado, el programa debe
;    identificar las vocales de la cadena leida y estas vocales seran mostradas.

.model small      ; Modelo de memoria pequeño
.stack 100h       ; Tamaño de la pila

; ====== Macros
; Imprimir un mensaje en pantalla desde una variable
print macro msg
    mov ah, 09h
    mov dx, offset msg
    int 21h
endm

.data             ; Sección de datos
; ====== Variables
    texto db "          $"
    len equ 0Ah
    len_cnt db 00h

    input_msg db "Ingresa un texto (Max 10 letras): ", 10, 09, "$"
    input_pin db ">$"

    vocales_msg db "Vocales encoontradas en el texto:", 10, '$'

    tabl db 09h, '$'
    endl db 0Ah, '$'

.code             ; Sección de código
; ====== Procedimientos
; Inicializar segmento de datos.
; Si se usan variables debe ser lo primero en ser llamado
init_data PROC
    mov ax, @data
    mov ds, ax
ret
endp

read proc
    mov di, offset texto
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

; ====== Main
main proc
    call init_data

    ; Leer texto
    print input_msg
    print input_pin
    call read

    print vocales_msg

    ; Extraer e imprimir las vocales
    mov len_cnt, 0
    mov si, offset texto
    ciclo_vocales:
        ; Comparar vocales (no hagan esto en casa)
        mov al, [si]
        cmp al, 'a'
            je vocal
        cmp al, 'e'
            je vocal
        cmp al, 'i'
            je vocal
        cmp al, 'o'
            je vocal
        cmp al, 'u'
            je vocal
        cmp al, 'A'
            je vocal
        cmp al, 'E'
            je vocal
        cmp al, 'I'
            je vocal
        cmp al, 'O'
            je vocal
        cmp al, 'U'
            je vocal
        
        ; Comparacion del contador para salir del ciclo
        cmp len_cnt, len
            jge salida
        
        continuar_vocales:
        inc len_cnt
        inc si

        jmp ciclo_vocales

    ; Si se detecta una vocal en las condiciuonales, venimos hasta aca para imprimirla
    vocal:
        print tabl
        mov ah, 09
        mov bl, 06h
        mov cx, 1
        int 10h

        print endl

        jmp continuar_vocales

    ; Terminar el programa
    salida:
    mov ax, 4C00h
    int 21h

endp
end main