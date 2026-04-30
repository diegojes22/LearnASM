; Borrar la pantalla
; En una esquina aparece una letra
; En la otra aparece otra letra
; Ambas letras "caminaran"

; Ruta del archivo:
; D:\CodeProjects\LearnASM

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos
    ; Coordenada de la letra 1
    x1 db 0
    y1 db 0

    ; Coordenada de la letra 2
    x2 db 0
    y2 db 24

.code             ; Sección de código
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 24
    mainloop:
    push cx   

    ; Borrar pantalla
    mov ah, 06h
    mov al, 00h
    mov ch, 00h
    mov cl, 00h
    mov dl, 79
    mov dh, 24
    mov bh, 0Fh
    int 10h

    ; Posicion letra 1
    mov ah, 02h
    mov dh, y1
    mov dl, x1
    mov bh, 00h
    int 10h

    ; Dibujar letra 1
    mov ah, 09h
    mov al, "A"
    mov cx, 1
    mov bl, 0Fh
    int 10h

    inc y1
    inc x1

    ; Posicion Letra 2
    mov ah, 02h
    mov bh, 0
    mov dh, y2
    mov dl, x2
    int 10h

    ; Dibujar letra 2
    mov ah, 09h
    mov al, "B"
    mov cx, 1
    mov bh, 0
    mov bl, 0Fh
    int 10h

    inc x2
    dec y2

    ; Pausa
    mov cx, 08FFh
    pausa1:
        push cx
        mov cx, 0FFh
        subpausa1:
            loop subpausa1
        pop cx
        loop pausa1


    pop cx
    loop mainloop

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end