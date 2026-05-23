; @autor: D
; Plantilla basica para un programa de turboensamblador x86
; en sistemas tipo DOS
; Cada vez que inicies un nuevo programa es recomendable
; copiar esta plantilla y modificarla segun tus necesidades

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos
    user_text db "                    $"
    len equ $ - user_text

    msg1 db "Ingrese un texto: $"
    msg2 db "Numero de ases: $"
    counter db 0
    ases db 48

.code             ; Sección de código
main proc
    ; Iniciar segmento de datos
    mov ax, @data
    mov ds, ax

    ; Imprimir mensaje
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    ; Apuntar a la cadena donde vamos a guardar el texto
    mov di, offset user_text

    ciclo:
        ; Leer del teclado
        mov ah, 01h
        int 21h

        ; Ver si se presiono Enter
        cmp al, 0Dh
            je salida
        ; Salida de seguridad en caso de que se exceda el tamaño de la cadena
        cmp counter, len
            jge salida

        ; Guardar en la cadena de destino
        ;mov ah, 0
        mov [di], al
        inc di
        inc counter

        ; Comprobar las teclas a presionadas
        cmp al, 'a'
            je add_a
        cmp al, 'A'
            je add_a

        jmp ciclo

        add_a:
            inc ases
            jmp ciclo

    salida:
    ; limpiar pantalla
    mov ah, 06h
    mov al, 00h
    mov ch, 00h
    mov cl, 00h
    mov dl, 79
    mov dh, 24
    mov bh, 0Fh
    int 10h

    ; Ir a (0, 0)
    mov ah, 02h
    mov dh, 0
    mov dl, 0
    mov bh, 00h
    int 10h

    ; Mostrar mensaje
    mov ah, 09h
    mov dx, offset user_text
    mov cx, len
    int 21h

    ; Mostrar numero de ases
    ; Ir a (0, 0)
    mov ah, 02h
    mov dh, 5
    mov dl, 5
    mov bh, 00h
    int 10h
    
    mov ah, 09h
    mov dx, offset msg2
    int 21h

    mov ah, 09h
    mov al, ases
    mov bh, 00h
    mov bl, 07h
    mov cx, 01h
    int 10h
    
    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end