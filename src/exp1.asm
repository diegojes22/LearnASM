; ==={ exp1.asm }===
; REPASO PARA UN EXAMEN UNIVERSITARIO
; @autor: D

; Ejercicio: Crear un programa el cual imprima constantemente
; las letras A B C hasta que el usuario presione una tecla.
; Mas contexto al final del archivo ↓

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos
    contador db 65

.code             ; Sección de código
main proc
    ; Codigo aqui
    resetear:
        mov contador, 65

    ciclo:
        ; Imprimir letra
        mov ah, 09
        mov cx, 1
        mov al, contador 
        mov bh, 0
        mov bl, 0Fh
        int 10h

        ; Leer tecla
        mov ah, 0Bh
        int 21h

        cmp al, 00FFh
            je final

        inc contador

        ; Delay
        mov cx, 0FFFh
        delay1:
            push cx
            mov cx, 00FFh
            subdelay1:
                loop subdelay1
            pop cx
            loop delay1

        cmp contador, 67
            jle ciclo
            jge resetear

    final:
    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end

; Contexto: El dia 29 de Abril del 2024, en la materia de Lenguajes de Interfaz
; (la cual trata del Lenguaje Ensamblador) tendre un examen, por lo que este 
; ejercicio es un pequeño repaso escrito en menos de 30 minutos.
; Ya que estoy lo agrego al repositorio esperando a que sirva de algo.