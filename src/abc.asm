; ==={ abc.asm }===
; Mostrar el abecedario completo en pantalla
; @autor: D

; Lo que debemos hacer es imprimir las letras del abecedario
; mediante un ciclo.
; Facil

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos

.code             ; Sección de código
main proc
    ; Para esto hay que saber que el codigo ascii de la Z es 90, y el de la A es 65, por lo que el abecedario completo
    ; va desde el 65 hasta el 90, ambos inclusive. Por lo tanto, el ciclo debe ir desde el 65 hasta el 90.

    mov cx, 26      ; El abecedario tiene 26 letras, por lo que el ciclo se repetira 26 veces
    print_abc:
        ; metemos el valor de cx en al
        ; y luego le sumamos 64 para que los valores
        ; coincidan con los codigos ascii de las letras mayusculas, es decir, de la A a la Z
        mov al, cl
        add al, 64      ; Para pasar de un valor de 1 a 26, a un valor de 65 a 90, es decir, de A a Z

        mov ah, 09h     ; Funcion para imprimir un caracter: llammosla PRINT CHAR
        mov bh, 0
        mov bl, 0Ah     ; Cambiemos el color a un verde brillante
        int 10h
        
        loop print_abc  ; Repetimos el ciclo

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end