; ==={ tarea4.asm }===
; Comparaciones con 3 opciones y un else "raro"
; @autor: D
; Esto es una vareacion de la tarea anterior (tarea4.asm) la cual es un poco mas compleja 
; ya que ahora tenemos 3 opciones para comparar, y un else "raro" que se ejecuta si ninguna 
; de las opciones anteriores se cumple, el cual imprime un mensaje de error y luego un
; mensaje de despedida antes de terminar el programa.

.model small      ; Modelo de memoria pequeño

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos
    ; Aqui solo declaramos los mensajes a imprimir dependiendo 
    ; del resultado de la comparacion, y una variable para comparar.
    msg1 db "Opcion 1", 10, "$"
    msg2 db "Opcion 2", 10, "$"
    msg3 db "Opcion 3", 10, "$"

    error_msg db "Valor no valido", 10, "$"
    endmsg db "Adios, fue un gustazo correr en tu PC :)", 10, "$"

    compare db 1 ; Cambia este valor a 1, 2 o cualquier otro para probar las diferentes ramas del código

.code             ; Sección de código
main proc
    ; Inicializar segmento de datos
    mov ax, @data
    mov ds, ax

    ; Hora de comparar!
    cmp compare, 1
    je print_msg1

    cmp compare, 2
    je print_msg2

    cmp compare, 3
    je print_msg3

    ; Aqui hacemos lo siguiente, si ninguna condicion se cumple, es decir, si el valor de compare 
    ; no es ni 1, ni 2, ni 3, entonces se ejecutara el siguiente codigo (flujo normal), el cual 
    ; imprime un mensaje de error y luego un mensaje de despedida antes de terminar el programa.

    ; Valor no valido
    mov ah, 09h
    mov dx, offset error_msg
    int 21h

    ; Terminar programa
    endless:
        ; Un mensaje de despedida antes de terminar el programa
        mov ah, 09h
        mov dx, offset endmsg
        int 21h

        mov ax, 4C00h
        int 21h
    
    ; Seccion para imprimir mensajes de acuerdo a la opcion seleccionada
    print_msg1:
        mov dx, offset msg1
        jmp printf

    print_msg2:
        mov dx, offset msg2
        jmp printf

    print_msg3:
        mov dx, offset msg3
        jmp printf

    ; Funcion para imprimir mensajes (creo que una macro seria una mejor opcion).
    ; En vez de repetir el mismo codigo para imprimir cada mensaje, lo que hacemos es saltar a 
    ; una etiqueta llamada printf, la cual se encarga de imprimir el mensaje que se encuentra en 
    ; dx, y luego termina el programa.
    printf:
        mov ah, 09h
        int 21h
        jmp endless

end