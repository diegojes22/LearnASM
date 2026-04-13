; ==={ readkey.asm }===
; Leer una tecla y terminar el programa
; @autor: D
; El siguiente programa es una introduccion para leer una tecla, para esto usaremos la funcion 0Bh 
; de la interrupcion 21h, la cual nos devuelve en el registro al el valor 0FFh si hay una tecla pulsada, 
; o el valor 000h si no hay ninguna tecla pulsada. El programa se ejecutara en un bucle infinito hasta 
; que se pulse una tecla, momento en el cual se terminara el programa.
.model small

.stack 100h       ; Tamaño de la pila

.data             ; Sección de datos
    msg db "Pulse una tecla para terminar el programa . . .", 0Ah,  "$"

.code             ; Sección de código
main proc
    ; Preparar segmento de datos
    ; Lo de siempre :|
    mov ax, @data
    mov ds, ax

    ; Para lograr el efecto de esperar a que se pulse una tecla, lo que hacemos es mostrar un mensaje 
    ; en pantalla, y luego entrar en un bucle infinito donde se detectan las teclas pulsadas, 
    ; si no hay ninguna tecla pulsada, el programa vuelve a mostrar el mensaje y vuelve a detectar 
    ; las teclas, y asi sucesivamente hasta que se pulse una tecla, momento en el cual el programa termina.
    
    ; El equiovalente en C a lo anterior es la funcion system("pause"), la cual muestra un mensaje en pantalla y 
    ; espera a que se pulse una tecla para continuar.
    loop:
        ; Imprimir mensaje
        mov ah, 09h
        mov dx, offset msg
        int 21h

        ; Pausa
        mov ah, 86h
        mov cx, 0005h
        mov dx, 4240h
        int 15h

        ; Detectar teclas
        ; si al = 000h no hay tecla pulsada
        ; si al = 0FFh si hay tecla pulsada
        ; Para esto tenemos que llamar la rutina
        ; 0Bh en el registro ah

        ; Ejemplo de lo anterior
        ; Llamamos la rutina de deteccion de teclas
        mov ah, 0Bh
        int 21h

        ; Si no hay tecla pulsada, volvemos a mostrar el mensaje
        cmp al, 0000h
            jz loop ; Si al = 000h, es decir, si no hay tecla pulsada, saltamos a la etiqueta loop, que es donde se muestra el mensaje
                    ; y asi se puede quedar toda la vida (o hasta que la computadora se quede sin bateria :P) hasta que el usuario pulse 
                    ; una tecla, momento en el cual se terminara el programa.

    ; Terminar el programa
    mov ax, 4C00h
    int 21h
end