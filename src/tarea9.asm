; @autor: D

.model small      ; Modelo de memoria pequeño
.stack 100h       ; Tamaño de la pila

; ==== Macros
; Imprimir un mensaje en pantalla desde una variable
print macro msg
    mov ah, 09h
    mov dx, offset msg
    int 21h
endm

; Dirige el cursor a una coordenada en la pantalla
gotoxy macro x, y
    mov ah, 02h
    mov bh, 0
    mov dh, y
    mov dl, x
    int 10h
endm

readkey macro
    mov ah, 01h
    int 21h

    mov user_opt, al
endm

; === Variables
.data             ; Sección de datos
    title_prog db "   Useless Program   $"
    title_menu2 db "   Read Text   $"

    read_text_msg db "Ingrese un texto de maximo 5 caracteres: $"
    pause_msg db "Pulse una tecla para continuar . . .$"
    text_in_mem db "Texto guardado: $"

    frame_hchar db "-$"
    frame_vchar db "|$"

    menu_opt1 db "1. Ingresar texto$"
    menu_opt2 db "2. Animar texto$"
    menu_opt3 db "3. Salir del programa$"
    input_pin db ">_ $"

    user_opt db 0

    texto db "     $"
    animated_text db "     $"
    len equ 5

    len_cnt db 0

.code             ; Sección de código

; === Procedimientos
; Inicializar segmento de datos.
; Si se usan variables debe ser lo primero en ser llamado
init_data PROC
    mov ax, @data
    mov ds, ax
ret
endp

; Dibuja un cuadro en la pantalla usando caracteres ascii
; para simular la pantalla de un menu
draw_frame PROC
    mov cx, 24
    vertical:
        gotoxy 0, cl
        print frame_vchar
        gotoxy 70, cl
        print frame_vchar
    loop vertical

    mov cx, 70
    horizontal:
        gotoxy cl, 0
        print frame_hchar
        gotoxy cl, 24
        print frame_hchar
    loop horizontal
ret
endp

; Limpiar pantalla.
; Recomendable llamar cuando se inicie el programa
cls PROC
    mov ah, 06h
    mov al, 00h
    mov bl, 00h
    mov bh, 07h
    mov ch, 00
    mov cl, 00
    mov dh, 24
    mov dl, 79
    int 10h
ret
endp

pause proc
    print pause_msg
    mov ah, 01h
    int 21h
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


; === Dibujado de MENUS
main_menu proc
    call cls

    ; Marco y titulo
    call draw_frame
    gotoxy 10, 0
    print title_prog

    ; Texto ingresado por el usuario
    gotoxy 10, 19
    print text_in_mem
    gotoxy 10, 20
    print texto

    ; Dibujar opciones
    gotoxy 5, 5
    print menu_opt1
    gotoxy 5, 7
    print menu_opt2
    gotoxy 5, 9
    print menu_opt3

    gotoxy 8, 13
    print input_pin

    ; Leer Tecla
    readkey
ret
endp

menu_2 proc
    ; Marco exterior
    call cls
    call draw_frame
    gotoxy 10, 0
    print title_menu2

    ; Dibujar elementos
    gotoxy 5, 5
    print read_text_msg
    gotoxy 8, 7
    print input_pin

    ; Leer texto
    call read

ret
endp

menu_3 proc
    mov cx, 10          ; Número de ciclos de animación
    anim_ciclos:
        call cls
        gotoxy 0, 0

        ; Índice para rotar
        mov ax, 0
        
        ; Por cada carácter de la longitud (5)
        mov bx, 0
        anim_chars:
            cmp bx, len
                jge siguiente_ciclo
            
            ; Calcular posición de carácter rotado
            mov al, bl
            add al, len_cnt  ; Rotar según contador
            mov dl, al
            mov ax, dx
            xor dx, dx
            mov cx, len
            div cx
            mov al, dl       ; AL tiene el índice rotado
            
            ; Cargar carácter de texto
            mov si, offset texto
            add si, ax
            mov al, [si]
            
            ; Mostrar carácter
            ; Lo hice con la interrupcion 21h porque
            ; usar 10h me daba errores.
            mov ah, 02h
            mov dl, al
            int 21h

            inc bx
            jmp anim_chars
        
        siguiente_ciclo:
        
        ; Delay
        mov cx, 0FFFFh
        delay_loop:
            push cx
            mov cx, 03h
            internal_delay:
                loop internal_delay
            pop cx
            loop delay_loop
        
        ; Detectar tecla presionada
        mov ah, 0Bh
        int 21h

        cmp al, 0FFh        ; ESC para salir
            je go_back_from_m3
        
        ; Incrementar contador de rotación
        inc len_cnt
        
        loop anim_ciclos

    go_back_from_m3:
    ret
endp

; === Main ===
main proc
    ; Codigo aqui
    call init_data

    ; Menu principal (incluye la funcion de leer tecla)
    main_loop:
        call main_menu

        cmp user_opt, '1'
            je m2
        cmp user_opt, '2'
            je m3
        cmp user_opt, '3'
            je endless
        jmp main_loop

    m2:
        call menu_2
        jmp main_loop
    m3:
        call menu_3
        jmp main_loop

    ; Terminar el programa
    endless:

    gotoxy 0, 0
    call cls
    mov ax, 4C00h
    int 21h
endp
end main