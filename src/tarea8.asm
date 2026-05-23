; ==={ tarea8.asm }===
; Comparaciones y saltos condicionales - Versión con Macros y Procedimientos
; @autor: D
; Esta es una versión mejorada de tarea3.asm que utiliza macros y procedimientos
; para hacer el código más modular, reutilizable y mantenible.

; Los macros eliminan la repetición de código para operaciones comunes como imprimir,
; mientras que los procedimientos agrupan la lógica de acuerdo a su propósito.

.model small      ; Modelo de memoria pequeño
.stack 100h       ; Tamaño de la pila

; ===== DEFINICIÓN DE MACROS =====
; Macro para imprimir un mensaje usando INT 21h (función 09h)
; Parámetro: msg - offset del mensaje a imprimir
printMsg MACRO msg
    mov ah, 09h
    mov dx, offset msg
    int 21h
ENDM

; ===== SECCIÓN DE DATOS =====
.data
    msg1    db "Hola", 10, "$"
    msg2    db "Mundo!", 10, "$"
    endmsg  db "Adios", 10, "$"
    
    compare db 2 ; Cambia este valor a 1, 2 o cualquier otro para probar

; ===== SECCIÓN DE CÓDIGO =====
.code

; Procedimiento: exit_program
; Propósito: Terminar el programa de forma ordenada
; Entrada: ninguna
; Salida: termina el programa
exit_program PROC
    mov ax, 4C00h
    int 21h
exit_program ENDP

; Procedimiento: print_msg1
; Propósito: Imprimir el primer mensaje
; Entrada: nada (usa macro)
; Salida: imprime msg1 en pantalla
print_msg1 PROC
    printMsg msg1
    call exit_program
print_msg1 ENDP

; Procedimiento: print_msg2
; Propósito: Imprimir el segundo mensaje
; Entrada: nada (usa macro)
; Salida: imprime msg2 en pantalla
print_msg2 PROC
    printMsg msg2
    call exit_program
print_msg2 ENDP

; Procedimiento: print_default
; Propósito: Imprimir mensaje de despedida (caso por defecto)
; Entrada: nada (usa macro)
; Salida: imprime endmsg en pantalla
print_default PROC
    printMsg endmsg
    call exit_program
print_default ENDP

; Procedimiento principal: main
; Propósito: Ejecutar la lógica de comparación y llamar a procedimientos adecuados
main PROC
    ; Inicializar segmento de datos
    mov ax, @data
    mov ds, ax

    ; Realizar comparaciones y saltar a procedimientos apropiados
    cmp compare, 1
    je call_msg1        ; Si compare == 1, salta a call_msg1

    cmp compare, 2
    je call_msg2        ; Si compare == 2, salta a call_msg2

    ; Si no cumple ninguna condición, ir al caso por defecto
    jmp call_default

call_msg1:
    call print_msg1

call_msg2:
    call print_msg2

call_default:
    call print_default

main ENDP

end main
