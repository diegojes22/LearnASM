; ==={ tarea5.asm }===
; Aprendiendo a usar el registro SI (Source Index). Parte II
; @autor: D

; Actividad: Acceder a las posiciones de la cadena Hola y convertirla en mayuscula.
; Esto se hara con el registro SI.

.model small      ; Modelo de memoria pequeño
.stack 100h       ; Tamaño de la pila
.data             ; Sección de datos
    text db 'hola nico y la china$'
    len equ $ - text

.code             ; Sección de código
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Inicializar el registro SI con la direccion de la cadena.
    mov si, offset text

    mov cx, len
    repetir:
        push cx ; Guardar el valor de CX en la pila, ya que lo vamos a modificar y luego necesitaremos su valor original para el loop
        
        ; Convertir el caracter a mayuscula.
        ; Analicemos, las letras en la cadena estan en minusculas y queremos convertirlas a mayusculas, 
        ; para eso, debemos restar 32 al valor ascii de cada letra, ya que en la tabla ascii, las letras
        ; mayusculas estan 32 posiciones antes que las minusculas. Por ejemplo, la letra 'h' tiene un valor 
        ; ascii de 104, y la letra 'H' tiene un valor ascii de 72, y 104 - 32 = 72.
        mov al, [si] ; Cargar el caracter apuntado por SI en AL

        cmp al, '$'
            je fin_cadena ; Si el caracter es el simbolo de fin de cadena, saltar al final del programa

        sub al, 32    ; Restar 32 para convertirlo a mayuscula
        mov [si], al ; Guardar el caracter convertido de nuevo en la cadena

        ; Incrementar SI para apuntar al siguiente caracter de la cadena
        inc si ; Incrementar SI para apuntar al siguiente caracter de la cadena

        pop cx ; Recuperar el valor original de CX

        loop repetir ; Repetir el proceso para cada caracter de la cadena
        
    fin_cadena:
    ; Imprimimos el mensaje
    mov ah, 09h
    mov dx, offset text
    ;mov cx, len
    int 21h

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end