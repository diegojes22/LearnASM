; ==={ tarea3.asm }===
; Comparaciones y saltos condicionales
; @autor: D
; El siguiente programa es una introduccion a las comparaciones y saltos condicionales,
; para esto usaremos la instruccion cmp, que compara dos operandos, y las instrucciones
; de salto condicional, como je, jne, jg, jl, etc. Estas instrucciones permiten saltar a una
; etiqueta si se cumple una condicion, como por ejemplo si dos valores son iguales, o si
; un valor es mayor que otro, etc.

; Para mas informacion sobre las instrucciones de salto condicional, puedes
; consultar `doc/condicionales.md`.
.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos
    ; Aqui vamos a declarar algunas variables para comparar, y algunos mensajes para imprimir 
    ; dependiendo del resultado de la comparacion.
    msg1 db "Hola", 10, "$"
    msg2 db "Mundo!", 10, "$"

    endmsg db "Adios", 10, "$"

    compare db 2 ; Cambia este valor a 1, 2 o cualquier otro para probar las diferentes ramas del código

.code             ; Sección de código
main proc
    ; Inicializar segmento de datos
    mov ax, @data
    mov ds, ax

    ; Hora de comparar!
    cmp compare, 1
    je print_msg1 ; Vemos si el valor de compare es igual a 1, si es asi, saltamos a la etiqueta print_msg1

    cmp compare, 2 
    je print_msg2 ; Vemos si el valor de compare es igual a 2, si es asi, saltamos a la etiqueta print_msg2

    ; Terminar programa
    endless:
        mov ah, 09h
        mov dx, offset endmsg
        int 21h

        mov ax, 4C00h
        int 21h

    ; Esta seccion es para el caso de que el valor de compare no sea ni 1 ni 2, en ese caso, se 
    ; imprimira el mensaje de despedida y se terminara el programa.
    print_msg1:
        mov ah, 09h
        mov dx, offset msg1
        int 21h
        jmp endless

    ; Esta seccion es para el caso de que el valor de compare sea 2, en ese caso, se imprimira el 
    ; mensaje de "Mundo!" y se terminara el programa.
    print_msg2:
        mov ah, 09h
        mov dx, offset msg2
        int 21h
        jmp endless

end