; ==={ cursor.asm }===
; Cursor en pantalla
; @autor: D

; El siguiente programa es una introduccion a la manipulacion del cursor en pantalla,
; para esto usaremos la interrupcion 10h, que es la interrupcion de video, y la funcion 02h 
; para posicionar el cursor.
; Esto es similar a la funcion gotoxy de C, pero con la diferencia que en esta funcion se especifica
; la fila y la columna, mientras que en gotoxy se especifica la coordenada x e y.

.model small
.stack 100h

.data

.code
main proc
    ; Colocar el cursor en el lugar especificado
    mov ah, 02h         ; Servicio (0x02h -> llamar gotoxy)
    mov bh, 00h         ; pantalla (0 -> pantalla actual)
    mov dh, 0Ah         ; fila o y (10)
    mov dl, 20          ; numero de columna o x (20)
    int 10h

    ; Esto puede ser confuso, pero basicamente:
    ;  dh = eje Y
    ;  dl = eje X

    ; Para mostrar el efecyto haremos un delay.
    ; Para hacer un delay podemos llamar la interrupcion 15h, que es la interrupcion de 
    ; temporizador, y la funcion 86h, que es la funcion de espera, o tambien podemos
    ; hacer un ciclo.

    ; Tiempo de espera con la interrupcion de temporizador
    mov ah, 86h
    mov cx, 10h         ; tiempo de espera (1 segundo)
    int 15h

    ; Tiempo de espera con un ciclo
    ; Por defecto esto esta comentado para hacer solo un delay con el temporizador.
    ; Si quieren probar el delay con el ciclo, solo tienen que descomentar el siguiente 
    ; bloque de codigo y comentar el bloque anterior.
    
    ;mov cx, 0FFFFh        ; valor máximo para cx
    ;ciclo:
    ;    push cx
    ;    mov cx, 1000
    ;    cicl_2:
    ;        loop cicl_2
    ;    pop cx
    ;    loop ciclo

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

end