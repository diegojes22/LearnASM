; ==={ Tarea2.asm }===
; Caracter colorido
; @autor: D

; Imprimir un solo caracter en pantalla, usando la funcion 09h
; de la interrupcion 10h, pero con la diferencia de un
; cambio de color en cada x tiempo durante n veces.

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos

.code             ; Sección de código
main proc
    ; Primero moveremos el cursor al centro para que el efecto se note mas
    mov ah, 02h   ; Función para mover el cursor
    mov bh, 0
    mov dh, 12
    mov dl, 40

    int 10h

    ; Efecto de cambio
    mov cx, 00Fh  ; Vamos a hacer un cambio de color de 15 veces, ademas de colocar 15 colores diferentes
    color_change:
        push cx

        mov bl, cl    ; Para evitar problemas despues, defino el color en base al valor guardado en el ciclo

        mov ah, 09h   ; Función para imprimir un caracter
        mov al, 'H'   
        mov cl, 01    
        mov bh, 0
        int 10h

        ; Delay
        mov cx, 00FFFh
        delay_1:
            push cx

            mov cx, 100
            sub_delay_1:
                loop sub_delay_1

            pop cx
            loop delay_1

        pop cx
        loop color_change

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end